<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
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
        $Services = Service::paginate(10);
        return Inertia::render('Admin/Service', [
            'Services' => $Services
        ]);
        
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
        $validatedData = $request->validate([
            'libelleService' => 'required|string',
        ]);

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
        $validatedData = $request->validate([
            'libelleService' => 'required|string',
        ]);
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

        return $Service;
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
