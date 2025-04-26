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
        Schema::create('patients', function (Blueprint $table) {
            $table->id('IDPatient');
            $table->string('nomP')->nullable();
            $table->string('prenomP')->nullable();
            $table->date('naisP')->nullable();
            $table->integer('sexeP')->nullable();
            $table->string('telP1', 15)->nullable();
            $table->string('telP2', 15)->nullable();
            $table->text('observation')->nullable();
            //$table->integer('wilaya_id')->nullable();
            $table->integer('UIPatien')->nullable();
            $table->integer('etatP')->nullable();
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
        Schema::dropIfExists('patients');
    }
};
