<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Latency extends Model
{
    protected $table = 'latency_result';
    protected $fillable = ['execution_id'];
}
