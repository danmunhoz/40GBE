<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateThroughputResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('throughput_result', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('execution_id')->unsigned();
            $table->foreign('execution_id')->references('id')->on('executions');
            $table->double('ps64R', 64, 4);
            $table->double('ps128R', 64, 4);
            $table->double('ps256R', 64, 4);
            $table->double('ps512R', 64, 4);
            $table->double('ps768R', 64, 4);
            $table->double('ps1024R', 64, 4);
            $table->double('ps1280R', 64, 4);
            $table->double('ps1518R', 64, 4);
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
        Schema::drop('throughput_result');
    }
}
