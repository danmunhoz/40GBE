<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Execution;
use App\Throughput;
use App\Latency;
use App\LossRate;
use App\LossRateValue;
use App\BackToBack;
use App\SystemRecovery;
use App\TimedThroughput;

class PagesController extends Controller
{
    public function home()
    {
    	return view('home')->
            with('tab', 'home');
    }


    public function report($id=0)
    {
        /* Get the execution with the given id */
        $execution = Execution::where('id', $id)->first();

        /* Collect all Loss Rates values related to the given execution */      
        $lossRates = LossRate::where('execution_id', $execution->id)->get();      
        foreach ($lossRates as $i => $lossRate) {     
            $lossRates[$i]->values = LossRateValue::where('loss_rate_id', $lossRate->id)->get();      
        }

        /* Assembles the test data into a structure */
        $data = [
        'execution'         => $execution->toJson(),
        'throughput'        => Throughput::firstOrNew(['execution_id' => $execution->id])->toJson(),
        'latency'           => Latency::firstOrNew(['execution_id' => $execution->id])->toJson(),
        'lossRates'         => $lossRates,
        'backToBack'        => BackToBack::firstOrNew(['execution_id' => $execution->id])->toJson(),
        'systemRecovery'    => SystemRecovery::firstOrNew(['execution_id' => $execution->id])->toJson(),
        'timed_throughput'  => TimedThroughput::firstOrNew(['execution_id' => $execution->id])->toJson()
        ];
        /* Shows the results blade page */
        return view('results')->
            with('data', $data)->
            with('tab', 'results');
    }


    public function kill($id=0)
    {
        $execution_db = Execution::where('id', $id)->first();
        $execution_db->status = 'cancelled';
        $execution_db->save();

        return redirect()->route('home');
    }
}
