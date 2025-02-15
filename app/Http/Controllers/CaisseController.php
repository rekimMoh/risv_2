<?php

namespace App\Http\Controllers;

use App\Models\Caisse;
use App\Models\Versement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CaisseController extends Controller
{


    public function index()
    {
        return Caisse::leftJoin('paiements', 'caisses.IDCaisse', '=', 'paiements.caisse_id')
            ->leftJoin('examens', 'paiements.examen_id', '=', 'examens.IDExamen')
            ->leftJoin('patients', 'patients.IDPatient', '=', 'examens.patient_id')
            ->where(function ($query) {
                if ($_GET['search'] != '' || $_GET['search'] != null) {
                    $query->where('libelleEtude', 'like', '%' . $_GET['search'] . '%');
                    $query->orWhere('libelleService', 'like', '%' . $_GET['search'] . '%');
                }
            })
            ->select(
                'patients.IDPatient',
                'patients.nomP',
                'patients.prenomP',
                'examens.created_at',
                'caisses.ttc',
                'caisses.reset',
                'caisses.IDCaisse',
                'examens.IDExamen'
            )
            ->groupBy('caisses.IDCaisse')
            ->orderByDesc('caisses.IDCaisse')
            ->paginate($_GET['nbItem']);
    }

    static function store($c)
    {

        $caisse = new Caisse();
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

        $versement = new Versement();

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
        $versement = new Versement();

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
