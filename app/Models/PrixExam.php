<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PrixExam extends Model
{
    use HasFactory;

    protected $primaryKey  = 'IDPrixExam';

    public function etude()
    {
        return $this->belongsTo(Etude::class, 'etude_id', 'IDEtude');
    }
}
