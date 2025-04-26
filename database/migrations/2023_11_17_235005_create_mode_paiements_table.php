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
        Schema::create('mode_paiements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->references('id');
            $table->foreignId('etude_id')->constrained('etudes')->references('IDEtude');
            $table->foreignId('shift_id')->constrained('shifts')->references('IDShift');
            $table->integer('service_id');
            $table->integer('pourcentage');
            $table->integer('pourcentageSRV')->nullable();
            $table->integer('value');
            $table->integer('valueSRV')->nullable();
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
        Schema::dropIfExists('mode_paiements');
    }
};
