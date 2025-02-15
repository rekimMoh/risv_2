<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ServiceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Service::where(function ($query) {
            if ($_GET['search'] != '' || $_GET['search'] != null) {
                $query->where('libelleService', 'like', '%' . $_GET['search'] . '%');
            }
        })
            ->paginate($_GET['nbItem']);
    }

    public function getService()
    {
        return Service::where('etatService','=',1)->get();
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
        $Service = new Service();
        $Service->libelleService = $request->libelleService;
        $Service->UIService = Auth::user()->id;
        $Service->etatService = true;
        $Service->save();
        return $Service;
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
        return Service::find($id);
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
        $Service = Service::find($id);
        $Service->libelleService = $request->libelleService;
        $Service->UIService = Auth::user()->id;
        //$Service->etatService = 1;
        $Service->save();

        return $Service;
    }

    public function activeService(Request $request)
    {
        $Service = Service::find($request->id);

        $Service->etatService = $request->etatService;
        $Service->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Service::where('IDService' , $id)->delete();
    }
}
