<?php

namespace App\Http\Controllers;

use App\Models\DayHourShift;
use App\Models\Shift;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ShiftController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Shift::where(function ($query) {
            if ($_GET['search'] != '' || $_GET['search'] != null) {
                $query->where('libelleShift', 'like', '%' . $_GET['search'] . '%');
            }
        })
            ->paginate($_GET['nbItem']);
    }

    public function getShift()
    {
        return Shift::where('etatShift','=',1)->get();
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
        $Shift = new Shift();
        $Shift->libelleShift = $request->libelleShift;
        $Shift->colorShift = $request->colorShift;
        //$Shift->UIShift = Auth::user()->id;
        $Shift->etatShift = true;
        $Shift->save();

        foreach($request->plan as $plan){
            foreach($plan as $item){
                if($item['isSelected']){

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
        $Shift = Shift::find($id);
        $Shift->libelleShift = $request->libelleShift;
        $Shift->start = $request->start;
        $Shift->end = $request->end;
        //$Shift->UIShift = Auth::user()->id;
        //$Shift->etatShift = 1;
        $Shift->save();

        return $Shift;
    }

    public function activeShift(Request $request)
    {
        $Shift = Shift::find($request->id);

        $Shift->etatShift = $request->etatShift;
        $Shift->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Shift::where('IDShift' , $id)->delete();
    }

    /**
     * Get list of shift active
     * @return \Illuminate\Http\Response
     */

     function getShiftActive(){

        return Shift::where('etatShift', 1)->get();
        
     }
}

