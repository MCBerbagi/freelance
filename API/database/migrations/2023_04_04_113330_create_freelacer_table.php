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
        Schema::create('freelacer', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->string('name');
            $table->string('cover');
            $table->string('served_category');
            $table->string('lat');
            $table->string('lng');
            $table->double('hourly_price',10,2)->nullable();
            $table->text('gallery')->nullable();
            $table->text('descriptions')->nullable();
            $table->integer('total_experience');
            $table->integer('cid')->nullable();
            $table->text('zipcode')->nullable();
            $table->double('rating',10,2)->nullable();
            $table->integer('total_rating')->nullable();
            $table->tinyInteger('verified')->nullable();
            $table->tinyInteger('available')->nullable();
            $table->tinyInteger('have_shop')->nullable();
            $table->tinyInteger('popular')->nullable();
            $table->tinyInteger('in_home')->nullable();
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
        Schema::dropIfExists('freelacer');
    }
};
