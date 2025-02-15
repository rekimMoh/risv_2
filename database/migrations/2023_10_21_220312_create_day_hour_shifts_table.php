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
        Schema::create('day_hour_shifts', function (Blueprint $table) {
            $table->id('IDDHS');
            $table->foreignId('day_id')->nullable()->constrained('days')->references('IDDay');
            $table->foreignId('shift_id')->nullable()->constrained('shifts')->references('IDShift');
            $table->foreignId('hour_id')->nullable()->constrained('hours')->references('IDHour');

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
        Schema::dropIfExists('day_hour_shifts');
    }
};
