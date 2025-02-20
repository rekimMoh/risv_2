<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Doctrine\DBAL\Schema\View;
use Illuminate\Http\Request;

class IndexController extends Controller
{
    public function index(){
        return View('layouts.app');
    }
}
