<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Etude extends Model
{
    use HasFactory;
    protected $primaryKey = 'IDEtude';

    public function PrixExams():HasMany
    {
        return $this->hasMany(PrixExam::class, 'etude_id', 'IDEtude');
    }

    public function Service(): BelongsTo
    {
        return $this->belongsTo(Service::class, 'service_id', 'IDService');
    }
}
