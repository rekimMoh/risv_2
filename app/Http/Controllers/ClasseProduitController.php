<?php

namespace App\Http\Controllers;

use App\Models\ClasseProduit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ClasseProduitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $cp = ClasseProduit::paginate(10);

            return Inertia::render('Admin/ClassProduct', [
                'classProduits' => $cp
            ]);
    }

    public function getCP()
    {
        return ClasseProduit::where('etatCP',1)->get();
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
            'libelleCP' => 'required|string',
        ]);

        $cp = new ClasseProduit();
        $cp->libelleCP = $request->libelleCP;
        $cp->UICP = Auth::user()->id;
        $cp->etatCP = true;
        $cp->save();
        return $cp;
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
        return ClasseProduit::find($id);
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
            'libelleCP' => 'required|string',
        ]);

        $cp = ClasseProduit::find($id);
        $cp->libelleCP = $request->libelleCP;
        $cp->UICP = Auth::user()->id;
        //$cp->etatCP = 1;
        $cp->save();

        return $cp;
    }

    public function activeCP(Request $request)
    {
        $ClasseProduit = ClasseProduit::find($request->id);

        $ClasseProduit->etatCP = $request->etatCP;
        $ClasseProduit->save();

        return $ClasseProduit;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        ClasseProduit::where('IDClasseProduit' , $id)->delete();
    }
}
