<?php

namespace App\Http\Controllers;

use App\Models\AntecedentExamen;
use App\Models\Caisse;
use App\Models\Examen;
use App\Models\Patient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ExamenController extends Controller
{
    public function insertExamen(Request $request)
    {
        // Check if IDPatient is sent (existing patient from Search)
        if (isset($request->patient['IDPatient']) && $request->patient['IDPatient'] != null) {
            $patient = Patient::find($request->patient['IDPatient']);

            // Optional: Update patient info if needed, or just partial update.
            // For now, we assume if ID is sent, we use that patient.
            if (! $patient) {
                // Fallback if ID sent but not found (rare)
                $patient = PatientController::store($request->patient);
            }
        }

        // Store Caisse (Payment Header)
        // Request now contains 'paiment' with keys: net, tva, ttc, verse, reset
        $caisse = CaisseController::store($request->paiment);

        foreach ($request->examens as $exam) {
            $examen = new Examen;
            $examen->radiologue_id = $exam['radiologue'];
            $examen->patient_id = $patient->IDPatient;
            if ($exam['produit'] != 0 && $exam['produit'] != null) {
                $examen->produit_id = $exam['produit'];
            }
            $examen->etude_id = $exam['etude'];
            $examen->service_id = $exam['service'];
            $examen->UIExam = Auth::user()->id;
            $examen->save();

            // Store Payment Details using the new structure
            // $exam['tarif'] is now Gross Price
            // $exam['remise'] is now Discount Amount
            // $exam['calcRemise'] is Percentage Value (if applicable)
            // $exam['typeRemise'] is 'p' or 'm'
            PaiementController::store(
                $exam['tarif'],
                $exam['remise'],
                $exam['calcRemise'],
                $exam['typeRemise'],
                $examen->IDExamen,
                $caisse->IDCaisse
            );

            if (isset($request->patient['antecedents']) && count($request->patient['antecedents']) > 0) {
                foreach ($request->patient['antecedents'] as $item) {
                    $antecedantE = new AntecedentExamen;
                    $antecedantE->antecedent_id = $item;
                    $antecedantE->examen_id = $examen->IDExamen;
                    $antecedantE->save();
                }
            }
        }
    }

    public function detailExamen($IDCaisse)
    {
        // 1. Get Caisse and its totals (calculated from payments)
        $caisse = Caisse::find($IDCaisse);
        // Note: Summing via query if needed, but Caisse model has stored totals.
        // Let's trust Caisse model totals for existing columns, but recalculate distinct sums if needed.

        // 2. Get Exam IDs from Payments linked to this Caisse
        $paiements = \App\Models\Paiement::where('caisse_id', $IDCaisse)->get();
        $examIds = $paiements->pluck('examen_id');

        // 3. Fetch Full Exam Details
        $examens = Examen::whereIn('examens.IDExamen', $examIds)
            ->leftJoin('users', 'examens.radiologue_id', '=', 'users.id')
            ->leftJoin('services', 'examens.service_id', '=', 'services.IDService')
            ->leftJoin('etudes', 'examens.etude_id', '=', 'etudes.IDEtude')
            ->leftJoin('produits', 'examens.produit_id', '=', 'produits.IDProduit')
            ->leftJoin('paiements', function ($join) use ($IDCaisse) {
                $join->on('examens.IDExamen', '=', 'paiements.examen_id')
                    ->where('paiements.caisse_id', '=', $IDCaisse);
            })
            ->select(
                'examens.*',
                'paiements.montantantVerserment',
                'paiements.remiseMontant',
                'services.libelleService',
                'etudes.libelleEtude',
                'users.nom',
                'users.prenom',
                'produits.libelleProduit'
            )
            ->get();

        // 4. Fetch Patient (Assuming all exams in one Caisse belong to same patient)
        $patient = null;
        if ($examens->isNotEmpty()) {
            $patientId = $examens->first()->patient_id;
            $patient = Patient::leftJoin('wilayas', 'wilayas.IDWilaya', 'patients.wilaya_id')
                ->where('patients.IDPatient', $patientId)
                ->select('patients.*', 'wilayas.wilaya')
                ->first();
        }

        return ['patient' => $patient, 'examens' => $examens, 'caisse' => $caisse];
    }

    public function destroy($id)
    {
        $examen = Examen::find($id);
        if (! $examen) {
            return response()->json(['error' => 'Examen not found'], 404);
        }

        // Find related Paiement to get Caisse ID
        $paiement = \App\Models\Paiement::where('examen_id', $id)->first();
        $caisseId = $paiement ? $paiement->caisse_id : null;

        // Delete dependencies
        \App\Models\AntecedentExamen::where('examen_id', $id)->delete();
        if ($paiement) {
            $paiement->delete();
        }
        $examen->delete();

        // Recalculate Caisse if it exists
        if ($caisseId) {
            $this->recalculateCaisse($caisseId);
        }

        return response()->json(['success' => true]);
    }

    public function storeToCaisse(Request $request)
    {
        // 1. Create Examen
        $examen = new Examen;
        $examen->radiologue_id = $request->input('radiologue');
        $examen->patient_id = $request->input('patient_id');
        $examen->etude_id = $request->input('etude');
        $examen->service_id = $request->input('service');
        $examen->UIExam = Auth::user()->id;
        $examen->save();

        // 2. Create Paiement linked to existing Caisse
        PaiementController::store(
            $request->input('tarif'), // Gross Price
            $request->input('remise'), // Discount Amount
            $request->input('calcRemise'), // Percentage
            $request->input('typeRemise'), // Type
            $examen->IDExamen,
            $request->input('caisse_id')
        );

        // 3. Recalculate Caisse
        $this->recalculateCaisse($request->input('caisse_id'));

        return response()->json(['success' => true]);
    }

    public function update(Request $request, $id)
    {
        $examen = Examen::find($id);
        if (!$examen) return response()->json(['error' => 'Not found'], 404);

        // Update Examen Fields
        $examen->radiologue_id = $request->input('radiologue');
        $examen->etude_id = $request->input('etude');
        $examen->service_id = $request->input('service');
        if ($request->filled('produit')) {
             $examen->produit_id = $request->input('produit');
        } else {
             $examen->produit_id = null;
        }
        $examen->save();

        // Update Payment Fields
        $paiement = \App\Models\Paiement::where('examen_id', $id)->first();
        if ($paiement) {
             // Logic similar to PaiementController::store but updating
             $paiement->montantantVerserment = $request->input('tarif');
             $paiement->remiseMontant = $request->input('remise');
             if ($request->input('typeRemise') == 'p') {
                 $paiement->remisePourcent = $request->input('calcRemise');
             } else {
                 $paiement->remisePourcent = null;
             }
             $paiement->save();
             
             $this->recalculateCaisse($paiement->caisse_id);
        }

        return response()->json(['success' => true]);
    }

    private function recalculateCaisse($caisseId)
    {
        $caisse = Caisse::find($caisseId);
        if ($caisse) {
            // Calc Totals
            $paiements = \App\Models\Paiement::where('caisse_id', $caisseId)->get();
            $totalGross = $paiements->sum('montantantVerserment');
            $totalRemise = $paiements->sum('remiseMontant');
            $net = $totalGross - $totalRemise;

            $caisse->net = $net;
            $caisse->ttc = $net + $caisse->tva; // Kept fixed TVA

            // Recalc Reset
            $totalVerse = \App\Models\Versement::where('caisse_id', $caisseId)->sum('versement');
            $caisse->verse = $totalVerse;
            $caisse->reset = $caisse->ttc - $totalVerse;

            // Update State
            $caisse->etatCaisse = ($caisse->reset > 0) ? 2 : 1;

            $caisse->save();
        }
    }
}
