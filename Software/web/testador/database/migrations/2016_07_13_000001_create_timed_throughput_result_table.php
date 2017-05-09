<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTimedThroughputResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('timed_throughput_result', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('execution_id')->unsigned();
            $table->foreign('execution_id')->references('id')->on('executions');
            $table->double('ps', 64, 4);
            $table->double('R', 64, 4);
            $table->double('SP', 64, 4);
            $table->double('RP', 64, 4);
            $table->double('LP', 64, 4);
            $table->double('BERT', 64, 4);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('timed_throughput_result');
    }
}
