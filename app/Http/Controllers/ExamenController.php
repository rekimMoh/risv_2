<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\PatientController;
use App\Models\AntecedantExamen;
use App\Models\Caisse;
use App\Models\Examen;
use App\Models\Paiement;
use App\Models\Patient;

class ExamenController extends Controller
{
    public function insertExamen(Request $request)
    {



        $patient = PatientController::checkPatient(
            $request->patient['nomP'],
            $request->patient['prenomP'],
            $request->patient['naisP']
        );

        if ($patient == null) {
            $patient = PatientController::store($request->patient);
        }

        $caisse = CaisseController::store($request->paiment);

        foreach ($request->examens as $exam) {
            $examen = new Examen();
            $examen->radiologue_id = $exam['radiologue'];
            $examen->patient_id = $patient->IDPatient;
            if ($exam['produit'] != 0 && $exam['produit'] != null) {
                $examen->produit_id = $exam['produit'];
            }
            $examen->etude_id = $exam['etude'];
            $examen->service_id = $exam['service'];
            $examen->UIExam = Auth::user()->id;
            $examen->save();

            PaiementController::store(
                $exam['tarif'],
                $exam['remise'],
                $exam['calcRemise'],
                $exam['typeRemise'],
                $examen->IDExamen,
                $caisse->IDCaisse
            );
            if (count($request->patient['antecedents']) > 0) {


                foreach ($request->patient['antecedents'] as $item) {
                    $antecedantE = new AntecedantExamen();
                    $antecedantE->antecedent_id = $item;
                    $antecedantE->examen_id = $examen->IDExamen;
                    $antecedantE->save();
                }
            }
        }
    }

    public function detailExamen($IDCaisse){
        
            $caisse = Caisse::leftJoin('paiements','caisses.IDCaisse','=','paiements.caisse_id')
                        ->where('IDCaisse','=',$IDCaisse)
                        ->selectRaw('caisses.*, SUM(paiements.remiseMontant) as remise')
                        ->first();
        
            $examens = Examen::leftJoin('users','examens.radiologue_id','=','users.id')
                        ->leftJoin('services','examens.service_id','=','services.IDService')
                        ->leftJoin('etudes','examens.etude_id','=','etudes.IDEtude')
                        ->leftJoin('produits','examens.produit_id','=','produits.IDProduit')
                        ->leftJoin('paiements','examens.IDExamen','=','paiements.examen_id')
                        ->select('examens.*','paiements.montantantVerserment','paiements.remiseMontant',
                                 'services.libelleService','etudes.libelleEtude',
                                 'users.nom','users.prenom','produits.libelleProduit')
                                ->where('paiements.caisse_id','=',$IDCaisse)
                        ->get();
         

        $patient = Patient::leftJoin('wilayas','wilayas.IDWilaya','patients.wilaya_id')
                                    ->where('patients.IDpatient',$examens[0]->patient_id)
                                    ->select('patients.*','wilayas.nomWilaya')
                                    ->first();

        return ['patient'=>$patient, 'examens'=> $examens, 'caisse'=> $caisse];


    }
}
