<?php

namespace App\Http\Controllers;

use App\Models\Day;
use App\Models\DayHourShift;
use App\Models\Hour;
use Carbon\Carbon;
use App\Models\PrixExam;
use App\Models\Shift;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PrixExamController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return PrixExam::leftJoin('etudes', 'etudes.IDEtude', '=', 'prix_exams.etude_id')
            ->leftJoin('services', 'services.IDService', '=', 'prix_exams.service_id')
            ->where(function ($query) {
                if ($_GET['search'] != '' || $_GET['search'] != null) {
                    $query->where('services.libelleService', 'like', '%' . $_GET['search'] . '%');
                    $query->orWhere('etudes.libelleEtude', 'like', '%' . $_GET['search'] . '%');
                }
            })
            ->paginate($_GET['nbItem']);
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
        $PrixExam = new PrixExam();
        $PrixExam->montantPrixExam = $request->montantPrixExam;
        $PrixExam->UIPrixExam = Auth::user()->id;
        $PrixExam->etatPrixExam = true;
        $PrixExam->etude_id = $request->etude_id;
        $PrixExam->shift_id = $request->shift_id;
        $PrixExam->save();
        return $PrixExam;
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
        return PrixExam::find($id);
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
        $PrixExam = PrixExam::find($id);
        $PrixExam->montantPrixExam = $request->montantPrixExam;
        $PrixExam->UIPrixExam = Auth::user()->id;
        $PrixExam->etude_id = $request->etude_id;
        $PrixExam->service_id = $request->service_id;
        $PrixExam->save();

        return PrixExam::leftJoin('etudes', 'etudes.IDEtude', '=', 'prix_exams.etude_id')
            ->leftJoin('services', 'services.IDService', '=', 'prix_exams.service_id')
            ->where('prix_exams.IDPrixExam','=',$id)
            ->first();
    }

    static function updateByEtude($request) {
        
        $PrixExam = PrixExam::where('shift_id', '=',$request->shift_id)->first();
        
        if($PrixExam == null){
            $prix = new PrixExamController();
            $prix->store($request);
        }else{
            $PrixExam->montantPrixExam = $request->montantPrixExam;
        $PrixExam->UIPrixExam = Auth::user()->id;
        $PrixExam->etude_id = $request->etude_id;
        $PrixExam->shift_id = $request->shift_id;
        $PrixExam->save();
        }

        
    }

    public function activePrixExam(Request $request)
    {
        $PrixExam = PrixExam::find($request->id);

        $PrixExam->etatPrixExam = $request->etatPrixExam;
        $PrixExam->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        PrixExam::where('IDPrixExam', $id)->delete();
    }

    function getTarifByEtudeShift($IDEtud){
        $hourSystem = Carbon::now()->format('H');
        $daySystem = Carbon::now()->locale('fr')->dayName;

        $day = Day::where('libelleDay', $daySystem)->first();
        $hour = Hour::where('libelleHour', $hourSystem)->first();
        $shift = DayHourShift::where([
            ['day_id', $day->IDDay],
            ['hour_id', $hour->IDHour]
        ])->first();
        
        return PrixExam::where([
                ['etude_id', $IDEtud],
                ['shift_id', $shift->shift_id]
            ])
            ->select('prix_exams.montantPrixExam')
            ->first();
    }
}
