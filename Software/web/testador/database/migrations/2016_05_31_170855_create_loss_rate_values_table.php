<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLossRateValuesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loss_rate_values', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('loss_rate_id')->unsigned();
            $table->foreign('loss_rate_id')->references('id')->on('loss_rate_result');
            $table->double('rate', 64, 4);
            $table->double('loss', 64, 4);
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
        Schema::drop('loss_rate_values');
    }
}
