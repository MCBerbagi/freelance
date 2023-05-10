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
use App\Models\Freelancer;
use App\Models\Category;
use App\Models\Banners;
use App\Models\Cities;
use App\Models\Settings;
use App\Models\Products;
use App\Models\Commission;
use App\Models\ProductOrders;
use App\Models\Appointments;
use App\Models\User;
use App\Models\Complaints;
use App\Models\FreelacerService;
use App\Models\Favourites;
use Validator;
use Carbon\Carbon;
use DB;

class FreelancerController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
            'name' => 'required',
            'cover' => 'required',
            'served_category' => 'required',
            'lat' => 'required',
            'lng' => 'required',
            'hourly_price' => 'required',
            'gallery' => 'required',
            'descriptions' => 'required',
            'total_experience' => 'required',
            'cid' => 'required',
            'zipcode' => 'required',
            'rating' => 'required',
            'total_rating' => 'required',
            'verified' => 'required',
            'available' => 'required',
            'have_shop' => 'required',
            'popular' => 'required',
            'in_home' => 'required',
            'extra_field' => 'required',
            'status' => 'required',
            'rate' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Freelancer::create($request->all());

        if (is_null($data)) {
            $response = [
                'data'=>$data,
                'message' => 'error',
                'status' => 500,
            ];
            return response()->json($response, 200);
        }
        Commission::create([
            'freelancer_id'=>$request->uid,
            'rate'=>$request->rate,
            'status'=>1,
        ]);
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

        $data = Freelancer::where('uid',$request->id)->first();
        if($data && $data->served_category && $data->served_category !=null){
            $ids = explode(',',$data->served_category);
            $cats = Category::WhereIn('id',$ids)->get();
            $data->web_cates_data = $cats;
        }
        if($data && $data->cid && $data->cid !=null){
            $data->city_data = Cities::find($data->cid);
        }
        $data->rate = Commission::where('freelancer_id',$request->id)->first();
        $data->user_info = User::find($request->id);
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
        $data = Freelancer::find($request->id)->update($request->all());

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

    public function updateInfo(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'uid' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Freelancer::find($request->id)->update($request->all());
        $data = User::find($request->uid)->update(['first_name'=>$request->first_name,'last_name'=>$request->last_name,'cover'=>$request->cover]);
        Commission::where('freelancer_id',$request->uid)->update(['rate'=>$request->rate]);
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

    public function updateMyInfo(Request $request){
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
        $data = Freelancer::find($request->id)->update($request->all());
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
        $data = Freelancer::find($request->id);
        $data2 = User::find($request->uid);

        if ($data && $data2) {
            $data->delete();
            $data2->delete();
            DB::table('address')->where('uid',$request->uid)->delete();
            DB::table('appointments')->where('freelancer_id',$request->uid)->delete();
            DB::table('complaints')->where('freelancer_id',$request->uid)->delete();
            DB::table('conversions')->where('sender_id',$request->uid)->delete();
            DB::table('chat_rooms')->where('sender_id',$request->uid)->delete();
            DB::table('chat_rooms')->where('receiver_id',$request->uid)->delete();
            DB::table('complaints')->where('freelancer_id',$request->uid)->delete();
            DB::table('favourite')->where('freelancer_uid',$request->uid)->delete();
            DB::table('freelancer_reviews')->where('freelancer_id',$request->uid)->delete();
            DB::table('products_orders')->where('freelancer_id',$request->uid)->delete();

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
        $data = Freelancer::all();
        foreach($data as $loop){
            if($loop && $loop->served_category && $loop->served_category !=null){
                $ids = explode(',',$loop->served_category);
                $cats = Category::WhereIn('id',$ids)->get();
                $loop->web_cates_data = $cats;
            }
            if($loop && $loop->cid && $loop->cid !=null){
                $loop->city_data = Cities::find($loop->cid);
            }
            $loop->rate = Commission::where('freelancer_id',$loop->uid)->first();
            $loop->user_info = User::find($loop->uid);
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

    public function topFreelancers(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
            'uid' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $searchQuery = Settings::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        $ids = explode(',',$request->uid);
        \DB::enableQueryLog();
        $data = Freelancer::select(DB::raw('freelacer.id as id,freelacer.uid as uid,freelacer.name as name,freelacer.cover as cover,
        freelacer.hourly_price,freelacer.total_experience as total_experience,freelacer.cid as cid,freelacer.zipcode as zipcode,
        freelacer.status as status,freelacer.rating as rating,freelacer.total_rating as total_rating,freelacer.served_category as served_category, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->WhereIn('freelacer.uid',$ids)
        ->where(['freelacer.status'=>1,'freelacer.available'=>1])
        ->get();

        foreach($data as $loop){
            $loop->distance = round($loop->distance,2);
        }
        $response = [
            'data'=>$data,
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>true,
        ];
        return response()->json($response, 200);
    }

    public function getActiveItem(Request $request){
        $data = Freelancer::where('status',1)->get();

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function importData(Request $request){
        // $request->validate([
        //     "csv_file" => "required",
        // ]);
        // $file = $request->file("csv_file");
        // $csvData = file_get_contents($file);
        // $rows = array_map("str_getcsv", explode("\n", $csvData));
        // $header = array_shift($rows);
        // foreach ($rows as $row) {
        //     if (isset($row[0])) {
        //         if ($row[0] != "") {

        //             if(count($header) == count($row)){
        //                 $row = array_combine($header, $row);
        //                 $insertInfo =  array(
        //                     'id' => $row['id'],
        //                     'name' => $row['name'],
        //                     'cover' => $row['cover'],
        //                     'status' => $row['status'],
        //                 );
        //                 $checkLead  =  Freelancer::where("id", "=", $row["id"])->first();
        //                 if (!is_null($checkLead)) {
        //                     DB::table('category')->where("id", "=", $row["id"])->update($insertInfo);
        //                 }
        //                 else {
        //                     DB::table('category')->insert($insertInfo);
        //                 }
        //             }
        //         }
        //     }
        // }
        // $response = [
        //     'data'=>'Done',
        //     'success' => true,
        //     'status' => 200,
        // ];
        // return response()->json($response, 200);
    }

    public function getMyFavList(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
            'uid' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $searchQuery = Settings::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        $storeIds = Favourites::select('freelancer_uid')->where('uid',$request->uid)->get();
        $ids = array();
        foreach($storeIds as $i => $i_value) {
            array_push($ids,$i_value->freelancer_uid);
        }
        \DB::enableQueryLog();
        $data = Freelancer::select(DB::raw('freelacer.id as id,freelacer.uid as uid,freelacer.name as name,freelacer.cover as cover,
        freelacer.hourly_price,freelacer.total_experience as total_experience,freelacer.cid as cid,freelacer.zipcode as zipcode,
        freelacer.status as status,freelacer.rating as rating,freelacer.total_rating as total_rating,freelacer.served_category as served_category, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->WhereIn('freelacer.uid',$ids)
        ->where(['freelacer.status'=>1,'freelacer.available'=>1])
        ->get();

        foreach($data as $loop){
            $loop->distance = round($loop->distance,2);
        }
        $response = [
            'data'=>$data,
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>true,
        ];
        return response()->json($response, 200);

    }

    public function getHomeData(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $searchQuery = Settings::select('allowDistance','searchResultKind')->first();
        $categories = Category::where(['status'=>1])->get();
        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }

        \DB::enableQueryLog();
        $data = Freelancer::select(DB::raw('freelacer.id as id,freelacer.uid as uid,freelacer.name as name,freelacer.cover as cover,
        freelacer.hourly_price,freelacer.total_experience as total_experience,freelacer.cid as cid,freelacer.zipcode as zipcode,
        freelacer.status as status,freelacer.rating as rating,freelacer.total_rating as total_rating,freelacer.served_category as served_category, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where(['freelacer.status'=>1,'freelacer.available'=>1])
        ->get();

        if($data && sizeof($data) && count($data) >0){
            $today = date('Y-m-d');
            $banners = Banners::where(['city_id'=>$data[0]->cid,'status'=>1])
            ->whereDate('from','<=', $today)
            ->whereDate('to','>=', $today)
            ->get();
            foreach($data as $loop){
                if($loop && $loop->served_category && $loop->served_category !=null){
                    $ids = explode(',',$loop->served_category);
                    $cats = Category::WhereIn('id',$ids)->get();
                    $loop->web_cates_data = $cats;
                }
            }
            $today = Carbon::now();
            $freelancerIds = $data->pluck('uid')->toArray();
            $products = Products::where('in_home',1)->WhereIn('freelacer_id',$freelancerIds)->limit(10)->get();

            $response = [
                'categories'=>$categories,
                'data'=>$data,
                'banners'=>$banners,
                'distanceType'=>$distanceType,
                'products'=>$products,
                'success' => true,
                'status' => 200,
                'havedata'=>true,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'categories'=>[],
            'data'=>[],
            'banners'=>[],
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>false
        ];
        return response()->json($response, 200);
    }

    public function searchQuery(Request $request){
        $str = "";
        if ($request->has('param') && $request->has('lat') && $request->has('lng')) {
            $str = $request->param;
            $lat = $request->lat;
            $lng = $request->lng;
        }
        $searchQuery = Settings::select('allowDistance','searchResultKind')->first();
        $categories = Category::where(['status'=>1])->get();
        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }

        \DB::enableQueryLog();
        $data = Freelancer::select(DB::raw('freelacer.id as id,freelacer.uid as uid,freelacer.name as name,freelacer.cover as cover,
        freelacer.status as status, ( '.$values.' * acos( cos( radians('.$lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$lng.') ) + sin( radians('.$lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('freelacer.name', 'like', '%'.$str.'%')
        ->where(['freelacer.status'=>1,'freelacer.available'=>1])
        ->get();

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
        # code...
    }

    public function getFreelancerFromCategory(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'lat' => 'required',
            'lng' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $searchQuery = Settings::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }

        \DB::enableQueryLog();
        $data = Freelancer::select(DB::raw('freelacer.id as id,freelacer.uid as uid,freelacer.name as name,freelacer.cover as cover,
        freelacer.hourly_price,freelacer.total_experience as total_experience,freelacer.cid as cid,freelacer.zipcode as zipcode,
        freelacer.status as status,freelacer.rating as rating,freelacer.total_rating as total_rating,freelacer.served_category as served_category, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where(['freelacer.status'=>1,'freelacer.available'=>1])
        ->whereRaw("find_in_set('".$request->id."',freelacer.served_category)")
        ->get();

        if($data && sizeof($data) && count($data) >0){
            $today = date('Y-m-d');
            $banners = Banners::where(['city_id'=>$data[0]->city_id,'status'=>1])
            ->whereDate('from','<=', $today)
            ->whereDate('to','>=', $today)
            ->get();
            foreach($data as $loop){
                if($loop && $loop->served_category && $loop->served_category !=null){
                    $ids = explode(',',$loop->served_category);
                    $cats = Category::WhereIn('id',$ids)->get();
                    $loop->web_cates_data = $cats;
                }
            }
            $response = [
                'data'=>$data,
                'banners'=>$banners,
                'distanceType'=>$distanceType,
                'success' => true,
                'status' => 200,
                'havedata'=>true,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'categories'=>[],
            'data'=>[],
            'banners'=>[],
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>false
        ];
        return response()->json($response, 200);
    }

    public function getMyCategories(Request $request){
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

        $data = Freelancer::select('served_category')->where('uid',$request->id)->first();
        if($data && $data->served_category && $data->served_category !=null){
            $ids = explode(',',$data->served_category);
            $cats = Category::WhereIn('id',$ids)->get();
            $data->web_cates_data = $cats;
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getAdminHome(Request $request){

        $productsOrders = ProductOrders::limit(10)->orderBy('id','desc')->get();
        foreach($productsOrders as $loop){
            $freelancerInfo  = User::select('id','first_name','last_name','cover','mobile','email')->where('id',$loop->freelancer_id)->first();
            $loop->freelancerInfo =$freelancerInfo;
            $loop->userInfo =User::where('id',$loop->uid)->first();
        }
        $recentUser = User::where('type','user')->limit(10)->orderBy('id','desc')->get();
        $complaints = Complaints::whereMonth('created_at', Carbon::now()->month)->get();
        foreach($complaints as $loop){
            $user = User::select('email','first_name','last_name','cover')->where('id',$loop->uid)->first();
            $loop->userInfo = $user;
            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $store = Freelancer::select('name','cover')->where('uid',$loop->freelancer_id)->first();
                $storeUser = User::select('email','cover')->where('id',$loop->freelancer_id)->first();
                $loop->storeInfo = $store;
                $loop->storeUiserInfo = $storeUser;
            }

            if($loop && $loop->driver_id && $loop->driver_id !=null){
                $driver = User::select('email','first_name','last_name','cover')->where('id',$loop->driver_id)->first();
                $loop->driverInfo = $driver;
            }

            if($loop && $loop->product_id && $loop->product_id !=null){
                $product = Products::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }

            if($loop && $loop->complaints_on == 0 && $loop->product_id && $loop->product_id !=null){
                $product = FreelacerService::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }
        }

        $appointments = Appointments::limit(10)->orderBy('id','desc')->get();
        foreach($appointments as $loop){
            if($loop && $loop->uid && $loop->uid !=null){
                $loop->userInfo = User::where('id',$loop->uid)->first();
            }

            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $loop->freelancerInfo = User::where('id',$loop->freelancer_id)->first();
            }
        }

        $now = Carbon::now();
        $todatData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE_FORMAT(save_date,'%h:%m') as day_name"), \DB::raw("DATE_FORMAT(save_date,'%h:%m') as day"))
        ->whereDate('save_date',Carbon::today())
        ->groupBy('day_name','day')
        ->orderBy('day')
        ->get();
        $weekData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(save_date) as day_name"), \DB::raw("DATE(save_date) as day"))
            ->whereBetween('save_date', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()])
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();
        $monthData = Appointments::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(save_date) as day_name"), \DB::raw("DATE(save_date) as day"))
            ->whereMonth('save_date', Carbon::now()->month)
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();
        $monthResponse = [];
        $weekResponse =[];
        $todayResponse = [];
        foreach($todatData as $row) {
            $todayResponse['label'][] = $row->day_name;
            $todayResponse['data'][] = (int) $row->count;
        }
        foreach($weekData as $row) {
            $weekResponse['label'][] = $row->day_name;
            $weekResponse['data'][] = (int) $row->count;
        }
        foreach($monthData as $row) {
            $monthResponse['label'][] = $row->day_name;
            $monthResponse['data'][] = (int) $row->count;
        }
        $todayDate  = $now->format('d F');
        $weekStartDate = $now->startOfWeek()->format('d');
        $weekEndDate = $now->endOfWeek()->format('d F');
        $monthStartDate = $now->startOfMonth()->format('d');
        $monthEndDate = $now->endOfMonth()->format('d F');

        /////////////////////////////////////////////////// product orders ////////////////////////////////////////////////////////////////////

        $todatDataProducts = ProductOrders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE_FORMAT(date_time,'%h:%m') as day_name"), \DB::raw("DATE_FORMAT(date_time,'%h:%m') as day"))
        ->whereDate('date_time',Carbon::today())
        ->groupBy('day_name','day')
        ->orderBy('day')
        ->get();
        $weekDataProducts = ProductOrders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(date_time) as day_name"), \DB::raw("DATE(date_time) as day"))
            ->whereBetween('date_time', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()])
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();
        $monthDataProducts = ProductOrders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(date_time) as day_name"), \DB::raw("DATE(date_time) as day"))
            ->whereMonth('date_time', Carbon::now()->month)
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();
        $monthResponseProducts = [];
        $weekResponseProducts =[];
        $todayResponseProducts = [];
        foreach($todatDataProducts as $row) {
            $todayResponseProducts['label'][] = $row->day_name;
            $todayResponseProducts['data'][] = (int) $row->count;
        }
        foreach($weekDataProducts as $row) {
            $weekResponseProducts['label'][] = $row->day_name;
            $weekResponseProducts['data'][] = (int) $row->count;
        }
        foreach($monthDataProducts as $row) {
            $monthResponseProducts['label'][] = $row->day_name;
            $monthResponseProducts['data'][] = (int) $row->count;
        }
        $todayDateProducts  = $now->format('d F');
        $weekStartDateProducts = $now->startOfWeek()->format('d');
        $weekEndDateProducts = $now->endOfWeek()->format('d F');
        $monthStartDateProducts = $now->startOfMonth()->format('d');
        $monthEndDateProducts = $now->endOfMonth()->format('d F');
        /////////////////////////////////////////////////// product orders ////////////////////////////////////////////////////////////////////

        $response = [
            'today' => $todayResponse,
            'week' => $weekResponse,
            'month' => $monthResponse,
            'todayLabel' => $todayDate,
            'weekLabel' => $weekStartDate . '-'. $weekEndDate,
            'monthLabel' => $monthStartDate.'-'.$monthEndDate,

            'todayProducts' => $todayResponseProducts,
            'weekProducts' => $weekResponseProducts,
            'monthProducts' => $monthResponseProducts,
            'todayLabelProducts' => $todayDateProducts,
            'weekLabelProducts' => $weekStartDateProducts . '-'. $weekEndDateProducts,
            'monthLabelProducts' => $monthStartDateProducts.'-'.$monthEndDateProducts,

            'productsOrders'=>$productsOrders,
            'appointments'=>$appointments,
            'total_freelancers'=>Freelancer::count(),
            'total_users'=>User::where('type','user')->count(),
            'user'=>$recentUser,
            'total_orders'=>ProductOrders::count(),
            'total_products'=>Products::count(),
            'total_appointments'=>Appointments::count(),
            'complaints'=>$complaints,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
