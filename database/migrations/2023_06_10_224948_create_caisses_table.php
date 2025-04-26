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
        Schema::create('caisses', function (Blueprint $table) {
            $table->id('IDCaisse');
            $table->decimal('net')->nullable();
            $table->decimal('tva')->nullable();
            $table->decimal('ttc')->nullable();
            $table->decimal('verse')->nullable();
            $table->decimal('reset')->nullable();
            $table->integer('UICaisse')->nullable();
            $table->integer('etatCaisse')->nullable();
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
        Schema::dropIfExists('caisses');
    }
};
