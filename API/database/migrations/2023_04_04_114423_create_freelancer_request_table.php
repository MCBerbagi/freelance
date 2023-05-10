<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('freelancer_request', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('email')->unique();
            $table->string('password');
            $table->string('country_code');
            $table->string('mobile');
            $table->string('cover')->nullable();
            $table->string('served_category');
            $table->tinyInteger('gender')->nullable();
            $table->integer('cid')->nullable();
            $table->text('zipcode')->nullable();
            $table->string('lat');
            $table->string('lng');
            $table->double('hourly_price',10,2)->nullable();
            $table->text('descriptions')->nullable();
            $table->integer('total_experience');
            $table->text('extra_field')->nullable();
            $table->tinyInteger('status')->default(1);
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
        Schema::dropIfExists('freelancer_request');
    }
};
