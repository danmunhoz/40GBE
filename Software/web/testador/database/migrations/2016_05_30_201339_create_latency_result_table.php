<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLatencyResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('latency_result', function (Blueprint $table) {
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
            $table->double('ps64MT', 64, 4);
            $table->double('ps128MT', 64, 4);
            $table->double('ps256MT', 64, 4);
            $table->double('ps512MT', 64, 4);
            $table->double('ps768MT', 64, 4);
            $table->double('ps1024MT', 64, 4);
            $table->double('ps1280MT', 64, 4);
            $table->double('ps1518MT', 64, 4);
            $table->double('ps64L', 64, 4);
            $table->double('ps128L', 64, 4);
            $table->double('ps256L', 64, 4);
            $table->double('ps512L', 64, 4);
            $table->double('ps768L', 64, 4);
            $table->double('ps1024L', 64, 4);
            $table->double('ps1280L', 64, 4);
            $table->double('ps1518L', 64, 4);
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
        Schema::drop('latency_result');
    }
}
