<?php

use App\Models\Day;
use App\Models\Hour;
use Inertia\Inertia;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EtudeController;
use App\Http\Controllers\ShiftController;
use App\Http\Controllers\ProduitController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\PrixExamController;
use App\Http\Controllers\AntecedentController;
use App\Http\Controllers\ClasseProduitController;

Route::middleware('auth')->group(function () {
    // route USER
    Route::resource('/user', UserController::class);
    Route::post('/active-compte-user', [UserController::class, 'activeCompte'])->name('admin.User.toggle');


    //Route COMPTE RENDU
    //Route::resource('/compte-rendu',UserController::class);

    //route classe produit
    Route::resource('/cp', ClasseProduitController::class);
    Route::post('/active-cp', [ClasseProduitController::class, 'activeCP'])->name('admin.classProduit.toggle');

    //ROUTE PRODUIT

    Route::resource('/produit', ProduitController::class);

    Route::get('/admin/produit', [ProduitController::class, 'index']);
    Route::post('/active-produit', [ProduitController::class, 'activeProduit'])->name('admin.produit.toggle');
    Route::get('/get-cp', [ClasseProduitController::class, 'getCP'])->name('listClasseProduits');

    // ROUTE SERVICE

    Route::resource('/service', ServiceController::class);
    Route::post('/active-service', [ServiceController::class, 'activeService'])->name('admin.service.toggle');

    // ROUTE SHIFT

    Route::resource('/shift', ShiftController::class);
    Route::post('/active-shift', [ShiftController::class, 'activeShift'])->name('admin.shift.toggle');
    Route::get('shift-active', [ShiftController::class, 'getShiftActive']);

    Route::get('/get-day-hour-shift/{id}', [ShiftController::class, 'getDayHourShift']);

    //ROUTE ETUDE

    Route::resource('/etude', EtudeController::class);
    Route::post('/active-etude', [EtudeController::class, 'activeEtude'])->name('admin.etude.toggle');


    // ROUTE Antecedent

    Route::resource('/antecedent', AntecedentController::class);
    Route::post('/active-antecedent', [AntecedentController::class, 'activeAntecedent'])->name('admin.antecedent.toggle');

    // ROUTE Prix Examen

    Route::resource('/prix-exam', PrixExamController::class);
    Route::post('/active-prix-exam', [PrixExamController::class, 'activePrixExam']);

    //Route Days & hours

    Route::get('/day', function () {
        return Day::all();
    });

    Route::get('/hour', function () {
        return Hour::all();
    });
});
