<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Shift extends Model
{
    use HasFactory;
    protected $primaryKey = 'IDShift';

    public function Etudes(): BelongsToMany
    {
        return $this->belongsToMany(Etude::class, 'prix_exams',  'shift_id','etude_id', 'IDShift','IDEtude');
    }
}
