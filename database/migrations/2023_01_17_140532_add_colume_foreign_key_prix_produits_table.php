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
        Schema::table('prix_produits', function (Blueprint $table) {
            $table->foreignId('produit_id')->nullable()->constrained('produits')->references('IDProduit');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('prix_produits', function (Blueprint $table) {
            //
        });
    }
};
