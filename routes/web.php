<?php

use App\Models\User;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InitController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EtudeController;
use App\Http\Controllers\IndexController;
use App\Http\Controllers\ExamenController;
use App\Http\Controllers\WilayaController;
use App\Http\Controllers\ProduitController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\AntecedentController;
use App\Http\Controllers\CaisseController;
use App\Http\Controllers\PaiementController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\PrixExamController;
use \App\Http\Middleware\IsActive;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [IndexController::class, 'index'])->middleware(['auth', isActive::class])->name('dashboard');

require __DIR__ . '/auth.php';
require __DIR__ . '/admin.php';



Route::middleware('auth')->group(function () {
    Route::get('init', [InitController::class, 'index'])->name('init');
    Route::get('/init-user-form', [InitController::class, 'initUser'])->name('init-user');


    // ROUTE FOR VIEW APP

    Route::resource('/paiement', CaisseController::class);



    //ROUTE FOR ACTION APP
    Route::get('/get-antecedent', [AntecedentController::class, 'getAntecedent']);
    Route::get('/get-wilaya', [WilayaController::class, 'index']);
    Route::get('/get-service', [ServiceController::class, 'getService']);
    Route::get('/get-radiologue', [UserController::class, 'getRadiologue']);
    Route::get('/get-produit', [ProduitController::class, 'getProduit']);
    Route::get('/get-etude-by-service/{id}', [EtudeController::class, 'getEtudeByService']);
    Route::post('/examen', [ExamenController::class, 'insertExamen']);
    Route::get('/get-tarif-by-etude-shift/{id}', [PrixExamController::class, 'getTarifByEtudeShift']);
    Route::get('/list-medcin', [UserController::class, 'getListMedcin']);
    Route::get('/service-has-etude', [EtudeController::class, 'serviceHasEtude']);
    Route::get('/detail-examen/{IDCaisse}', [ExamenController::class, 'detailExamen']);
    Route::get('/detailCaisse/{IDCaisse}', [CaisseController::class, 'detailCaisse']);
    Route::post('/set-versement', [CaisseController::class, 'setVersement']);
    Route::put('/update-patient/{id}', [PatientController::class, 'update']);


    // Route Auto Search
    Route::get('/patient-search', [PatientController::class, 'searchPatient']);

    Route::get('{any?}', function() {
        return view('application');
    })->where('any', '.*');
});

