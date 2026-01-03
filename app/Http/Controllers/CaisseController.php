<?php

namespace App\Http\Controllers;

use App\Models\Caisse;
use App\Models\Versement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class CaisseController extends Controller
{
    public function index(Request $request)
    {
        $query = Caisse::leftJoin('paiements', 'caisses.IDCaisse', '=', 'paiements.caisse_id')
            ->leftJoin('examens', 'paiements.examen_id', '=', 'examens.IDExamen')
            ->leftJoin('patients', 'patients.IDPatient', '=', 'examens.patient_id')
            ->select(
                'patients.IDPatient',
                'patients.nomP',
                'patients.prenomP',
                'caisses.created_at', // Note: This might be ambiguous if multiple exams. Usually Caisse date is better if available, but Examen date is requested.
                'caisses.ttc',
                'caisses.reset',
                'caisses.IDCaisse'
            )
            ->groupBy('caisses.IDCaisse', 'patients.IDPatient', 'patients.nomP', 'patients.prenomP', 'caisses.ttc', 'caisses.reset');

        // Filter by Patient Name
        if ($request->filled('nom')) {
            $query->where('patients.nomP', 'like', '%'.$request->nom.'%');
        }
        if ($request->filled('prenom')) {
            $query->where('patients.prenomP', 'like', '%'.$request->prenom.'%');
        }

        // Filter by Date
        if ($request->filled('date_filter')) {
            switch ($request->date_filter) {
                case 'hier':
                    $query->whereDate('caisses.created_at', now()->subDay()->toDateString());
                    break;
                case 'semaine_cours':
                    $query->whereBetween('caisses.created_at', [now()->startOfWeek(), now()->endOfWeek()]);
                    break;
                case 'semaine_passee':
                    $query->whereBetween('caisses.created_at', [now()->subWeek()->startOfWeek(), now()->subWeek()->endOfWeek()]);
                    break;
                case 'mois_passe':
                    $query->whereMonth('caisses.created_at', now()->subMonth()->month)
                        ->whereYear('caisses.created_at', now()->subMonth()->year);
                    break;
                case 'custom':
                    if ($request->filled('date_debut') && $request->filled('date_fin')) {
                        $query->whereBetween('caisses.created_at', [$request->date_debut, $request->date_fin]);
                    }
                    break;
            }
        }

        // Filter by Payment Status
        if ($request->filled('status') && $request->status == 'non_paye') {
            $query->where('caisses.reset', '>', 0);
        }

        return Inertia::render('Paiement/Index', [
            'caisses' => $query->orderByDesc('caisses.IDCaisse')->paginate($request->get('nbItem', 10)),
            'filters' => $request->all(['nom', 'prenom', 'date_filter', 'date_debut', 'date_fin', 'status', 'nbItem']),
        ]);
    }

    public function destroy($id)
    {
        $caisse = Caisse::find($id);
        if ($caisse) {
            // Get related Exams via Payments
            $examIds = \App\Models\Paiement::where('caisse_id', $id)->pluck('examen_id');

            // Delete Versements
            Versement::where('caisse_id', $id)->delete();

            // Delete Paiements
            \App\Models\Paiement::where('caisse_id', $id)->delete();

            // Delete Associated Exams
            // Note: If exams are shared or have other deps (like antecedents), they should be handled.
            // Assuming simplified cascade described in request:
            foreach ($examIds as $examId) {
                \App\Models\AntecedentExamen::where('examen_id', $examId)->delete();
                \App\Models\Examen::where('IDExamen', $examId)->delete();
            }

            // Delete Caisse
            $caisse->delete();
        }

        return redirect()->back(); // Or json response depending entirely on frontend call
    }

    public static function store($c)
    {

        $caisse = new Caisse;
        $caisse->net = $c['net'];
        $caisse->tva = $c['tva'];
        $caisse->ttc = $c['ttc'];
        $caisse->verse = $c['verse'];
        $caisse->reset = $c['reset'];
        if ($c['reset'] == 0) {
            $caisse->etatCaisse == 1;
        } else {
            $caisse->etatCaisse == 2;
        }
        $caisse->UICaisse = Auth::user()->id;
        $caisse->save();

        $versement = new Versement;

        $versement->versement = $caisse->verse;
        $versement->caisse_id = $caisse->IDCaisse;
        $versement->UIVersement = Auth::user()->id;

        $versement->save();

        return $caisse;
    }

    public function detailCaisse($IDCaisse)
    {
        $caisse = Caisse::find($IDCaisse);

        $versements = Versement::where('caisse_id', $IDCaisse)->get();

        return ['caisse' => $caisse, 'versements' => $versements];
    }

    public function setVersement(Request $request)
    {
        $versement = new Versement;

        $versement->versement = $request->newVerse;
        $versement->caisse_id = $request->IDCaisse;
        $versement->UIVersement = Auth::user()->id;
        $versement->save();

        $caisse = Caisse::find($request->IDCaisse);

        $caisse->verse += $request->newVerse;
        $caisse->reset -= $request->newVerse;

        $caisse->save();
    }
}
