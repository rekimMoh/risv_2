<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('paiements', function (Blueprint $table) {
            $table->id('IDPaiement');
            $table->date('datePaiement')->nullable();
            $table->decimal('montantantVerserment')->nullable();
            //$table->decimal('reste', 10)->nullable();
            $table->integer('UIPaiement')->nullable();
            $table->integer('etatPaiement')->nullable();
            $table->integer('remisePourcent')->nullable();
            $table->decimal('remiseMontant')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('paiements');
    }
};
