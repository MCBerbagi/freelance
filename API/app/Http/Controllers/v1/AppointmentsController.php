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
use App\Models\Appointments;
use App\Models\Freelancer;
use App\Models\User;
use App\Models\Settings;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Validator;
use DB;
class AppointmentsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
            'freelancer_id' => 'required',
            'order_to' => 'required',
            'address' => 'required',
            'items' => 'required',
            'save_date' => 'required',
            'slot' => 'required',
            'coupon_id' => 'required',
            'coupon' => 'required',
            'discount' => 'required',
            'total' => 'required',
            'serviceTax' => 'required',
            'grand_total' => 'required',
            'pay_method' => 'required',
            'paid' => 'required',
            'wallet_used' => 'required',
            'wallet_price' => 'required',
            'notes' => 'required',
            'status' => 'required',
            'distance_cost'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Appointments::create($request->all());
        if (is_null($data)) {
            $response = [
            'data'=>$data,
            'message' => 'error',
            'status' => 500,
        ];
        return response()->json($response, 200);
        }

        if($request && $request->wallet_used == 1){
            $redeemer = User::where('id',$request->uid)->first();
            $redeemer->withdraw($request->wallet_price);
        }
        $this->sendMail($data->id);
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getById(Request $request){
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

        $data = Appointments::find($request->id);

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        if($data && $data->freelancer_id && $data->freelancer_id !=null){
            $freelancers = Freelancer::where('uid',$data->freelancer_id)->first();
            $data->freelancer = $freelancers;
            $userInfo = User::where('id',$data->freelancer_id)->first();
            $data->freelancer->email= $userInfo->email;
            $data->freelancer->mobile= $userInfo->mobile;
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByUID(Request $request){
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

        $data = Appointments::where('uid',$request->id)->orderBy('id','desc')->get();
        foreach($data as $loop){
            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $freelancers = Freelancer::where('uid',$loop->freelancer_id)->first();
                $userInfo = User::where('id',$loop->freelancer_id)->first();
                $loop->freelancer = $freelancers;
                $loop->freelancer['email']= $userInfo->email;
                $loop->freelancer['mobile']= $userInfo->mobile;
            }
        }
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

    public function getDetails(Request $request){
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

        $data = Appointments::where('id',$request->id)->first();
        if($data && $data->uid && $data->uid !=null){
            $data->userInfo = User::where('id',$data->uid)->first();
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getDetailAdmin(Request $request){
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

        $data = Appointments::where('id',$request->id)->first();
        $freelancers = Freelancer::where('uid',$data->freelancer_id)->first();
        $data->freelancer = $freelancers;
        $userInfo = User::where('id',$data->freelancer_id)->first();
        $data->freelancer->email= $userInfo->email;
        $data->freelancer->mobile= $userInfo->mobile;
        $data->userInfo = User::where('id',$data->uid)->first();

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByFreelancers(Request $request){
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

        $data = Appointments::where('freelancer_id',$request->id)->orderBy('id','desc')->get();
        foreach($data as $loop){
            if($loop && $loop->uid && $loop->uid !=null){
                $loop->userInfo = User::where('id',$loop->uid)->first();
            }
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function update(Request $request){
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
        $data = Appointments::find($request->id)->update($request->all());

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
        $data = Appointments::find($request->id);
        if ($data) {
            $data->delete();
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

    public function getAll(){
        $data = Appointments::orderBy('id','desc')->get();
        foreach($data as $loop){
            if($loop && $loop->uid && $loop->uid !=null){
                $loop->userInfo = User::where('id',$loop->uid)->first();
            }

            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $loop->freelancerInfo = User::where('id',$loop->freelancer_id)->first();
            }
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getStats(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'month'=>'required',
            'year'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $monthData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(save_date) as day_name"), \DB::raw("DATE(save_date) as day"),\DB::raw('SUM(total) AS total'))
            ->whereMonth('save_date', $request->month)
            ->whereYear('save_date', $request->year)
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->where('freelancer_id',$request->id)
            ->get();

        $monthResponse = [];
        foreach($monthData as $row) {
            $monthResponse['label'][] = date('l, d',strtotime($row->day_name));
            $monthResponse['data'][] = (int) $row->count;
            $monthResponse['total'][] = (int) $row->total;
        }
        if(isset($monthData) && count($monthData)>0){
            $response = [
                'data'=>$monthData,
                'chart' => $monthResponse,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }else{
            $response = [
                'data'=>[],
                'chart' => [],
                'success' => false,
                'status' => 200
            ];
            return response()->json($response, 200);
        }
    }

    public function getMonthsStats(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'year'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $monthData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("MONTH(save_date) as day_name"), \DB::raw("MONTH(save_date) as day"),\DB::raw('SUM(total) AS total'))
            ->whereYear('save_date', $request->year)
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->where('freelancer_id',$request->id)
            ->get();

        $monthResponse = [];
        foreach($monthData as $row) {
            $monthResponse['label'][] = date('F', mktime(0, 0, 0, $row->day_name, 10));
            $monthResponse['data'][] = (int) $row->count;
            $monthResponse['total'][] = (int) $row->total;
        }
        if(isset($monthData) && count($monthData)>0){
            $response = [
                'data'=>$monthData,
                'chart' => $monthResponse,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }else{
            $response = [
                'data'=>[],
                'chart' => [],
                'success' => false,
                'status' => 200
            ];
            return response()->json($response, 200);
        }
    }

    public function getAllStats(Request $request){
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

        $monthData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("YEAR(save_date) as day_name"), \DB::raw("YEAR(save_date) as day"),\DB::raw('SUM(total) AS total'))
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->where('freelancer_id',$request->id)
            ->get();

        $monthResponse = [];
        foreach($monthData as $row) {
            $monthResponse['label'][] = date('Y', strtotime($row->day_name));
            $monthResponse['data'][] = (int) $row->count;
            $monthResponse['total'][] = (int) $row->total;
        }
        if(isset($monthData) && count($monthData)>0){
            $response = [
                'data'=>$monthData,
                'chart' => $monthResponse,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }else{
            $response = [
                'data'=>[],
                'chart' => [],
                'success' => false,
                'status' => 200
            ];
            return response()->json($response, 200);
        }
    }

    public function getAppointmentsStats(Request $request){
        $validator = Validator::make($request->all(), [
            'id'     => 'required',
            'from'     => 'required',
            'to'     => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $from = date($request->from);
        $to = date($request->to);
        $data = Appointments::whereRaw('FIND_IN_SET("'.$request->id.'",freelancer_id)')->whereBetween('save_date',[$from, $to])->where('status',4)->orderBy('id','desc')->get();
        $commission = DB::table('commission')->select('rate')->where('freelancer_id',$request->id)->first();
        $response = [
            'data'=>$data,
            'commission'=>$commission,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function printInvoice(Request $request){

        $validator = Validator::make($request->all(), [
            'id'     => 'required',
            'token'     => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        try {
            $data = DB::table('appointments')
            ->select('appointments.*','users.first_name as user_first_name','users.last_name as user_last_name','users.cover as user_cover','users.fcm_token as user_fcm_token','users.mobile as user_mobile','users.email as user_email')
            ->join('users', 'appointments.uid', '=', 'users.id')
            ->where('appointments.id',$request->id)
            ->first();
            $general = Settings::first();
            $addres ='';
            $compressed = json_decode($data->address);
            $addres = $compressed->house .' '.$compressed->landmark .' '.$compressed->address .' '.$compressed->pincode;

            $data->items = json_decode($data->items);
            $general->social = json_decode($general->social);
            $response = [
                'data'=>$data,
                'email'=>$general->email,
                'general'=>$general,
                'delivery'=>$addres
            ];

            return view('printinvoice',$response);
        } catch (TokenExpiredException $e) {

            return response()->json(['error' => 'Session Expired.', 'status_code' => 401], 401);

        } catch (TokenInvalidException $e) {

            return response()->json(['error' => 'Token invalid.', 'status_code' => 401], 401);

        } catch (JWTException $e) {

            return response()->json(['token_absent' => $e->getMessage()], 401);

        }
    }

    public function sendMail($id){
        $data = DB::table('appointments')
            ->select('appointments.*','users.first_name as user_first_name','users.last_name as user_last_name','users.cover as user_cover','users.fcm_token as user_fcm_token','users.mobile as user_mobile','users.email as user_email')
            ->join('users', 'appointments.uid', '=', 'users.id')
            ->where('appointments.id',$id)
            ->first();
            $general = Settings::first();
            $addres ='';
            $compressed = json_decode($data->address);
            $addres = $compressed->house .' '.$compressed->landmark .' '.$compressed->address .' '.$compressed->pincode;

            $data->items = json_decode($data->items);
            $general->social = json_decode($general->social);
            $response = [
                'data'=>$data,
                'email'=>$general->email,
                'general'=>$general,
                'delivery'=>$addres
            ];
            $mail = $data->user_email;
            $username = $data->user_first_name;
            $subject = 'Appointments Invoice';
            $mailTo = Mail::send('printinvoice',
            [
                'data'=>$data,
                'email'=>$general->email,
                'general'=>$general,
                'delivery'=>$addres
            ]
            , function($message) use($mail,$username,$subject,$general){
                $message->to($mail, $username)
                ->subject($subject);
                $message->from($general->email,$general->name);
            });
            // echo json_encode($data->items);
            // return view('printinvoice',$response);
        $response = [
            'data'=>true,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function orderInvoice(Request $request){
        $validator = Validator::make($request->all(), [
            'id'     => 'required',
            'token'     => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        try {
            $data = DB::table('appointments')
            ->select('appointments.*','users.first_name as user_first_name','freelancer.first_name as freelancer_fname','freelancer.last_name as freelancer_lname',
            'freelancer.email as freelancer_email','freelancer.mobile as freelancer_mobile','users.last_name as user_last_name','users.cover as user_cover','users.fcm_token as user_fcm_token','users.mobile as user_mobile','users.email as user_email')
            ->join('users', 'appointments.uid', '=', 'users.id')
            ->join('users as freelancer', 'appointments.freelancer_id', '=', 'freelancer.id')
            ->where('appointments.id',$request->id)
            ->first();
            $general = Settings::first();
            $addres ='';
            $addres = json_decode($data->address);
            // $addres = $compressed->house .' '.$compressed->landmark .' '.$compressed->address .' '.$compressed->pincode;

            $data->items = json_decode($data->items);
            $general->social = json_decode($general->social);
            $paymentName  = [
                'NA',
                'COD',
                'Stripe',
                'PayPal',
                'Paytm',
                'Razorpay',
                'Instamojo',
                'Paystack',
                'Flutterwave'
            ];
            $data->pay_method = $paymentName[$data->pay_method];
            $response = [
                'data'=>$data,
                'email'=>$general->email,
                'general'=>$general,
                'delivery'=>$addres
            ];
            // echo json_encode($data);
            return view('appointment-invoice',$response);
        } catch (TokenExpiredException $e) {

            return response()->json(['error' => 'Session Expired.', 'status_code' => 401], 401);

        } catch (TokenInvalidException $e) {

            return response()->json(['error' => 'Token invalid.', 'status_code' => 401], 401);

        } catch (JWTException $e) {

            return response()->json(['token_absent' => $e->getMessage()], 401);

        }
    }
}
