<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CompteRenduModel extends Model
{
    use HasFactory;

    protected $primaryKey = 'IDCRM';

    protected $fillable = ['titreCRM', 'contenuCRM', 'UICRM', 'etatCRM', 'etude_id'];

    public function etude()
    {
        return $this->belongsTo(Etude::class, 'etude_id', 'IDEtude');
    }
}
