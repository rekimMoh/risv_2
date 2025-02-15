<?php

namespace App\Http\Controllers;

use App\Models\Etude;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\PrixExamController;
use App\Models\PrixExam;
use App\Models\Service;

class EtudeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Etude::leftJoin('services', 'etudes.service_id', '=', 'services.IDService')
            ->where(function ($query) {
                if ($_GET['search'] != '' || $_GET['search'] != null) {
                    $query->where('libelleEtude', 'like', '%' . $_GET['search'] . '%');
                    $query->orWhere('libelleService', 'like', '%' . $_GET['search'] . '%');
                }
            })
            ->paginate($_GET['nbItem']);
    }

    public function getEtude()
    {
        return Etude::all();
    }

    public function getEtudeByService($id)
    {
        return Etude::where([
                ['etudes.service_id', $id],
                ['etudes.etatEtude', 1]
            ])->get();
            
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $Etude = new Etude();
        $Etude->libelleEtude = $request->libelleEtude;
        $Etude->UIEtude = Auth::user()->id;
        $Etude->etatEtude = true;
        $Etude->service_id = $request->service_id;
        $Etude->save();

        foreach ($request->montantByShift as $prix) {

            $request->etude_id = $Etude->IDEtude;
            $request->montantPrixExam = $prix['montantPrixExam'];
            $request->shift_id = $prix['IDShift'];

            $prix = new PrixExamController();

            $prix->store($request);
        }



        return $Etude;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $Etude = Etude::where('IDEtude', '=', $id)->first();
        $montantByShift  = PrixExam::leftJoin('shifts','shifts.IDShift','=','prix_exams.shift_id')
        ->where('etude_id',$id)->get();

        return ['montantByShift'=> $montantByShift, 'etude' =>$Etude];
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $Etude = Etude::find($id);
        $Etude->libelleEtude = $request->libelleEtude;
        $Etude->UIEtude = Auth::user()->id;
        $Etude->service_id = $request->service_id;
        //$Etude->etatEtude = 1;
        $Etude->save();

        foreach ($request->montantByShift as $prix) {

            $request->etude_id = $Etude->IDEtude;
            $request->montantPrixExam = $prix['montantPrixExam'];
            $request->shift_id = $prix['IDShift'];

            $prix = new PrixExamController();

            $prix->updateByEtude($request);
        }

        return $Etude;
    }

    public function activeEtude(Request $request)
    {
        $Etude = Etude::find($request->id);

        $Etude->etatEtude = $request->etatEtude;
        $Etude->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        PrixExam::where('etude_id',$id)->delete();
        Etude::where('IDEtude', $id)->delete();
    }


    /**
     * Get list of service has etude
     * Get list of etudes
     * 
     * @return erray [$service, $etude]
     */

     function serviceHasEtude() {
        
        $etudes = Etude::all();

        $services = Service::join('etudes','etudes.service_id', 'services.IDService')
                        ->select('services.IDService','services.libelleService')
                        ->groupBy('services.IDService','services.libelleService')
                        ->get();

        return ['services'=>$services, 'etudes'=> $etudes];

     }
}
