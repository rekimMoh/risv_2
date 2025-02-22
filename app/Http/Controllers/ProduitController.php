<?php

namespace App\Http\Controllers;

use App\Models\PrixProduit;
use App\Models\Produit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ProduitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $produit =  Produit::leftJoin('classe_produits','produits.class_produit_id','=','classe_produits.IDClasseProduit')
        ->paginate(10);

        return Inertia::render('Admin/Product',[
            'produits' => $produit
        ]);
    }

    public function getProduit()
    {
        return Produit::where('etatProduit',1)->get();
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
        $produit = new Produit();
        $produit->libelleProduit = $request->libelleProduit;
        $produit->etatProduit = 1;
        $produit->UIProduit = Auth::user()->id;
        $produit->class_produit_id = $request->class_produit_id;
        $produit->prix_afficher = $request->prix_afficher;

        if($produit->save())
        {
            $prix = new PrixProduit();
            $prix->prixP = $request->prix_afficher;
            $prix->produit_id = $produit->IDProduit;
            $prix->save();
        }

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
        return Produit::find($id);
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
        $lastPrix = PrixProduit::where('produit_id',$id)->orderBy('IDPrixProduit','desc')->first();

        $produit = Produit::find($id);
        $produit->libelleProduit = $request->libelleProduit;
        $produit->etatProduit = 1;
        $produit->UIProduit = Auth::user()->id;
        $produit->class_produit_id = $request->class_produit_id;
        $produit->prix_afficher = $request->prix_afficher;

        if($produit->save() && $lastPrix->prixP != $request->prix_afficher)
        {
            $prix = new PrixProduit();
            $prix->prixP = $request->prix_afficher;
            $prix->produit_id = $id;
            $prix->save();
        }

    }

    public function activeProduit(Request $request)
    {
        $produit= Produit::find($request->id);

        $produit->etatProduit = $request->etatProduit;
        $produit->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Produit::where('IDProduit' , $id)->delete();
    }
}
