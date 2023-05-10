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
use App\Models\FreelancerRequest;
use App\Models\Cities;
use App\Models\Category;
use Validator;
use DB;
class FreelancerRequestController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'mobile'=>'required',
            'country_code'=>'required',
            'password' => 'required',
            'served_category' => 'required',
            'lat' => 'required',
            'lng' => 'required',
            'hourly_price' => 'required',
            'descriptions' => 'required',
            'total_experience' => 'required',
            'cid' => 'required',
            'zipcode' => 'required',
            'extra_field' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $emailValidation = FreelancerRequest::where('email',$request->email)->first();
        if (is_null($emailValidation) || !$emailValidation) {

            $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
            $data = FreelancerRequest::where($matchThese)->first();
            if (is_null($data) || !$data) {

                $data = FreelancerRequest::create($request->all());
                if (is_null($data)) {
                    $response = [
                    'data'=>$data,
                    'message' => 'error',
                    'status' => 500,
                ];
                return response()->json($response, 200);
                }
                $response = [
                    'data'=>$data,
                    'success' => true,
                    'status' => 200,
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
        $response = [
            'success' => false,
            'message' => 'Email is already taken',
            'status' => 500
        ];
        return response()->json($response, 500);

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

        $data = FreelancerRequest::find($request->id);

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
        $data = FreelancerRequest::find($request->id)->update($request->all());

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
        $data = FreelancerRequest::find($request->id);
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
        $data = FreelancerRequest::all();
        foreach($data as $loop){
            if($loop && $loop->served_category && $loop->served_category !=null){
                $ids = explode(',',$loop->served_category);
                $cats = Category::WhereIn('id',$ids)->get();
                $loop->web_cates_data = $cats;
            }
            if($loop && $loop->cid && $loop->cid !=null){
                $loop->city_data = Cities::find($loop->cid);
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

    public function getActiveItem(Request $request){
        $data = FreelancerRequest::where('status',1)->get();

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function importData(Request $request){
        $request->validate([
            "csv_file" => "required",
        ]);
        $file = $request->file("csv_file");
        $csvData = file_get_contents($file);
        $rows = array_map("str_getcsv", explode("\n", $csvData));
        $header = array_shift($rows);
        foreach ($rows as $row) {
            if (isset($row[0])) {
                if ($row[0] != "") {

                    if(count($header) == count($row)){
                        $row = array_combine($header, $row);
                        $insertInfo =  array(
                            'id' => $row['id'],
                            'name' => $row['name'],
                            'cover' => $row['cover'],
                            'status' => $row['status'],
                        );
                        $checkLead  =  FreelancerRequest::where("id", "=", $row["id"])->first();
                        if (!is_null($checkLead)) {
                            DB::table('category')->where("id", "=", $row["id"])->update($insertInfo);
                        }
                        else {
                            DB::table('category')->insert($insertInfo);
                        }
                    }
                }
            }
        }
        $response = [
            'data'=>'Done',
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
