<?php

namespace App\Http\Controllers;

use App\Models\DayHourShift;
use App\Models\Etude;
use App\Models\PrixExam;
use App\Models\Service;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class EtudeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $etude = Etude::leftJoin('services', 'etudes.service_id', '=', 'services.IDService')
            ->with('PrixExams')
            ->paginate(10);

        return Inertia::render('Admin/Etude', ['Etudes' => $etude]);
    }

    public function getEtude()
    {
        return Etude::all();
    }

    public function getEtudeByService($id)
    {
        $now = Carbon::now();
        $hour = $now->hour + 1;
        $dayNumber = $now->dayOfWeek + 1;
        // dd($hour, $dayNumber);
        $day_hour_shift = DayHourShift::where([
            ['day_id', $dayNumber],
            ['hour_id', $hour],
        ])->first();
        $shift_id = $day_hour_shift->shift_id;

        return Etude::leftJoin('prix_exams', 'etudes.IDEtude', '=', 'prix_exams.etude_id')
            ->leftJoin('shifts', 'shifts.IDShift', '=', 'prix_exams.shift_id')
            ->where([
                ['etudes.service_id', $id],
                ['etudes.etatEtude', 1],
                ['prix_exams.shift_id', $shift_id],
            ])->select('etudes.*', 'prix_exams.montantPrixExam', 'shifts.libelleShift', 'shifts.colorShift')
            ->get();
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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $Etude = new Etude;
        $Etude->libelleEtude = $request->libelleEtude;
        $Etude->UIEtude = Auth::user()->id;
        $Etude->etatEtude = true;
        $Etude->service_id = $request->service_id;
        $Etude->save();

        foreach ($request->prix_exams as $prix) {
            $prixEtude = new PrixExam;
            $prixEtude->etude_id = $Etude->IDEtude;
            $prixEtude->montantPrixExam = $prix['montantPrixExam'];
            $prixEtude->shift_id = $prix['shift_id'];
            $prixEtude->UIPrixExam = Auth::user()->id;
            $prixEtude->etatPrixExam = true;
            $prixEtude->save();
        }

        return Etude::leftJoin('services', 'etudes.service_id', '=', 'services.IDService')
            ->with('PrixExams')
            ->where('IDEtude', '=', $Etude->IDEtude)
            ->first();
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
        $montantByShift = PrixExam::leftJoin('shifts', 'shifts.IDShift', '=', 'prix_exams.shift_id')
            ->where('etude_id', $id)->get();

        return ['montantByShift' => $montantByShift, 'etude' => $Etude];
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $Etude = Etude::find($id);
        $Etude->libelleEtude = $request->libelleEtude;
        $Etude->UIEtude = Auth::user()->id;
        $Etude->service_id = $request->service_id;
        // $Etude->etatEtude = 1;
        $Etude->save();

        foreach ($request->prix_exams as $prix) {
            if ($prix['IDPrixExam']) {
                $prixEtude = PrixExam::find($prix['IDPrixExam']);
                $prixEtude->montantPrixExam = $prix['montantPrixExam'];
                $prixEtude->shift_id = $prix['shift_id'];
                $prixEtude->UIPrixExam = Auth::user()->id;
                // $prixEtude->etatPrixExam = true;
                $prixEtude->save();
            } else {
                $prixEtude = new PrixExam;
                $prixEtude->etude_id = $Etude->IDEtude;
                $prixEtude->montantPrixExam = $prix['montantPrixExam'];
                $prixEtude->shift_id = $prix['shift_id'];
                $prixEtude->UIPrixExam = Auth::user()->id;
                $prixEtude->etatPrixExam = true;
                $prixEtude->save();
            }
        }

        return Etude::leftJoin('services', 'etudes.service_id', '=', 'services.IDService')
            ->with('PrixExams')
            ->where('IDEtude', '=', $Etude->IDEtude)
            ->first();
    }

    public function activeEtude(Request $request)
    {
        $Etude = Etude::find($request->id);

        $Etude->etatEtude = $request->etatEtude;
        $Etude->save();

        return $Etude;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        PrixExam::where('etude_id', $id)->delete();
        Etude::where('IDEtude', $id)->delete();
    }

    /**
     * Get list of service has etude
     * Get list of etudes
     *
     * @return erray [$service, $etude]
     */
    public function serviceHasEtude()
    {

        $etudes = Etude::all();

        $services = Service::join('etudes', 'etudes.service_id', 'services.IDService')
            ->select('services.IDService', 'services.libelleService')
            ->groupBy('services.IDService', 'services.libelleService')
            ->get();

        return ['services' => $services, 'etudes' => $etudes];
    }
}
