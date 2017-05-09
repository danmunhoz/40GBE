@extends('inc.layout')
@section('body')

    @include('inc.navigator')

    <div class="container">
        <div class="page-header">
            <div class="row">
                <div class="col-md-11">
                    <h1>Test Result <small>Results for the test executed in "{{ json_decode($data['execution'])->name }}"</small></h1>
                    <h2>flags: <small>{{ json_decode($data['execution'])->command }}</small></h2>
                    <h3>report time: <small>{{ date('l jS \of F Y h:i:s A') }}</small></h3>
                </div>
                <div class="col-md-1">
	            	<button class="btn btn-link print" type="button">
	            		<i class="material-icons">print</i>
	            	</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div id="result-list" class="col-md-9">

            	@if (count(json_decode($data['throughput'], true)) > 1)
				<canvas id="throughputChart"></canvas>
				<script>
				var data_throughput = jQuery.parseJSON('{!! $data['throughput'] !!}');
				var ctx = document.getElementById("throughputChart");
				var myChart = new Chart(ctx, {
				    type: 'line',
				    fill: false,
				    maintainAspectRatio: false,
				    responsive: true,
				    data: {
					    datasets: [{
					    	label: 'Throughput',
					    	borderColor: "rgba(75,192,192,1)",
					    	backgroundColor: "rgba(75,192,192,.2)",
						    data: [{
							 	x: 64,
								y: data_throughput.ps64R },{
							 	x: 128,
								y: data_throughput.ps128R },{
							 	x: 256,
								y: data_throughput.ps256R },{
							 	x: 512,
								y: data_throughput.ps512R },{
							 	x: 768,
								y: data_throughput.ps768R },{
							 	x: 1024,
								y: data_throughput.ps1024R },{
							 	x: 1280,
								y: data_throughput.ps1280R },{
							 	x: 1518,
								y: data_throughput.ps1518R
						    }]
					    }]
					},
				    options: {
				    	title: {
				    		display: true,
				    		text: "Throughput test"
				    	},
				    	legend: {
				    		display: false
				    	},
				        scales: {
				            xAxes: [{
				            	scaleLabel: {
				            		display: true,
				            		labelString: "Packet Size (B)"
				            	},
				            	type: 'linear',
				            	position: 'bottom'
				            }],
				            yAxes: [{
				            	scaleLabel: {
				            		display: true,
				            		labelString: "Throughput Rate (Mb/s)"
				            	},
				            	type: 'linear'
				            }]
				        }
				    }
				});
				</script>
				@endif

				@if (count(json_decode($data['latency'], true)) > 1)
				<?php
				$latency = json_decode($data['latency']);
				?>
				<div class="table-responsive">
				    <table class="table table-hover">
				        <thead>
				            <tr>
				                <th>Frame Size(KB)</th>
				                <th>Rate(Mb/s)</th>
				                <th>Media Type(Mb/s)</th>
				                <th>Latency(μs)</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>64</td>
				                <td>{{ $latency->ps64R }}</td>
				                <td>{{ $latency->ps64MT }}</td>
				                <td>{{ $latency->ps64L }}</td>
				            </tr>
				            <tr>
				                <td>128</td>
				                <td>{{ $latency->ps128R }}</td>
				                <td>{{ $latency->ps128MT }}</td>
				                <td>{{ $latency->ps128L }}</td>
				            </tr>
				            <tr>
				                <td>256</td>
				                <td>{{ $latency->ps256R }}</td>
				                <td>{{ $latency->ps256MT }}</td>
				                <td>{{ $latency->ps256L }}</td>
				            </tr>
				            <tr>
				                <td>512</td>
				                <td>{{ $latency->ps512R }}</td>
				                <td>{{ $latency->ps512MT }}</td>
				                <td>{{ $latency->ps512L }}</td>
				            </tr>
				            <tr>
				                <td>768</td>
				                <td>{{ $latency->ps768R }}</td>
				                <td>{{ $latency->ps768MT }}</td>
				                <td>{{ $latency->ps768L }}</td>
				            </tr>
				            <tr>
				                <td>1024</td>
				                <td>{{ $latency->ps1024R }}</td>
				                <td>{{ $latency->ps1024MT }}</td>
				                <td>{{ $latency->ps1024L }}</td>
				            </tr>
				            <tr>
				                <td>1280</td>
				                <td>{{ $latency->ps1280R }}</td>
				                <td>{{ $latency->ps1280MT }}</td>
				                <td>{{ $latency->ps1280L }}</td>
				            </tr>
				            <tr>
				                <td>1518</td>
				                <td>{{ $latency->ps1518R }}</td>
				                <td>{{ $latency->ps1518MT }}</td>
				                <td>{{ $latency->ps1518L }}</td>
				            </tr>
				        </tbody>
				        <caption>Latency</caption>
				    </table>
				</div>
				@endif

				@if (count(json_decode($data['lossRates'], true)) > 0)
				<canvas id="lossRateChart"></canvas>
				<script>
				var data_loss_rate = jQuery.parseJSON('{!! $data['lossRates'] !!}');
				var data_sets = [];
				var colors = [
				'rgba(0, 153, 255, 1)',
				'rgba(0, 153, 255, 0)',
				'rgba(0, 204, 102, 1)',
				'rgba(0, 204, 102, 0)',
				'rgba(255, 255, 102, 1)',
				'rgba(255, 255, 102, 0)',
				'rgba(255, 77, 77, 1)',
				'rgba(255, 77, 77, 0)',
				'rgba(163, 102, 255, 1)',
				'rgba(163, 102, 255, 0)',
				'rgba(217, 179, 140, 1)',
				'rgba(217, 179, 140, 0)',
				'rgba(102, 255, 217, 1)',
				'rgba(102, 255, 217, 0)',
				'rgba(204, 204, 153, 1)',
				'rgba(204, 204, 153, 0)',
				];
				jQuery.each(data_loss_rate, function(i, result) {
					var dataset = {};
					dataset['data'] = [];
					jQuery.each(result.values, function(j, value) {
						var point = {}
						point['x'] = value.rate;
						point['y'] = value.loss;
						dataset['data'].push(point);
					});
					dataset['lineTension'] = 0;
					dataset['label'] = result.rate;
					dataset['borderColor'] = colors[i*2];
					dataset['backgroundColor'] = colors[i*2+1];
					data_sets.push(dataset);
				});
				var ctx = document.getElementById("lossRateChart");
				var myChart = new Chart(ctx, {
				    type: 'line',
				    fill: false,
				    maintainAspectRatio: false,
				    responsive: true,
				    data: {
					    datasets: data_sets
					},
				    options: {
				    	title: {
				    		display: true,
				    		text: "Loss-Rate Test"
				    	},
				        scales: {
				            xAxes: [{
				            	scaleLabel: {
				            		display: true,
				            		labelString: "Rate (%)"
				            	},
				            	type: 'linear',
				            	position: 'bottom'
				            }],
				            yAxes: [{
				            	scaleLabel: {
				            		display: true,
				            		labelString: "Loss-Rate (%)"
				            	},
				            	type: 'linear'
				            }]
				        }
				    }
				});
				</script>
				@endif

				@if (count(json_decode($data['backToBack'], true)) > 1)
				<?php
				$backToBack = json_decode($data['backToBack']);
				?>
				<div class="table-responsive">
				    <table class="table table-hover">
				        <thead>
				            <tr>
				                <th>Frame Size(KB)</th>
				                <th>Maximum Packet Count</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>64</td>
				                <td>{{ $backToBack->ps64MPC }}</td>
				            </tr>
				            <tr>
				                <td>128</td>
				                <td>{{ $backToBack->ps128MPC }}</td>
				            </tr>
				            <tr>
				                <td>256</td>
				                <td>{{ $backToBack->ps256MPC }}</td>
				            </tr>
				            <tr>
				                <td>512</td>
				                <td>{{ $backToBack->ps512MPC }}</td>
				            </tr>
				            <tr>
				                <td>768</td>
				                <td>{{ $backToBack->ps768MPC }}</td>
				            </tr>
				            <tr>
				                <td>1024</td>
				                <td>{{ $backToBack->ps1024MPC }}</td>
				            </tr>
				            <tr>
				                <td>1280</td>
				                <td>{{ $backToBack->ps1280MPC }}</td>
				            </tr>
				            <tr>
				                <td>1518</td>
				                <td>{{ $backToBack->ps1518MPC }}</td>
				            </tr>
				        </tbody>
				        <caption>Back-to-back</caption>
				    </table>
				</div>
				@endif

				@if (count(json_decode($data['systemRecovery'], true)) > 1)
				<?php
				$systemRecovery = json_decode($data['systemRecovery']);
				?>
				<div class="table-responsive">
				    <table class="table table-hover">
				        <thead>
				            <tr>
				                <th>Frame Size(KB)</th>
				                <th>110% Rate(Mb/s)</th>
				                <th>55% Rate(Mb/s)</th>
				                <th>Recovery Time(μs)</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>64</td>
				                <td>{{ $systemRecovery->ps64110R }}</td>
				                <td>{{ $systemRecovery->ps6455R }}</td>
				                <td>{{ $systemRecovery->ps64RT }}</td>
				            </tr>
				            <tr>
				                <td>128</td>
				                <td>{{ $systemRecovery->ps128110R }}</td>
				                <td>{{ $systemRecovery->ps12855R }}</td>
				                <td>{{ $systemRecovery->ps128RT }}</td>
				            </tr>
				            <tr>
				                <td>256</td>
				                <td>{{ $systemRecovery->ps256110R }}</td>
				                <td>{{ $systemRecovery->ps25655R }}</td>
				                <td>{{ $systemRecovery->ps256RT }}</td>
				            </tr>
				            <tr>
				                <td>512</td>
				                <td>{{ $systemRecovery->ps512110R }}</td>
				                <td>{{ $systemRecovery->ps51255R }}</td>
				                <td>{{ $systemRecovery->ps512RT }}</td>
				            </tr>
				            <tr>
				                <td>768</td>
				                <td>{{ $systemRecovery->ps768110R }}</td>
				                <td>{{ $systemRecovery->ps76855R }}</td>
				                <td>{{ $systemRecovery->ps768RT }}</td>
				            </tr>
				            <tr>
				                <td>1024</td>
				                <td>{{ $systemRecovery->ps1024110R }}</td>
				                <td>{{ $systemRecovery->ps102455R }}</td>
				                <td>{{ $systemRecovery->ps1024RT }}</td>
				            </tr>
				            <tr>
				                <td>1280</td>
				                <td>{{ $systemRecovery->ps1280110R }}</td>
				                <td>{{ $systemRecovery->ps128055R }}</td>
				                <td>{{ $systemRecovery->ps1280RT }}</td>
				            </tr>
				            <tr>
				                <td>1518</td>
				                <td>{{ $systemRecovery->ps1518110R }}</td>
				                <td>{{ $systemRecovery->ps151855R }}</td>
				                <td>{{ $systemRecovery->ps1518RT }}</td>
				            </tr>
				        </tbody>
				        <caption>System Recovery</caption>
				    </table>
				</div>
				@endif

				@if (count(json_decode($data['timed_throughput'], true)) > 1)
				<?php
				$timed_throughput = json_decode($data['timed_throughput']);
				?>
				<div class="table-responsive">
				    <table class="table table-hover">
				        <thead>
				            <tr>
				                <th>Packet Size</th>
				                <th>Real Throughput Rate</th>
				                <th>Sent Packets</th>
				                <th>Received Packets</th>
				                <th>Lost Packets</th>
				                <th>BERT</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>{{ $timed_throughput->ps }}</td>
				                <td>{{ $timed_throughput->R }}</td>
				                <td>{{ $timed_throughput->SP }}</td>
				                <td>{{ $timed_throughput->RP }}</td>
				                <td>{{ $timed_throughput->LP }}</td>
				                <td>{{ $timed_throughput->BERT }}</td>
				            </tr>
				        </tbody>
				        <caption>Timed-throughput</caption>
				    </table>
				</div>
				@endif


			</div>
            @include('inc.jobs')
		</div>
	</div>

@endsection