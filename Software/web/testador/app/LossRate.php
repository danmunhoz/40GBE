<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class LossRate extends Model
{
    protected $table = 'loss_rate_result';
    protected $fillable = ['execution_id'];
}
