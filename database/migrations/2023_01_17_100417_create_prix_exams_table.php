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
        Schema::create('prix_exams', function (Blueprint $table) {
            $table->id('IDPrixExam');
            $table->decimal('montantPrixExam', 10, 2)->nullable();
            $table->integer('UIPrixExam')->nullable();
            $table->integer('etatPrixExam')->nullable();
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
        Schema::dropIfExists('prix_exams');
    }
};
