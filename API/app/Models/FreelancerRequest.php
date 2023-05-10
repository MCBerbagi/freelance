<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FreelancerRequest extends Model
{
    use HasFactory;

    protected $table = 'freelancer_request';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['first_name','last_name','email','password','gender','country_code',
    'mobile','cover','served_category','lat','lng','hourly_price','descriptions',
    'total_experience','cid','zipcode','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'total_experience' => 'integer',
        'cid' => 'integer',
        'status' => 'integer',
    ];
}
