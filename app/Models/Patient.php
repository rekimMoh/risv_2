<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Patient extends Model
{
    use HasFactory;

    protected $primaryKey = 'IDPatient';

    public function antecedents()
    {
        return $this->belongsToMany(Antecedent::class, 'antecedent_patients', 'patient_id', 'antecedent_id');
    }
}
