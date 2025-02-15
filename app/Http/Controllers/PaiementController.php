<?php

namespace App\Http\Controllers;

use App\Models\Paiement;
use Illuminate\Http\Request;

class PaiementController extends Controller
{
    function index() {
       
    }


    static function store($montent,  $remise, $porcentage,$typeRemise, $examen,$caisse){
        $paiment = new Paiement();
        $paiment->montantantVerserment = $montent;
        if($typeRemise == 'p'){
            $paiment->remisePourcent = $porcentage;
        }
        
        $paiment->remiseMontant = $remise;
        $paiment->examen_id = $examen;
        $paiment->caisse_id = $caisse;
        $paiment->save();
    }
}
