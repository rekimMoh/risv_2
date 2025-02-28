<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Antecedent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AntecedentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $antecedents =  Antecedent::paginate(10);
        return Inertia::render('Admin/Antecedent', [
            'antecedents' => $antecedents
        ]);
    }

    public function getAntecedent()
    {
        return Antecedent::where('etatAntecedent', '=', 1)->get();
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
            'libelleAntecedent' => 'required|string',
        ]);
        $Antecedent = new Antecedent();
        $Antecedent->libelleAntecedent = $request->libelleAntecedent;
        $Antecedent->UIAntecedent = Auth::user()->id;
        $Antecedent->etatAntecedent = true;
        $Antecedent->save();
        return $Antecedent;
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
        return Antecedent::find($id);
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
            'libelleAntecedent' => 'required|string',
        ]);
        $Antecedent = Antecedent::find($id);
        $Antecedent->libelleAntecedent = $request->libelleAntecedent;
        $Antecedent->UIAntecedent = Auth::user()->id;
        //$Antecedent->etatAntecedent = 1;
        $Antecedent->save();

        return $Antecedent;
    }

    public function activeAntecedent(Request $request)
    {
        $Antecedent = Antecedent::find($request->id);

        $Antecedent->etatAntecedent = $request->etatAntecedent;
        $Antecedent->save();

        return $Antecedent;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Antecedent::where('IDAntecedent' , $id)->delete();
    }
}
