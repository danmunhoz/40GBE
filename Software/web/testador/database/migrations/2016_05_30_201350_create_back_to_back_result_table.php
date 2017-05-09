<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBackToBackResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('back_to_back_result', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('execution_id')->unsigned();
            $table->foreign('execution_id')->references('id')->on('executions');
            $table->bigInteger('ps64MPC');
            $table->bigInteger('ps128MPC');
            $table->bigInteger('ps256MPC');
            $table->bigInteger('ps512MPC');
            $table->bigInteger('ps768MPC');
            $table->bigInteger('ps1024MPC');
            $table->bigInteger('ps1280MPC');
            $table->bigInteger('ps1518MPC');
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
        Schema::drop('back_to_back_result');
    }
}
