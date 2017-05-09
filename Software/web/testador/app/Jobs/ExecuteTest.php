<?php

namespace App\Jobs;

use App\Jobs\Job;
use App\Execution;
use App\Latency;
use App\SystemRecovery;
use App\Throughput;
use App\BackToBack;
use App\LossRateValue;
use App\LossRate;
use App\TimedThroughput;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class ExecuteTest extends Job implements ShouldQueue
{
    use InteractsWithQueue, SerializesModels;

    protected $sfp;
    protected $command;
    protected $execution_db;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($sfp, $command, $name)
    {
        $this->sfp = $sfp;
        $this->command = $command;

        $this->execution_db = new Execution;
        $this->execution_db->sfp = $sfp;
        $this->execution_db->command = $command;
        $this->execution_db->status = 'waiting';
        $this->execution_db->name = $name;

        $this->execution_db->save();
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        $this->execution_db = Execution::find($this->execution_db->id);   
        if ($this->execution_db->status != 'cancelled' && $this->execution_db->status != 'error') {

            $this->execution_db->status = 'running';
            $this->execution_db->save();

            system('rm -rf ./sfp*');

            $descr = array(
                0 => array('pipe', 'r') ,
                1 => array('pipe', 'w') ,
                2 => array('pipe', 'w')
            );
            $pipes = array();

            $exec = './resources/rfc/RFC2544 '.$this->command;
            $exec .= ' --sfp'.$this->sfp;
            $process = proc_open($exec, $descr, $pipes);
            $flagCancel = false;
            if (is_resource($process)) {
                while(proc_get_status($process)['running']){
                    $this->execution_db = Execution::find($this->execution_db->id);
                    if ($this->execution_db->status == 'cancelled' and !$flagCancel) {
                        fclose($pipes[0]);
                        fclose($pipes[1]);
                        proc_terminate($process);
                        exec("./resources/rfc/RFC2544 --soft-reset --sfp".$this->sfp);
                        $flagCancel = true;
                    }
                    sleep(5);
                    $timed_throughputs = TimedThroughput::where('execution_id', $this->execution_db->id)->first();
                    if(count($timed_throughputs) == 0){
                        $timed_throughput = new TimedThroughput;
                        $timed_throughput->execution_id = $this->execution_db->id;
                    }
                    if ($this->execution_db->status == 'running') {
                        exec('./resources/rfc/RFC2544 --read-status --sfp'.$this->execution_db->sfp);

                        $file_dir = 'sfp'.$this->execution_db->sfp.'_temp_result.csv';
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
                            $timed_throughputs = [];
                            array_push($timed_throughputs, $timed_throughput);
                        }
                    }
                }
                if(! $flagCancel){
                    fclose($pipes[0]);
                    fclose($pipes[1]);
                    proc_close($process);
                }
            }

            if(! $flagCancel){
                $file_dir = 'sfp'.$this->sfp.'_data/throughput.csv';
                if( file_exists($file_dir) ){
                    $throughput = new Throughput;
                    $throughput->execution_id = $this->execution_db->id;
                    $data = file_get_contents($file_dir);
                    $data_lines = explode(PHP_EOL, $data);
                    $data_array = array();
                    foreach ($data_lines as $line) {
                        $data_array[] = str_getcsv($line);   
                    }

                    foreach ($data_array as $line) {
                        switch ($line[0]) {
                            case '64':
                                $throughput->ps64R = $line[1];
                                break;
                            case '128':
                                $throughput->ps128R = $line[1];
                                break;
                            case '256':
                                $throughput->ps256R = $line[1];
                                break;
                            case '512':
                                $throughput->ps512R = $line[1];
                                break;
                            case '768':
                                $throughput->ps768R = $line[1];
                                break;
                            case '1024':
                                $throughput->ps1024R = $line[1];
                                break;
                            case '1280':
                                $throughput->ps1280R = $line[1];
                                break;
                            case '1518':
                                $throughput->ps1518R = $line[1];
                                break;
                            default:
                                # code...
                                break;
                        }
                    }

                    $throughput->save();
                }

                $file_dir = 'sfp'.$this->sfp.'_data/latency.csv';
                if( file_exists($file_dir) ){
                    $latency = new Latency;
                    $latency->execution_id = $this->execution_db->id;
                    $data = file_get_contents($file_dir);
                    $data_lines = explode(PHP_EOL, $data);
                    $data_array = array();
                    foreach ($data_lines as $line) {
                        $data_array[] = str_getcsv($line);   
                    }

                    foreach ($data_array as $line) {
                        switch ($line[0]) {
                            case '64':
                                $latency->ps64R = $line[1];
                                $latency->ps64MT = $line[2];
                                $latency->ps64L = $line[3];
                                break;
                            case '128':
                                $latency->ps128R = $line[1];
                                $latency->ps128MT = $line[2];
                                $latency->ps128L = $line[3];
                                break;
                            case '256':
                                $latency->ps256R = $line[1];
                                $latency->ps256MT = $line[2];
                                $latency->ps256L = $line[3];
                                break;
                            case '512':
                                $latency->ps512R = $line[1];
                                $latency->ps512MT = $line[2];
                                $latency->ps512L = $line[3];
                                break;
                            case '768':
                                $latency->ps768R = $line[1];
                                $latency->ps768MT = $line[2];
                                $latency->ps768L = $line[3];
                                break;
                            case '1024':
                                $latency->ps1024R = $line[1];
                                $latency->ps1024MT = $line[2];
                                $latency->ps1024L = $line[3];
                                break;
                            case '1280':
                                $latency->ps1280R = $line[1];
                                $latency->ps1280MT = $line[2];
                                $latency->ps1280L = $line[3];
                                break;
                            case '1518':
                                $latency->ps1518R = $line[1];
                                $latency->ps1518MT = $line[2];
                                $latency->ps1518L = $line[3];
                                break;
                            default:
                                # code...
                                break;
                        }
                    }

                    $latency->save();
                }

                $loss_rate_files = glob('sfp'.$this->sfp.'_data/loss_rate*.csv');
                if( ! empty($loss_rate_files) ){
                    foreach ($loss_rate_files as $file_dir) {
                        $lossRate = new LossRate;
                        $lossRate->execution_id = $this->execution_db->id;
                        preg_match('/loss_rate([0-9]+).csv/', $file_dir, $matches);
                        $lossRate->rate = $matches[1];
                        $lossRate->save();

                        $data = file_get_contents($file_dir);
                        $data_lines = explode(PHP_EOL, $data);
                        $data_array = array();
                        foreach ($data_lines as $line) {
                            $data_array[] = str_getcsv($line);   
                        }

                        foreach ($data_array as $line) {
                            if(count($line) == 2){
                                $lossRateValue = new LossRateValue;
                                $lossRateValue->rate = $line[0];
                                $lossRateValue->loss = $line[1];
                                $lossRateValue->loss_rate_id = $lossRate->id;
                                $lossRateValue->save();
                            }
                        }
                    }
                }

                $file_dir = 'sfp'.$this->sfp.'_data/back_to_back.csv';
                if( file_exists($file_dir) ){
                    $backToBack = new BackToBack;
                    $backToBack->execution_id = $this->execution_db->id;
                    $data = file_get_contents($file_dir);
                    $data_lines = explode(PHP_EOL, $data);
                    $data_array = array();
                    foreach ($data_lines as $line) {
                        $data_array[] = str_getcsv($line);   
                    }

                    foreach ($data_array as $line) {
                        switch ($line[0]) {
                            case '64':
                                $backToBack->ps64MPC = $line[1];
                                break;
                            case '128':
                                $backToBack->ps128MPC = $line[1];
                                break;
                            case '256':
                                $backToBack->ps256MPC = $line[1];
                                break;
                            case '512':
                                $backToBack->ps512MPC = $line[1];
                                break;
                            case '768':
                                $backToBack->ps768MPC = $line[1];
                                break;
                            case '1024':
                                $backToBack->ps1024MPC = $line[1];
                                break;
                            case '1280':
                                $backToBack->ps1280MPC = $line[1];
                                break;
                            case '1518':
                                $backToBack->ps1518MPC = $line[1];
                                break;
                            default:
                                # code...
                                break;
                        }
                    }

                    $backToBack->save();
                }

                $file_dir = 'sfp'.$this->sfp.'_data/system_recovery.csv';
                if( file_exists($file_dir) ){
                    $systemRecovery = new SystemRecovery;
                    $systemRecovery->execution_id = $this->execution_db->id;
                    $data = file_get_contents($file_dir);
                    $data_lines = explode(PHP_EOL, $data);
                    $data_array = array();
                    foreach ($data_lines as $line) {
                        $data_array[] = str_getcsv($line);   
                    }

                    foreach ($data_array as $line) {
                        switch ($line[0]) {
                            case '64':
                                $systemRecovery->ps64110R = $line[1];
                                $systemRecovery->ps6455R = $line[2];
                                $systemRecovery->ps64RT = $line[3];
                                break;
                            case '128':
                                $systemRecovery->ps128110R = $line[1];
                                $systemRecovery->ps12855R = $line[2];
                                $systemRecovery->ps128RT = $line[3];
                                break;
                            case '256':
                                $systemRecovery->ps256110R = $line[1];
                                $systemRecovery->ps25655R = $line[2];
                                $systemRecovery->ps256RT = $line[3];
                                break;
                            case '512':
                                $systemRecovery->ps512110R = $line[1];
                                $systemRecovery->ps51255R = $line[2];
                                $systemRecovery->ps512RT = $line[3];
                                break;
                            case '768':
                                $systemRecovery->ps768110R = $line[1];
                                $systemRecovery->ps76855R = $line[2];
                                $systemRecovery->ps768RT = $line[3];
                                break;
                            case '1024':
                                $systemRecovery->ps1024110R = $line[1];
                                $systemRecovery->ps102455R = $line[2];
                                $systemRecovery->ps1024RT = $line[3];
                                break;
                            case '1280':
                                $systemRecovery->ps1280110R = $line[1];
                                $systemRecovery->ps128055R = $line[2];
                                $systemRecovery->ps1280RT = $line[3];
                                break;
                            case '1518':
                                $systemRecovery->ps1518110R = $line[1];
                                $systemRecovery->ps151855R = $line[2];
                                $systemRecovery->ps1518RT = $line[3];
                                break;
                            default:
                                # code...
                                break;
                        }
                    }

                    $systemRecovery->save();
                }

                $file_dir = 'sfp'.$this->sfp.'_data/timed_throughput.csv';
                if( file_exists($file_dir) ){
                    $throughput = new TimedThroughput;
                    $throughput->execution_id = $this->execution_db->id;
                    $data = file_get_contents($file_dir);
                    $data_lines = explode(PHP_EOL, $data);
                    $data_array = array();
                    foreach ($data_lines as $line) {
                        $data_array[] = str_getcsv($line);
                    }

                    $line = $data_array[0];

                    $throughput->ps = $line[0];
                    $throughput->R = $line[4];
                    $throughput->SP = $line[1];
                    $throughput->RP = $line[2];
                    $throughput->LP = $line[3];
                    $throughput->BERT = $line[5];
                    $throughput->save();
                }

                $this->execution_db->status = 'done';
                $this->execution_db->save();
            }
        }
    }

    public function failed()
    {
        $this->execution_db->status = 'failed';
        $this->execution_db->save();
    }
}
