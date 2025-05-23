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
        Schema::create('antecedent_examens', function (Blueprint $table) {
            $table->id();
            $table->foreignId('examen_id')->nullable()->constrained('examens')->references('IDExamen');
            $table->foreignId('antecedent_id')->nullable()->constrained('antecedents')->references('IDAntecedent');
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
        Schema::dropIfExists('antecedent_examens');
    }
};
