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
        Schema::create('compte_rendu_models', function (Blueprint $table) {
            $table->id('IDCRM');
            $table->string('titreCRM');
            $table->text('contenuCRM');
            $table->integer('UICRM');
            $table->integer('etatCRM');
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
        Schema::dropIfExists('compte_rendu_models');
    }
};
