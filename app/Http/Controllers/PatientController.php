<?php

namespace App\Http\Controllers;

use App\Models\Patient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class PatientController extends Controller
{
    static function checkPatient($nom, $prenom, $dateNais){
        $patient = Patient::where([
            ['nomP',$nom],
            ['prenomP',$prenom],
            ['naisP',$dateNais]
        ])->first();

        return $patient;
        
    }

    static function store($p){
        $patient = new Patient();
        $patient->nomP = $p['nomP'];
        $patient->prenomP = $p['prenomP'];
        $patient->naisP = $p['naisP'];
        $patient->sexeP = $p['sexeP'];
        $patient->telP1 = $p['telP1'];
        $patient->wilaya_id = $p['wilaya_id'];
        //$patient->observation = $p['observation'];
        $patient->UIPatien = Auth::user()->id;
        $patient->save(); 

        return $patient;
    }

    public function searchPatient() {
        $patients = Patient::where(function ($query) {
            if ($_GET['keyWord'] != '' || $_GET['keyWord'] != null) {
                $query->where('nomP', 'like', '%' . $_GET['keyWord'] . '%');
                $query->orWhere('prenomP', 'like', '%' . $_GET['keyWord'] . '%');
            }
        })->select('*', DB::raw('CONCAT(nomP, ", ", prenomP , ", ", naisP) AS text'))
        ->get();

        return $patients;
    }

    public function update($id, Request $request){
        $patient = Patient::find($id);
        $patient->nomP = $request->nomP;
        $patient->prenomP = $request->prenomP;
        $patient->naisP = $request->naisP;
        $patient->sexeP = $request->sexeP;
        $patient->telP1 = $request->telP1;
        $patient->wilaya_id = $request->wilaya_id;

        $patient->save();
    }
}
