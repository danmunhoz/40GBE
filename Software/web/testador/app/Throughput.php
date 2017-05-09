<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Throughput extends Model
{
    protected $table = 'throughput_result';
    protected $fillable = ['execution_id'];
}
