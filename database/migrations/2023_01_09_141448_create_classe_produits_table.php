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
        Schema::create('classe_produits', function (Blueprint $table) {
            $table->id('IDClasseProduit');
            $table->string('libelleCP')->nullable();
            $table->integer('UICP')->nullable();
            $table->integer('etatCP')->nullable();
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
        Schema::dropIfExists('classe_produits');
    }
};
