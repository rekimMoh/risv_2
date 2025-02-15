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
        Schema::table('prix_exams', function (Blueprint $table) {
            $table->foreignId('shift_id')->nullable()->constrained('shifts')->references('IDShift');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('prix_exams', function (Blueprint $table) {
            //
        });
    }
};
