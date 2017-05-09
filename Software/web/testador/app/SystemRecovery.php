<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SystemRecovery extends Model
{
    protected $table = 'system_recovery_result';
    protected $fillable = ['execution_id'];
}
