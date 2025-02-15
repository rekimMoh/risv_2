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
        Schema::create('prix_produits', function (Blueprint $table) {
            $table->id('IDPrixProduit');
            $table->decimal('prixP', 10, 2)->nullable();
            $table->integer('UIPrixP')->nullable();
            $table->integer('etatPrixP')->nullable();
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
        Schema::dropIfExists('prix_produits');
    }
};
