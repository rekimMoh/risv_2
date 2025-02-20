<?php

namespace App\Http\Controllers;

use App\Models\Lien;
use App\Models\Shift;
use App\Models\UserMetier;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use League\CommonMark\Extension\CommonMark\Node\Inline\Link;

class InitController extends Controller
{
    public function index()
    {
        $route = Lien::leftJoin('lien_users', 'liens.IDLien','=', 'lien_users.lien_id')
                ->where('lien_users.user_id', '=' , Auth::user()->id)
                ->orderBy('liens.IDLien','ASC')
                ->get();
        
         return ['route'=> $route];
    }
    public function initUser()
    {
        $liens = Lien::all();

        $roles = UserMetier::all();

        $shifts = Shift::all();

        return ['liens'=> $liens, 'roles'=> $roles , 'shifts' => $shifts];
    }
}
