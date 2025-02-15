<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CompteRenduModel;
use Illuminate\Support\Facades\Auth;

class CompteRenduModelController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return CompteRenduModel::where(function ($query) {
            if ($_GET['search'] != '' || $_GET['search'] != null) {
                $query->where('titreCRM', 'like', '%' . $_GET['search'] . '%');
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
        $CompteRenduModel = new CompteRenduModel();
        $CompteRenduModel->titreCRM = $request->titreCRM;
        $CompteRenduModel->contenuCRM = $request->contenuCRM;
        $CompteRenduModel->UICRM = Auth::user()->id;
        $CompteRenduModel->etatCRM = 1;
        $CompteRenduModel->save();
        return $CompteRenduModel;
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
        return CompteRenduModel::find($id);
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
        $CompteRenduModel = CompteRenduModel::find($id);
        $CompteRenduModel->titreCRM = $request->titreCRM;
        $CompteRenduModel->contenuCRM = $request->contenuCRM;
        $CompteRenduModel->UICRM = Auth::user()->id;
        $CompteRenduModel->save();
        return $CompteRenduModel;
    }

    public function activeCRM(Request $request)
    {
        $CompteRenduModel = CompteRenduModel::find($request->id);

        $CompteRenduModel->etatCRM = $request->etatCRM;
        $CompteRenduModel->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        CompteRenduModel::where('IDCRM' , $id)->delete();
    }
}
