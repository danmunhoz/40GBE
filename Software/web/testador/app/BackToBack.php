<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class BackToBack extends Model
{
    protected $table = 'back_to_back_result';
    protected $fillable = ['execution_id'];
}
