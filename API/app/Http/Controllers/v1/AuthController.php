<?php
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\ReferralCodes;
use App\Models\Settings;
use App\Models\Appointments;
use App\Models\ProductOrders;
use App\Models\Products;
use App\Models\Otp;
use JWTAuth;
use Illuminate\Hashing\BcryptHasher;
use Illuminate\Support\Facades\Mail;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Validator;
use Carbon\Carbon;
use Artisan;
use DB;
class AuthController extends Controller
{
    public function login(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $user = User::where('email', $request->email)->first();
        if(!$user) return response()->json(['error' => 'User not found.'], 500);
        if (!(new BcryptHasher)->check($request->input('password'), $user->password)) {
            return response()->json(['error' => 'Email or password is incorrect. Authentication failed.'], 401);
        }
        $credentials = $request->only('email', 'password');
        try {
            JWTAuth::factory()->setTTL(40320); // Expired Time 28days
            if (! $token = JWTAuth::attempt($credentials, ['exp' => Carbon::now()->addDays(28)->timestamp])) {
                return response()->json(['error' => 'invalid_credentials'], 401);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'could_not_create_token'], 500);
        }
        return response()->json(['user' => $user,'token'=>$token,'status'=>200], 200);
    }

    public function get_admin(Request $request){
        $data = User::where('type','=','admin')->first();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>true,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function create_admin_account(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'mobile'=>'required',
            'country_code'=>'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $emailValidation = User::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {

            $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
            $data = User::where($matchThese)->first();
            if (is_null($data) || !$data) {
                $checkExistOrNot = User::where('type','=','admin')->first();

                if (is_null($checkExistOrNot)) {
                    $user = User::create([
                        'email' => $request->email,
                        'first_name'=>$request->first_name,
                        'last_name'=>$request->last_name,
                        'type'=>'admin',
                        'status'=>1,
                        'mobile'=>$request->mobile,
                        'cover'=>'NA',
                        'country_code'=>$request->country_code,
                        'gender'=>1,
                        'password' => Hash::make($request->password),
                    ]);

                    $token = JWTAuth::fromUser($user);
                    return response()->json(['user'=>$user,'token'=>$token,'status'=>200], 200);
                }

                $response = [
                    'success' => false,
                    'message' => 'Account already setuped',
                    'status' => 500
                ];
                return response()->json($response, 500);
            }

            $response = [
                'success' => false,
                'message' => 'Mobile is already registered.',
                'status' => 500
            ];
            return response()->json($response, 500);
        }
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function user_register(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'mobile'=>'required',
            'country_code'=>'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $emailValidation = User::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {

            $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
            $data = User::where($matchThese)->first();
            if (is_null($data) || !$data) {

                $user = User::create([
                    'email' => $request->email,
                    'first_name'=>$request->first_name,
                    'last_name'=>$request->last_name,
                    'type'=>'user',
                    'status'=>1,
                    'mobile'=>$request->mobile,
                    'cover'=>'NA',
                    'country_code'=>$request->country_code,
                    'gender'=>1,
                    'password' => Hash::make($request->password),
                    'fcm_token'=>$request->fcm_token
                ]);

                $token = JWTAuth::fromUser($user);
                function clean($string) {
                    $string = str_replace(' ', '-', $string); // Replaces all spaces with hyphens.

                    return preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
                }
                function generateRandomString($length = 10) {
                    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                    $charactersLength = strlen($characters);
                    $randomString = '';
                    for ($i = 0; $i < $length; $i++) {
                        $randomString .= $characters[rand(0, $charactersLength - 1)];
                    }
                    return $randomString;
                }
                $code = generateRandomString(13);
                $code  = strtoupper($code);
                ReferralCodes::create(['uid'=>$user->id,'code'=>$code]);
                return response()->json(['user'=>$user,'token'=>$token,'status'=>200], 200);

            }

            $response = [
                'success' => false,
                'message' => 'Mobile is already registered.',
                'status' => 500
            ];
            return response()->json($response, 500);
        }
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function adminLogin(Request $request){
        $user = User::where('email', $request->email)->first();

        if(!$user) return response()->json(['error' => 'User not found.'], 500);

        // Account Validation
        if (!(new BcryptHasher)->check($request->input('password'), $user->password)) {

            return response()->json(['error' => 'Email or password is incorrect. Authentication failed.'], 401);
        }

        if($user->type !='admin'){
            return response()->json(['error' => 'access denied'], 401);
        }
        // Login Attempt
        $credentials = $request->only('email', 'password');

        try {

            JWTAuth::factory()->setTTL(40320); // Expired Time 28days

            if (! $token = JWTAuth::attempt($credentials, ['exp' => Carbon::now()->addDays(28)->timestamp])) {

                return response()->json(['error' => 'invalid_credentials'], 401);

            }
        } catch (JWTException $e) {

            return response()->json(['error' => 'could_not_create_token'], 500);

        }
        return response()->json(['user' => $user,'token'=>$token,'status'=>200], 200);
    }

    public function uploadImage(Request $request){
        $validator = Validator::make($request->all(), [
            'image' => 'required|image:jpeg,png,jpg,gif,svg|max:2048'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 505);
        }
        Artisan::call('storage:link', []);
        $uploadFolder = 'images';
        $image = $request->file('image');
        $image_uploaded_path = $image->store($uploadFolder, 'public');
        $uploadedImageResponse = array(
            "image_name" => basename($image_uploaded_path),
            "mime" => $image->getClientMimeType()
        );
        $response = [
            'data'=>$uploadedImageResponse,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function createFreelancerAccount(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'mobile'=>'required',
            'country_code'=>'required',
            'password' => 'required',
            'gender' => 'required',
            'cover' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $emailValidation = User::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {

            $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
            $data = User::where($matchThese)->first();
            if (is_null($data) || !$data) {
                $user = User::create([
                    'email' => $request->email,
                    'first_name'=>$request->first_name,
                    'last_name'=>$request->last_name,
                    'type'=>'freelancer',
                    'status'=>1,
                    'mobile'=>$request->mobile,
                    'cover'=>$request->cover,
                    'country_code'=>$request->country_code,
                    'gender'=>$request->gender,
                    'password' => Hash::make($request->password),
                ]);
                return response()->json(['user'=>$user,'status'=>200], 200);
            }
            $response = [
                'success' => false,
                'message' => 'Mobile is already registered.',
                'status' => 500
            ];
            return response()->json($response, 500);
        }
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function getByID(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = User::find($request->id);
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = User::find($request->id)->update($request->all());
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function logout()
    {
        // Invalidate current logged user token
        auth()->logout();

        // Return message
        return response()
            ->json(['message' => 'Successfully logged out']);
    }

    public function updateUserPasswordWithEmail(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $match =  ['email'=>$request->email,'id'=>$request->id];
        $data = Otp::where($match)->first();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $updates = User::where('email',$request->email)->first();
        $updates->update(['password'=>Hash::make($request->password)]);

        if (is_null($updates)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>true,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function verifyEmailForReset(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $matchThese = ['email' => $request->email];

        $user = User::where($matchThese)->first();

        if(!$user) return response()->json(['data'=>false,'error' => 'User not found.'], 500);

        $settings = Settings::take(1)->first();
        $mail = $request->email;
        $username = $request->email;
        $subject = 'Reset Password';
        $otp = random_int(100000, 999999);
        $savedOTP = Otp::create([
            'otp'=>$otp,
            'email'=>$request->email,
            'status'=>0,
        ]);
        $mailTo = Mail::send('mails/reset',
            [
                'app_name'      =>$settings->name,
                'otp'          => $otp
            ]
            , function($message) use($mail,$username,$subject,$settings){
            $message->to($mail, $username)
            ->subject($subject);
            $message->from($settings->email,$settings->name);
        });

        $response = [
            'data'=>true,
            'mail'=>$mailTo,
            'otp_id'=>$savedOTP->id,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);

    }

    public function verifyEmail(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $emailValidation = User::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {
            $settings = Settings::take(1)->first();
            $mail = $request->email;
            $username = $request->email;
            $subject = 'Reset Password';
            $otp = random_int(100000, 999999);
            $savedOTP = Otp::create([
                'otp'=>$otp,
                'email'=>$request->email,
                'status'=>0,
            ]);
            $mailTo = Mail::send('mails/register',
                [
                    'app_name'      =>$settings->name,
                    'otp'          => $otp
                ]
                , function($message) use($mail,$username,$subject,$settings){
                $message->to($mail, $username)
                ->subject($subject);
                $message->from($settings->email,$settings->name);
            });

            $response = [
                'data'=>true,
                'mail'=>$mailTo,
                'otp_id'=>$savedOTP->id,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function firebaseauth(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $url = url('/api/v1/success_verified');
        return view('fireauth',['mobile'=>$request->mobile,'redirect'=>$url]);
    }

    public function success_verified(){
        return view('verified');
    }

    public function verifyPhone(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile'=>'required',
            'country_code'=>'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data = User::where($matchThese)->first();
        if (is_null($data) || !$data) {
            $settings = Settings::take(1)->first();
            if($settings->sms_name =='0'){ // send with twillo
                $payCreds = DB::table('settings')
                ->select('*')->first();
                if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $credsData = json_decode($payCreds->sms_creds);
                if(is_null($credsData) || is_null($credsData->twilloCreds) || is_null($credsData->twilloCreds->sid)){
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }

                $id = $credsData->twilloCreds->sid;
                $token = $credsData->twilloCreds->token;
                $url = "https://api.twilio.com/2010-04-01/Accounts/$id/Messages.json";
                $from = $credsData->twilloCreds->from;
                $to = $request->country_code.$request->mobile; // twilio trial verified number
                try{
                    $otp = random_int(100000, 999999);
                    $client = new \GuzzleHttp\Client();
                    $response = $client->request('POST', $url, [
                        'headers' =>
                        [
                            'Accept' => 'application/json',
                            'Content-Type' => 'application/x-www-form-urlencoded',
                        ],
                        'form_params' => [
                        'Body' => 'Your Verification code is : '.$otp, //set message body
                        'To' => $to,
                        'From' => $from //we get this number from twilio
                        ],
                        'auth' => [$id, $token, 'basic']
                        ]
                    );
                    $savedOTP = Otp::create([
                        'otp'=>$otp,
                        'email'=>$to,
                        'status'=>0,
                    ]);
                    $response = [
                        'data'=>true,
                        'otp_id'=>$savedOTP->id,
                        'success' => true,
                        'status' => 200,
                    ];
                    return response()->json($response, 200);
                }catch (Exception $e){
                    echo "Error: " . $e->getMessage();
                }

            }else{ // send with msg91
                $payCreds = DB::table('settings')
                ->select('*')->first();
                if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $credsData = json_decode($payCreds->sms_creds);
                if(is_null($credsData) || is_null($credsData->msg) || is_null($credsData->msg->key)){
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $clientId = $credsData->msg->key;
                $smsSender = $credsData->msg->sender;
                $otp = random_int(100000, 999999);
                $client = new \GuzzleHttp\Client();
                $to = $request->country_code.$request->mobile;
                $res = $client->get('http://api.msg91.com/api/sendotp.php?authkey='.$clientId.'&message=Your Verification code is : '.$otp.'&mobile='.$to.'&sender='.$smsSender.'&otp='.$otp);
                $data = json_decode($res->getBody()->getContents());
                $savedOTP = Otp::create([
                    'otp'=>$otp,
                    'email'=>$to,
                    'status'=>0,
                ]);
                $response = [
                    'data'=>true,
                    'otp_id'=>$savedOTP->id,
                    'success' => true,
                    'status' => 200,
                ];
                return response()->json($response, 200);
            }
        }
        $response = [
            'success' => false,
            'message' => 'Mobile is already registered.',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function checkPhoneExist(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile'=>'required',
            'country_code'=>'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data = User::where($matchThese)->first();
        if (is_null($data) || !$data) {
            $response = [
                'data' => true,
                'message' => 'Ok',
                'status' => 200
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Mobile is already registered.',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function getMyWallet(Request $request){
        // $data = Auth::user();
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = User::find($request->id);
        $data['balance'] = $data->balance;

        $transactions = DB::table('transactions')
        ->select('amount','uuid','type','created_at','updated_at')
        ->where('payable_id',$request->id)
        ->get();
        $response = [
            'data'=>$data,
            'transactions'=>$transactions,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function sendVerificationOnMail(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'country_code'=>'required',
            'mobile'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = User::where('email',$request->email)->first();
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data2 = User::where($matchThese)->first();
        if (is_null($data) && is_null($data2)) {
            $settings = Settings::take(1)->first();
            $generalInfo = Settings::take(1)->first();
            $mail = $request->email;
            $username = $request->email;
            $subject = $request->subject;
            $otp = random_int(100000, 999999);
            $savedOTP = Otp::create([
                'otp'=>$otp,
                'email'=>$request->email,
                'status'=>0,
            ]);
            $mailTo = Mail::send('mails/register',
                [
                    'app_name'      =>$generalInfo->name,
                    'otp'          => $otp
                ]
                , function($message) use($mail,$username,$subject,$generalInfo){
                $message->to($mail, $username)
                ->subject($subject);
                $message->from($generalInfo->email,$generalInfo->name);
            });

            $response = [
                'data'=>true,
                'mail'=>$mailTo,
                'otp_id'=>$savedOTP->id,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'data' => false,
            'message' => 'email or mobile is already registered',
            'status' => 500
        ];
        return response()->json($response, 200);
    }

    public function verifyPhoneForFirebaseRegistrations(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'country_code'=>'required',
            'mobile'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = User::where('email',$request->email)->first();
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data2 = User::where($matchThese)->first();
        if (is_null($data) && is_null($data2)) {
            $response = [
                'data'=>true,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'data' => false,
            'message' => 'email or mobile is already registered',
            'status' => 500
        ];
        return response()->json($response, 200);
    }

    public function verifyPhoneSignup(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'country_code'=>'required',
            'mobile'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = User::where('email',$request->email)->first();
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data2 = User::where($matchThese)->first();
        if (is_null($data) && is_null($data2)) {
            $settings = Settings::take(1)->first();
            if($settings->sms_name =='0'){ // send with twillo
                $payCreds = DB::table('settings')
                ->select('*')->first();
                if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $credsData = json_decode($payCreds->sms_creds);
                if(is_null($credsData) || is_null($credsData->twilloCreds) || is_null($credsData->twilloCreds->sid)){
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }

                $id = $credsData->twilloCreds->sid;
                $token = $credsData->twilloCreds->token;
                $url = "https://api.twilio.com/2010-04-01/Accounts/$id/Messages.json";
                $from = $credsData->twilloCreds->from;
                $to = $request->country_code.$request->mobile; // twilio trial verified number
                try{
                    $otp = random_int(100000, 999999);
                    $client = new \GuzzleHttp\Client();
                    $response = $client->request('POST', $url, [
                        'headers' =>
                        [
                            'Accept' => 'application/json',
                            'Content-Type' => 'application/x-www-form-urlencoded',
                        ],
                        'form_params' => [
                        'Body' => 'Your Verification code is : '.$otp, //set message body
                        'To' => $to,
                        'From' => $from //we get this number from twilio
                        ],
                        'auth' => [$id, $token, 'basic']
                        ]
                    );
                    $savedOTP = Otp::create([
                        'otp'=>$otp,
                        'email'=>$to,
                        'status'=>0,
                    ]);
                    $response = [
                        'data'=>true,
                        'otp_id'=>$savedOTP->id,
                        'success' => true,
                        'status' => 200,
                    ];
                    return response()->json($response, 200);
                }catch (Exception $e){
                    echo "Error: " . $e->getMessage();
                }

            }else{ // send with msg91
                $payCreds = DB::table('settings')
                ->select('*')->first();
                if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $credsData = json_decode($payCreds->sms_creds);
                if(is_null($credsData) || is_null($credsData->msg) || is_null($credsData->msg->key)){
                    $response = [
                        'success' => false,
                        'message' => 'sms gateway issue please contact administrator',
                        'status' => 404
                    ];
                    return response()->json($response, 404);
                }
                $clientId = $credsData->msg->key;
                $smsSender = $credsData->msg->sender;
                $otp = random_int(100000, 999999);
                $client = new \GuzzleHttp\Client();
                $to = $request->country_code.$request->mobile;
                $res = $client->get('http://api.msg91.com/api/sendotp.php?authkey='.$clientId.'&message=Your Verification code is : '.$otp.'&mobile='.$to.'&sender='.$smsSender.'&otp='.$otp);
                $data = json_decode($res->getBody()->getContents());
                $savedOTP = Otp::create([
                    'otp'=>$otp,
                    'email'=>$to,
                    'status'=>0,
                ]);
                $response = [
                    'data'=>true,
                    'otp_id'=>$savedOTP->id,
                    'success' => true,
                    'status' => 200,
                ];
                return response()->json($response, 200);
            }
        }

        $response = [
            'data' => false,
            'message' => 'email or mobile is already registered',
            'status' => 500
        ];
        return response()->json($response, 200);
    }

    public function admins(){
        $data = User::where(['type'=>'admin'])->get();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function adminNewAdmin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'mobile'=>'required',
            'country_code'=>'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 500);
        }
        $emailValidation = User::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {

            $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
            $data = User::where($matchThese)->first();
            if (is_null($data) || !$data) {
                $user = User::create([
                    'email' => $request->email,
                    'first_name'=>$request->first_name,
                    'last_name'=>$request->last_name,
                    'type'=>'admin',
                    'status'=>1,
                    'mobile'=>$request->mobile,
                    'lat'=>0,
                    'lng'=>0,
                    'cover'=>'NA',
                    'country_code'=>$request->country_code,
                    'password' => Hash::make($request->password),
                ]);

                $token = JWTAuth::fromUser($user);
                return response()->json(['user'=>$user,'token'=>$token,'status'=>200], 200);
            }

            $response = [
                'success' => false,
                'message' => 'Mobile is already registered.',
                'status' => 500
            ];
            return response()->json($response, 500);
        }
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);
    }

    public function delete(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = User::find($request->id);
        if ($data) {
            $data->delete();
            DB::table('address')->where('uid',$request->id)->delete();
            DB::table('appointments')->where('uid',$request->id)->delete();
            DB::table('complaints')->where('uid',$request->id)->delete();
            DB::table('conversions')->where('sender_id',$request->id)->delete();
            DB::table('chat_rooms')->where('sender_id',$request->id)->delete();
            DB::table('chat_rooms')->where('receiver_id',$request->id)->delete();
            DB::table('complaints')->where('uid',$request->id)->delete();
            DB::table('favourite')->where('uid',$request->id)->delete();
            DB::table('freelancer_reviews')->where('uid',$request->id)->delete();
            DB::table('products_orders')->where('uid',$request->id)->delete();
            DB::table('product_reviews')->where('uid',$request->id)->delete();
            $response = [
                'data'=>$data,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Data not found.',
            'status' => 404
        ];
        return response()->json($response, 404);
    }

    public function sendToAllUsers(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'message' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }

            $data = DB::table('settings')
            ->select('*')->first();
            $ids = explode(',',$request->id);
            $allIds = DB::table('users')->select('fcm_token')->get();
            $fcm_ids = array();
            foreach($allIds as $i => $i_value) {
                if($i_value->fcm_token !='NA' && $i_value->fcm_token !=null){
                    array_push($fcm_ids,$i_value->fcm_token);
                }
            }

            if (is_null($data)) {
                $response = [
                    'data' => false,
                    'message' => 'Data not found.',
                    'status' => 404
                ];
                return response()->json($response, 200);
            }
            $regIdChunk=array_chunk($fcm_ids,1000);
            foreach($regIdChunk as $RegId){
                $header = array();
                $header[] = 'Content-type: application/json';
                $header[] = 'Authorization: key=' . $data->fcm_token;

                $payload = [
                    'registration_ids' => $RegId,
                    'priority'=>'high',
                    'notification' => [
                    'title' => $request->title,
                    'body' => $request->message,
                    'image'=>$request->cover,
                    "sound" => "wave.wav",
                    "channelId"=>"fcm_default_channel"
                    ],
                    'android'=>[
                        'notification'=>[
                            "sound" => "wave.wav",
                            "defaultSound"=>true,
                            "channelId"=>"fcm_default_channel"
                        ]
                    ]
                ];

                $crl = curl_init();
                curl_setopt($crl, CURLOPT_HTTPHEADER, $header);
                curl_setopt($crl, CURLOPT_POST,true);
                    curl_setopt($crl, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
                curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode( $payload ) );

                curl_setopt($crl, CURLOPT_RETURNTRANSFER, true );

                $rest = curl_exec($crl);
                if ($rest === false) {
                    return curl_error($crl);
                }
                curl_close($crl);
            }
            $response = [
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);


        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function sendToUsers(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'message' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }

            $data = DB::table('settings')
            ->select('*')->first();
            $ids = explode(',',$request->id);
            $allIds = DB::table('users')->where('type','user')->select('fcm_token')->get();
            $fcm_ids = array();
            foreach($allIds as $i => $i_value) {
                if($i_value->fcm_token !='NA' && $i_value->fcm_token !=null){
                    array_push($fcm_ids,$i_value->fcm_token);
                }
            }


            if (is_null($data)) {
                $response = [
                    'data' => false,
                    'message' => 'Data not found.',
                    'status' => 404
                ];
                return response()->json($response, 200);
            }
            $regIdChunk=array_chunk($fcm_ids,1000);
            foreach($regIdChunk as $RegId){
                $header = array();
                $header[] = 'Content-type: application/json';
                $header[] = 'Authorization: key=' . $data->fcm_token;

                $payload = [
                    'registration_ids' => $RegId,
                    'priority'=>'high',
                    'notification' => [
                    'title' => $request->title,
                    'body' => $request->message,
                    'image'=>$request->cover,
                    "sound" => "wave.wav",
                    "channelId"=>"fcm_default_channel"
                    ],
                    'android'=>[
                        'notification'=>[
                            "sound" => "wave.wav",
                            "defaultSound"=>true,
                            "channelId"=>"fcm_default_channel"
                        ]
                    ]
                ];

                $crl = curl_init();
                curl_setopt($crl, CURLOPT_HTTPHEADER, $header);
                curl_setopt($crl, CURLOPT_POST,true);
                    curl_setopt($crl, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
                curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode( $payload ) );

                curl_setopt($crl, CURLOPT_RETURNTRANSFER, true );

                $rest = curl_exec($crl);
                if ($rest === false) {
                    return curl_error($crl);
                }
                curl_close($crl);
           }
            $response = [
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);


        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function sendToStores(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'message' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }

            $data = DB::table('settings')
            ->select('*')->first();
            $ids = explode(',',$request->id);
            $allIds = DB::table('users')->where('type','freelancer')->select('fcm_token')->get();
            $fcm_ids = array();
            foreach($allIds as $i => $i_value) {
                if($i_value->fcm_token !='NA' && $i_value->fcm_token !=null){
                    array_push($fcm_ids,$i_value->fcm_token);
                }
            }


            if (is_null($data)) {
                $response = [
                    'data' => false,
                    'message' => 'Data not found.',
                    'status' => 404
                ];
                return response()->json($response, 200);
            }
            $regIdChunk=array_chunk($fcm_ids,1000);
            foreach($regIdChunk as $RegId){
                $header = array();
                $header[] = 'Content-type: application/json';
                $header[] = 'Authorization: key=' . $data->fcm_token;

                $payload = [
                    'registration_ids' => $RegId,
                    'priority'=>'high',
                    'notification' => [
                    'title' => $request->title,
                    'body' => $request->message,
                    'image'=>$request->cover,
                    "sound" => "wave.wav",
                    "channelId"=>"fcm_default_channel"
                    ],
                    'android'=>[
                        'notification'=>[
                            "sound" => "wave.wav",
                            "defaultSound"=>true,
                            "channelId"=>"fcm_default_channel"
                        ]
                    ]
                ];

                $crl = curl_init();
                curl_setopt($crl, CURLOPT_HTTPHEADER, $header);
                curl_setopt($crl, CURLOPT_POST,true);
                    curl_setopt($crl, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
                curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode( $payload ) );

                curl_setopt($crl, CURLOPT_RETURNTRANSFER, true );

                $rest = curl_exec($crl);
                if ($rest === false) {
                    return curl_error($crl);
                }
                curl_close($crl);
           }
            $response = [
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);


        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function sendMailToUsers(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'subjects' => 'required',
                'content' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $users = User::select('email','first_name','last_name')->where('type',1)->get();
            $general  = DB::table('settings')->select('name','email')->first();
            foreach($users as $user){
                Mail::send([], [], function ($message) use ($request,$user,$general) {
                    $message->to($user->email)
                      ->from($general->email, $general->name)
                      ->subject($request->subjects)
                      ->setBody($request->content, 'text/html');
                  });
            }

            $response = [
                'success' => true,
                'message' => 'success',
                'status' => 200
            ];
            return $response;

        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function sendMailToAll(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'subjects' => 'required',
                'content' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $users = User::select('email','first_name','last_name')->get();
            $general  = DB::table('settings')->select('name','email')->first();
            foreach($users as $user){
                Mail::send([], [], function ($message) use ($request,$user,$general) {
                    $message->to($user->email)
                      ->from($general->email, $general->name)
                      ->subject($request->subjects)
                      ->setBody($request->content, 'text/html');
                  });
            }

            $response = [
                'success' => true,
                'message' => 'success',
                'status' => 200
            ];
            return $response;

        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function sendMailToStores(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'subjects' => 'required',
                'content' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $users = User::select('email','first_name','last_name')->where('type','freelancer')->get();
            $general  = DB::table('settings')->select('name','email')->first();
            foreach($users as $user){
                Mail::send([], [], function ($message) use ($request,$user,$general) {
                    $message->to($user->email)
                      ->from($general->email, $general->name)
                      ->subject($request->subjects)
                      ->setBody($request->content, 'text/html');
                  });
            }

            $response = [
                'success' => true,
                'message' => 'success',
                'status' => 200
            ];
            return $response;

        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function loginWithPhonePassword(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
            'country_code'=>'required',
            'password'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];

        $user = User::where($matchThese)->first();

        if(!$user) return response()->json(['error' => 'User not found.'], 500);

        // Account Validation
        if (!(new BcryptHasher)->check($request->input('password'), $user->password)) {

            return response()->json(['error' => 'Phone Number or password is incorrect. Authentication failed.'], 401);
        }

        // Login Attempt
        $credentials = $request->only('country_code','mobile', 'password');

        try {

            JWTAuth::factory()->setTTL(40320); // Expired Time 28days

            if (! $token = JWTAuth::attempt($credentials, ['exp' => Carbon::now()->addDays(28)->timestamp])) {

                return response()->json(['error' => 'invalid_credentials'], 401);

            }
        } catch (JWTException $e) {

            return response()->json(['error' => 'could_not_create_token'], 500);

        }
        return response()->json(['user' => $user,'token'=>$token,'status'=>200], 200);
    }

    public function verifyPhoneForFirebase(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
            'country_code'=>'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];

        $user = User::where($matchThese)->first();

        if(!$user) return response()->json(['data'=>false,'error' => 'User not found.'], 500);
        $response = [
            'data'=>true,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function loginWithMobileOtp(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
            'country_code'=>'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];

        $user = User::where($matchThese)->first();

        if(!$user) return response()->json(['error' => 'User not found.'], 500);

        try {

            JWTAuth::factory()->setTTL(40320); // Expired Time 28days

            if (! $token = JWTAuth::fromUser($user, ['exp' => Carbon::now()->addDays(28)->timestamp])) {

                return response()->json(['error' => 'invalid_credentials'], 401);

            }
        } catch (JWTException $e) {

            return response()->json(['error' => 'could_not_create_token'], 500);

        }
        return response()->json(['user' => $user,'token'=>$token,'status'=>200], 200);
    }

    public function getMyWalletBalance(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = User::find($request->id);
        $data['balance'] = $data->balance;
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function sendNotification(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'message' => 'required',
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }

            $data = DB::table('settings')
            ->select('*')->first();
            if (is_null($data)) {
                $response = [
                    'data' => false,
                    'message' => 'Data not found.',
                    'status' => 404
                ];
                return response()->json($response, 200);
            }
            $header = array();
            $header[] = 'Content-type: application/json';
            $header[] = 'Authorization: key=' . $data->fcm_token;
            $userFCM = DB::table('users')->where('id',$request->id)->select('*')->first();
            $payload = [
                'to' => $userFCM->fcm_token,
                'priority'=>'high',
                'notification' => [
                  'title' => $request->title,
                  'body' => $request->message,
                  "sound" => "wave.wav",
                  "channelId"=>"fcm_default_channel"
                ],
                'android'=>[
                    'notification'=>[
                        "sound" => "wave.wav",
                        "defaultSound"=>true,
                        "channelId"=>"fcm_default_channel"
                    ]
                ]
              ];

            $crl = curl_init();
            curl_setopt($crl, CURLOPT_HTTPHEADER, $header);
            curl_setopt($crl, CURLOPT_POST,true);
                curl_setopt($crl, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
            curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode( $payload ) );

            curl_setopt($crl, CURLOPT_RETURNTRANSFER, true );

            $rest = curl_exec($crl);
            if ($rest === false) {
                return curl_error($crl);
            }
            curl_close($crl);
            return $rest;


        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function getAllUsers(Request $request){
        $data = User::where('type','user')->orderBy('id','desc')->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getInfo(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $user = DB::table('users')->select('first_name','last_name','cover','email','country_code','mobile')->where('id',$request->id)->first();
        $address = DB::table('address')->where('uid',$request->id)->get();
        $appointments = Appointments::where('uid',$request->id)->orderBy('id','desc')->get();
        foreach($appointments as $loop){
            if($loop && $loop->uid && $loop->uid !=null){
                $loop->userInfo = User::where('id',$loop->uid)->first();
            }

            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $loop->freelancerInfo = User::where('id',$loop->freelancer_id)->first();
            }
        }
        $productsOrders = ProductOrders::where('uid',$request->id)->orderBy('id','desc')->get();
        foreach($productsOrders as $loop){
            $freelancerInfo  = User::select('id','first_name','last_name','cover','mobile','email')->where('id',$loop->freelancer_id)->first();
            $loop->freelancerInfo =$freelancerInfo;
            $loop->userInfo =User::where('id',$loop->uid)->first();
        }
        $rating = DB::table('freelancer_reviews')->where('uid',$request->id)->get();
        foreach($rating as $loop){
            if($loop && $loop->freelancer_id && $loop->freelancer_id !=0){
                $loop->freelancerInfo = User::where('id',$loop->freelancer_id)->select('first_name','last_name','cover','email','country_code','mobile')->first();
            }
        }

        $ratingProducts = DB::table('product_reviews')->where('uid',$request->id)->get();
        foreach($ratingProducts as $loop){
            if($loop && $loop->product_id && $loop->product_id !=0){
                $loop->productInfo = Products::where('id',$loop->product_id)->first();
            }
        }
        $data = [
            'user'=>$user,
            'address'=>$address,
            'appointments'=>$appointments,
            'productsOrders'=>$productsOrders,
            'rating'=>$rating,
            'ratingProducts'=>$ratingProducts,
        ];
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
