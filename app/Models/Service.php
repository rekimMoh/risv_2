<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Service extends Model
{
    use HasFactory;
    protected $primaryKey = 'IDService';

    public function etudes():HasMany
    {
        return $this->hasMany(Etude::class, 'service_id', 'IDService');
    }

    
}
