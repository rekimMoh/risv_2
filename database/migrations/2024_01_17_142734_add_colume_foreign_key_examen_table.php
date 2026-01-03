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
        Schema::table('examens', function (Blueprint $table) {
            $table->foreignId('patient_id')->nullable()->constrained('patients')->references('IDPatient');
            $table->foreignId('produit_id')->nullable()->constrained('produits')->references('IDProduit');
            // $table->foreignId('class_produit_id')->nullable()->constrained('class_produits')->references('IDClasseProduit');
            $table->foreignId('etude_id')->nullable()->constrained('etudes')->references('IDEtude');
            $table->foreignId('service_id')->nullable()->constrained('services')->references('IDService');
            $table->foreignId('antecedent_id')->nullable()->constrained('antecedents')->references('IDAntecedent');
            $table->foreignId('prescripeur_id')->nullable()->constrained('users')->references('id');
            $table->foreignId('radiologue_id')->nullable()->constrained('users')->references('id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('examens', function (Blueprint $table) {
            $table->dropForeign(['patient_id']);
            $table->dropForeign(['produit_id']);
            $table->dropForeign(['etude_id']);
            $table->dropForeign(['service_id']);
            $table->dropForeign(['antecedent_id']);
            $table->dropForeign(['prescripeur_id']);
        });
    }
};
