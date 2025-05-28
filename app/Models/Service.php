<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Service extends Model
{
    use HasFactory;
    protected $primaryKey = 'IDService';

    public function etudes():HasMany
    {
        return $this->hasMany(Etude::class, 'service_id', 'IDService');
    }

    public function shiftsMP(): BelongsToMany
    {
        return $this->belongsToMany(Shift::class, 'mode_paiements', 'service_id', 'shift_id','IDService', 'IDShift');
    }

    
}
