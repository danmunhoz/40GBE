<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLossRateResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loss_rate_result', function (Blueprint $table) {
            $table->increments('id');
            $table->bigInteger('rate');
            $table->integer('execution_id')->unsigned();
            $table->foreign('execution_id')->references('id')->on('executions');
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
        Schema::drop('loss_rate_result');
    }
}
