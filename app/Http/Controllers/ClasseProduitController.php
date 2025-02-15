<?php

namespace App\Http\Controllers;

use App\Models\ClasseProduit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ClasseProduitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ClasseProduit::where(function ($query) {
            if ($_GET['search'] != '' || $_GET['search'] != null) {
                $query->where('libelleCP', 'like', '%' . $_GET['search'] . '%');
            }
        })
            ->paginate($_GET['nbItem']);
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
        $cp = ClasseProduit::find($id);
        $cp->libelleCP = $request->libelleCP;
        $cp->UICP = Auth::user()->id;
        //$cp->etatCP = 1;
        $cp->save();

        return $cp;
    }

    public function activeCRM(Request $request)
    {
        $ClasseProduit = ClasseProduit::find($request->id);

        $ClasseProduit->etatCP = $request->etatCP;
        $ClasseProduit->save();
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
