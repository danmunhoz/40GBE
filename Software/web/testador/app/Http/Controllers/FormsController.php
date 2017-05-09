<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Jobs\ExecuteTest;
use DB;

class FormsController extends Controller
{
		public function execute(Request $request)
		{
			/* Validates the given data values */
			$this->validate($request, [
				'sfp.*.test_selector',				'digits_between:1,3',
				'sfp.*.scheduled',					'boolean',
				'sfp.*.throughput',					'boolean',
				'sfp.*.latency',					'boolean',
				'sfp.*.back_to_back',				'boolean',
				'sfp.*.loss_rate',					'boolean',
				'sfp.*.system_recovery',			'boolean',
				'sfp.*.top_rate',					'in:1000,10000',
				'sfp.*.packet_number',				'digits_between:1000,100000000000',
				'sfp.*.packet_limit_back_to_back',	'digits_between:1000,100000000000',
				'sfp.*.acceptable_loss_rate',		'digits_between:0,10',
				'sfp.*.acceptable_timed_loss_rate',	'digits_between:0,10',
				'sfp.*.latency_load_time',			'digits_between:1,600',
				'sfp.*.ps64',						'boolean',
				'sfp.*.ps128',						'boolean',
				'sfp.*.ps256',						'boolean',
				'sfp.*.ps512',						'boolean',
				'sfp.*.ps768',						'boolean',
				'sfp.*.ps1024',						'boolean',
				'sfp.*.ps1280',						'boolean',
				'sfp.*.ps1518',						'boolean',
				'sfp.*.throughput_rate',			'digits_between:1,10000',
				'sfp.*.timed_throughput_time',		'digits_between:1,3000000',
				'sfp.*.payload_selector',			'digits_between:0,3',
				'sfp.*.polynome_selector',			'digits_between:0,3',
				'sfp.*.custom_size',				'digits_between:64,9000',				
				'sfp.*.mac_filter',					'digits_between:0,3'				
			]);

			/* Array to contain the specific call flags */
			$commands = [];
			/* Iterates over the requested values to test at each SFP */
			for ($i=1; $i <= 4; $i++) {
				/* Contains an identificator related to the requested test */
				$name = 'NONE';
				/* Contains the flags related to the requested test */
				$exec = 'NOTHING';

				/* Checks if the user requested a test in the given SFP */
				if($request->input('sfp.'.$i.'.scheduled')){

					/* Deals with the request according to the requested test */
					switch($request->input('sfp.'.$i.'.test_selector')){
						
						/* RFC2544 */
						case '1':
								/* Set test user-friendly name */
								$name = 'rfc2544';
								/* Assembles the execution command flags */
								$exec = '';
								if($request->input('sfp.'.$i.'.throughput')){
										$exec .= " --throughput";
								}
								if($request->input('sfp.'.$i.'.latency')){
										$exec .= " --latency";
								}
								if($request->input('sfp.'.$i.'.back_to_back')){
										$exec .= " --back-to-back";
								}
								if($request->input('sfp.'.$i.'.loss_rate')){
										$exec .= " --loss-rate";
								}
								if($request->input('sfp.'.$i.'.system_recovery')){
										$exec .= " --system-recovery";
								}
								if($request->has('sfp.'.$i.'.top_rate')){
										$exec .= ' --top-rate '.($request->input('sfp.'.$i.'.top_rate'));
								}
								if($request->has('sfp.'.$i.'.packet_number')){
										$exec .= ' --npkts '.$request->input('sfp.'.$i.'.packet_number');
								}
								if($request->has('sfp.'.$i.'.packet_limit_back_to_back')){
										$exec .= ' --back-to-back-limit '.$request->input('sfp.'.$i.'.packet_limit_back_to_back');
								}
								if($request->has('sfp.'.$i.'.latency_load_time')){
										$exec .= ' --latency-load-time '.$request->input('sfp.'.$i.'.latency_load_time');
								}
								if($request->has('sfp.'.$i.'.acceptable_loss_rate')){
										$exec .= ' --acceptable-error '.$request->input('sfp.'.$i.'.acceptable_loss_rate');
								}
								if($request->has('sfp.'.$i.'.rfc_mac_destination')){
										$mac = $request->input('sfp.'.$i.'.rfc_mac_destination');
										$mac = str_replace(':', '', $mac);
										$exec .= ' --mac-target '.$mac;
								}
								if($request->has('sfp.'.$i.'.rfc_mac_source')){
										$mac = $request->input('sfp.'.$i.'.rfc_mac_source');
										$mac = str_replace(':', '', $mac);
										$exec .= ' --mac-source '.$mac;
								}
	
								$pss = ['ps64', 'ps128', 'ps256', 'ps512', 'ps768', 'ps1024', 'ps1280', 'ps1518'];
								for ($j=0; $j < 8; $j++) {
									if ($request->input('sfp.'.$i.'.'.$pss[$j])) {
										$exec .= ' --'.($pss[$j]);
									}
								}
	
								break;
	
						/* Timed-throughput */
						case '2':
								/* Set test user-friendly name */
								$name = 'Timed Throughput';
								/* Assembles the execution command flags */
								$exec = ' --timed-throughput';
								if($request->has('sfp.'.$i.'.timed_throughput_time')){
									$exec .= ' --timing '.$request->input('sfp.'.$i.'.timed_throughput_time');
								}
								if($request->has('sfp.'.$i.'.throughput_rate')){
										$exec .= ' --top-rate '.$request->input('sfp.'.$i.'.throughput_rate');
								}
								if($request->has('sfp.'.$i.'.acceptable_timed_loss_rate')){
										$exec .= ' --acceptable-error '.$request->input('sfp.'.$i.'.acceptable_timed_loss_rate');
								}
								if($request->has('sfp.'.$i.'.polynome_selector')){
										$exec .= ' --lfsr-polynomial '.$request->input('sfp.'.$i.'.polynome_selector');
								}
								if($request->has('sfp.'.$i.'.payload_selector')){
										$exec .= ' --payload-type '.$request->input('sfp.'.$i.'.payload_selector');
								}
								if($request->has('sfp.'.$i.'.timed_mac_destination')){
										$mac = $request->input('sfp.'.$i.'.timed_mac_destination');
										$mac = str_replace(':', '', $mac);
										$exec .= ' --mac-target '.$mac;
								}
								if($request->has('sfp.'.$i.'.timed_mac_source')){
										$mac = $request->input('sfp.'.$i.'.timed_mac_source');
										$mac = str_replace(':', '', $mac);
										$exec .= ' --mac-source '.$mac;
								}
								if($request->has('sfp.'.$i.'.custom_size')){
										$exec .= ' --pktlen '.$request->input('sfp.'.$i.'.custom_size');;
								}

								break;
	
						/* Loopback */
						case '3':
								/* Set test user-friendly name */
								$name = 'Loopback';
								/* Assembles the execution command flags */
								$exec = ' --loopback';
								if($request->has('sfp.'.$i.'.loopback_mac_source')){
										$mac = $request->input('sfp.'.$i.'.loopback_mac_source');
										$mac = str_replace(':', '', $mac);
										$exec .= ' --mac-source '.$mac;
								}
								if($request->has('sfp.'.$i.'.mac_filter')){
										$exec .= ' --mac-filter '.$request->input('sfp.'.$i.'.mac_filter');;
								}

								break;
	
						/* Undefined */
						default:
							break;
	
					}
					/* Add the channel name to the user-friendly name */
					$name .= ' CH#'.$i;
					/* Add the requested job to the requested SFP */
					$job = (new ExecuteTest($i, $exec, $name))->onQueue('sfp'.$i);
					$this->dispatch($job);
				}
				/* Return the generated command for verification purposes */
				array_push($commands, $exec);
			}
			return redirect()->back()->
					with('commands', $commands);
		}
}
