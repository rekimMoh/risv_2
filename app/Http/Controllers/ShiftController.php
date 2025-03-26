<?php

namespace App\Http\Controllers;

use App\Models\DayHourShift;
use App\Models\Shift;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ShiftController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $shift = Shift::paginate(10);
        return Inertia::render('Admin/Shift', ['Shifts' => $shift]);
    }

    public function getShift()
    {
        return Shift::where('etatShift', '=', 1)->get();
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
        $validatedData = $request->validate([
            'libelleShift' => 'required|string',
            'colorShift' => 'required|string',
        ]);

        $Shift = new Shift();
        $Shift->libelleShift = $request->libelleShift;
        $Shift->colorShift = $request->colorShift;
        //$Shift->UIShift = Auth::user()->id;
        $Shift->etatShift = true;
        $Shift->save();

        foreach ($request->plan as $plan) {
            foreach ($plan as $item) {
                if ($item['isSelected']) {

                    $dayHourShift = new DayHourShift();
                    $dayHourShift->day_id = $item['day'];
                    $dayHourShift->shift_id = $Shift->IDShift;
                    $dayHourShift->hour_id = $item['hour'];
                    $dayHourShift->save();
                }
            }
        }

        return $Shift;
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
        return Shift::find($id);
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
        $validatedData = $request->validate([
            'libelleShift' => 'required|string',
            'colorShift' => 'required|string',
        ]);
        $Shift = Shift::find($id);
        $Shift->libelleShift = $request->libelleShift;
        $Shift->colorShift = $request->colorShift;
        //$Shift->UIShift = Auth::user()->id;
        //$Shift->etatShift = 1;
        $Shift->save();

        DayHourShift::where('shift_id', $id)->delete(); // delete all day hour shift for this shift

        foreach ($request->plan as $plan) {
            foreach ($plan as $item) {
                if ($item['isSelected']) {

                    $dayHourShift = new DayHourShift();
                    $dayHourShift->day_id = $item['day'];
                    $dayHourShift->shift_id = $Shift->IDShift;
                    $dayHourShift->hour_id = $item['hour'];
                    $dayHourShift->save();
                }
            }
        }

        return $Shift;
    }

    public function activeShift(Request $request)
    {
        $Shift = Shift::find($request->id);

        $Shift->etatShift = $request->etatShift;
        $Shift->save();

        return $Shift;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Shift::where('IDShift', $id)->delete();
    }

    /**
     * Get list of shift active
     * @return \Illuminate\Http\Response
     */

    function getShiftActive()
    {

        return Shift::where('etatShift', 1)->get();
    }

    function getDayHourShift($id)
    {

        return DayHourShift::where('shift_id', $id)->get();
    }


}
