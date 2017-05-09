<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Execution;
use App\TimedThroughput;

class AjaxController extends Controller
{

    public function jobs()
    {
        $executions = Execution::orderBy('id', 'desc')->get();

        return view('inc.ajax.jobs')->
            with('jobs', $executions);
    }

    public function status()
    {
        $link_status = [false, false, false, false];

        // Executes from the public directory
        exec('../resources/rfc/RFC2544 --read-status --sfp1 --sfp2 --sfp3 --sfp4');

        for ($sfp=1; $sfp <= 4; $sfp++) {
            $file_dir = 'sfp'.$sfp.'_temp_result.csv';
            if (file_exists($file_dir)) {
                $data = file_get_contents($file_dir);
                $data_lines = explode(PHP_EOL, $data);
                $status = str_getcsv($data_lines[0])[6];
                $link_status[$sfp-1] = intval($status) == 1;
            }
        }

        return response()->json($link_status);
    }

    public function updateTimedThroughput($id)
    {
        $timed_throughput = [];

        $execution = Execution::where('id', $id)->first();

        if ($execution->status == 'running') {
            exec('../resources/rfc/RFC2544 --read-status --sfp'.$execution->sfp);

            $file_dir = 'sfp'.$execution->sfp.'_temp_result.csv';
            if (file_exists($file_dir)) {
                $data = file_get_contents($file_dir);
                $data_lines = explode(PHP_EOL, $data);
                $line = str_getcsv($data_lines[0]);

                $timed_throughput = new TimedThroughput;
                $timed_throughput->ps     = $line[0];
                $timed_throughput->R      = $line[4];
                $timed_throughput->SP     = $line[1];
                $timed_throughput->RP     = $line[2];
                $timed_throughput->LP     = $line[3];
                $timed_throughput->BERT   = $line[5];
            }
        }

        return response()->json($timed_throughput);
    }
}
