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
        Schema::create('lien_users', function (Blueprint $table) {
            $table->id('IDLienUser');
            $table->foreignId('user_id')->nullable()->constrained('users')->references('id');
            $table->foreignId('lien_id')->nullable()->constrained('liens')->references('IDLien');
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
        Schema::dropIfExists('lien_users');
    }
};
