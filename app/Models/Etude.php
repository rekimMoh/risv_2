<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Etude extends Model
{
    use HasFactory;
    protected $primaryKey = 'IDEtude';

    public function PrixExams()
    {
        return $this->hasMany(PrixExam::class, 'etude_id', 'IDEtude');
    }
}
