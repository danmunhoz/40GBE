<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSystemRecoveryResultTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('system_recovery_result', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('execution_id')->unsigned();
            $table->foreign('execution_id')->references('id')->on('executions');
            $table->double('ps64110R', 64, 4);
            $table->double('ps128110R', 64, 4);
            $table->double('ps256110R', 64, 4);
            $table->double('ps512110R', 64, 4);
            $table->double('ps768110R', 64, 4);
            $table->double('ps1024110R', 64, 4);
            $table->double('ps1280110R', 64, 4);
            $table->double('ps1518110R', 64, 4);
            $table->double('ps6455R', 64, 4);
            $table->double('ps12855R', 64, 4);
            $table->double('ps25655R', 64, 4);
            $table->double('ps51255R', 64, 4);
            $table->double('ps76855R', 64, 4);
            $table->double('ps102455R', 64, 4);
            $table->double('ps128055R', 64, 4);
            $table->double('ps151855R', 64, 4);
            $table->double('ps64RT', 64, 4);
            $table->double('ps128RT', 64, 4);
            $table->double('ps256RT', 64, 4);
            $table->double('ps512RT', 64, 4);
            $table->double('ps768RT', 64, 4);
            $table->double('ps1024RT', 64, 4);
            $table->double('ps1280RT', 64, 4);
            $table->double('ps1518RT', 64, 4);
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
        Schema::drop('system_recovery_result');
    }
}
