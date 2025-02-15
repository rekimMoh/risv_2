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
        Schema::table('validationCR', function (Blueprint $table) {
            $table->foreignId('compte_rendu_id')->nullable()->constrained('compte_rendus')->references('IDCR');
            $table->foreignId('examen_id')->nullable()->constrained('compte_rendus')->references('examen_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('validationCR', function (Blueprint $table) {
            //
        });
    }
};
