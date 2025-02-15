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
        Schema::create('RDV', function (Blueprint $table) {
            $table->id('IDRDV');
            $table->date('dateRDV')->nullable();
            $table->time('heurRDV')->nullable();
            $table->text('obsRDV')->nullable();
            $table->integer('UIRDV')->nullable();
            $table->integer('etatRDV')->nullable();
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
        Schema::dropIfExists('r_d_v_s');
    }
};
