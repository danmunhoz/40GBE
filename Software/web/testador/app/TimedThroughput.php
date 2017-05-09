<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TimedThroughput extends Model
{
    protected $table = 'timed_throughput_result';
    protected $fillable = ['execution_id'];
}
