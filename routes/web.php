<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Application;
use App\Http\Controllers\InitController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EtudeController;
use App\Http\Controllers\ShiftController;
use App\Http\Controllers\CaisseController;
use App\Http\Controllers\ExamenController;
use App\Http\Controllers\WilayaController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\ProduitController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\PrixExamController;
use App\Http\Controllers\AntecedentController;

Route::get('/', function () {
    return Inertia::render('Welcome');
})->middleware(['auth', 'verified'])->name('home');

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/accueil', function () {
    return Inertia::render('Accueil');
})->middleware(['auth', 'verified'])->name('accueil');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
require __DIR__ . '/admin.php';

Route::middleware('auth')->group(function () {
    Route::get('/init', [InitController::class, 'index'])->name('init');
    Route::get('/init-user-form', [InitController::class, 'initUser'])->name('init-user');


// ROUTE FOR VIEW APP

Route::resource('/paiement',CaisseController::class);



//ROUTE FOR ACTION APP
    Route::get('/get-antecedent', [AntecedentController::class, 'getAntecedent']);
    Route::get('/get-wilaya', [WilayaController::class, 'index']);
    Route::get('/get-service', [ServiceController::class, 'getService']);
    Route::get('/get-radiologue', [UserController::class, 'getRadiologue']);
    Route::get('/get-produit', [ProduitController::class, 'getProduit']);
    Route::get('/get-etude-by-service/{id}', [EtudeController::class, 'getEtudeByService']);
    Route::post('/examen',[ExamenController::class,'insertExamen']);
    Route::post('/examen/add-to-caisse', [ExamenController::class, 'storeToCaisse']);
    Route::put('/examen/{id}', [ExamenController::class, 'update']);
    Route::delete('/examen/{id}',[ExamenController::class,'destroy']);
    Route::get('/get-tarif-by-etude-shift/{id}', [PrixExamController::class, 'getTarifByEtudeShift']);
    Route::get('/list-medcin', [UserController::class, 'getListMedcin']);
    Route::get('/service-has-etude', [EtudeController::class, 'serviceHasEtude']);
    Route::get('/detail-examen/{IDCaisse}',[ExamenController::class,'detailExamen']);
    Route::get('/detailCaisse/{IDCaisse}',[CaisseController::class,'detailCaisse']);
    Route::post('/set-versement',[CaisseController::class,'setVersement']);
    Route::put('/update-patient/{id}',[PatientController::class,'update']);

    Route::get('/get-shift', [ShiftController::class, 'getShift']);
    
    
    // Route Auto Search
    Route::get('/patient-search',[PatientController::class,'searchPatient']);
});
