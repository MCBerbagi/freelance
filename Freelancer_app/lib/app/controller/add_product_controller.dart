/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/product_model.dart';
import 'package:handyman_freelancer/app/backend/parse/add_product_parse.dart';
import 'package:handyman_freelancer/app/controller/product_category_controller.dart';
import 'package:handyman_freelancer/app/controller/product_controller.dart';
import 'package:handyman_freelancer/app/controller/product_subcategory_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/util/toast.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController implements GetxService {
  final AddProductParser parser;

  XFile? _selectedImage;

  ProductModel _productDetail = ProductModel();
  ProductModel get productDetail => _productDetail;

  CateData _cateInfo = CateData();
  CateData get cateInfo => _cateInfo;

  SubCateData _subCateInfo = SubCateData();
  SubCateData get subCateInfo => _subCateInfo;

  String selectedProductCateName = '';
  String selectedProductCateId = '';
  String selectedSubCateName = '';
  String selectedSubCateId = '';

  final nameTextEditor = TextEditingController();
  final originalPriceTextEditor = TextEditingController();
  final discountTextEditor = TextEditingController();
  final sellPriceTextEditor = TextEditingController();
  final descriptionsTextEditor = TextEditingController();

  String expireDate = '';
  final keyFeaturesTextEditor = TextEditingController();
  final disclaimerTextEditor = TextEditingController();

  final gramTextEditor = TextEditingController();
  final kgTextEditor = TextEditingController();
  final literTextEditor = TextEditingController();
  final pcsTextEditor = TextEditingController();
  final mlTextEditor = TextEditingController();

  int isSingleValue = 0;
  bool isSingle = false;

  int inOfferValue = 0;
  bool inOffer = false;

  bool inGram = false;

  bool inKG = false;

  bool inLiter = false;

  bool inPCs = false;

  bool inML = false;

  int selectedStatus = 1;
  int selectedStock = 1;

  int inhome = 0;

  bool showInHome = false;

  bool apiCalled = false;

  String cover = '';

  List<String> images = ['', '', '', '', '', ''];

  int productId = 0;
  String action = 'new';

  AddProductController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] == 'edit') {
      action = 'edit';
      productId = Get.arguments[1] as int;
      debugPrint('service id======= $productId');
      getProductByID();
    } else {
      apiCalled = true;
    }
  }

  void showInHomePage(bool status) {
    showInHome = status;
    inhome = showInHome == true ? 1 : 0;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void updateStatus(int status) {
    selectedStatus = status;
    update();
  }

  void updateStock(int status) {
    selectedStock = status;
    update();
  }

  void isSinglToggle(bool status) {
    isSingle = status;
    isSingleValue = isSingle == true ? 1 : 0;
    update();
  }

  void inOfferToggle(bool status) {
    inOffer = status;
    inOfferValue = inOffer == true ? 1 : 0;
    update();
  }

  void inGramToggle(bool status) {
    inGram = status;
    update();
  }

  void inKGToggle(bool status) {
    inKG = status;
    update();
  }

  void inLiterToggle(bool status) {
    inLiter = status;
    update();
  }

  void inPCsToggle(bool status) {
    inPCs = status;
    update();
  }

  void inMLToggle(bool status) {
    inML = status;
    update();
  }

  void onSaveProductCategory(String id, String name) {
    selectedProductCateName = name;
    selectedProductCateId = id;

    selectedSubCateName = '';
    selectedSubCateId = '';
    debugPrint('got from product list');
    update();
  }

  void onSaveProductSubCategory(String id, String name) {
    selectedSubCateName = name;
    selectedSubCateId = id;
    debugPrint('got from sub list');
    update();
  }

  void onProductCateList() {
    debugPrint('done product list');
    Get.delete<ProductCategoryController>(force: true);
    Get.toNamed(AppRouter.getProductCategoryRoute(),
        arguments: [selectedProductCateId]);
  }

  void onProductSubCateList() {
    if (selectedProductCateId.isEmpty) {
      showToast('Please select category first'.tr);
      return;
    }
    Get.delete<ProductSubCategoryController>(force: true);
    Get.toNamed(AppRouter.getProductSubCategoryRoute(),
        arguments: [selectedProductCateId, selectedSubCateId]);
  }

  Future<void> onSubmitProduct() async {
    debugPrint('hi there');
    if (nameTextEditor.text == '' ||
        nameTextEditor.text.isEmpty ||
        selectedProductCateId == '' ||
        selectedProductCateId.isEmpty ||
        selectedSubCateId == '' ||
        selectedSubCateId.isEmpty ||
        originalPriceTextEditor.text == '' ||
        originalPriceTextEditor.text.isEmpty ||
        descriptionsTextEditor.text == '' ||
        descriptionsTextEditor.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }

    var body = {
      "freelacer_id": parser.getUID(),
      "cover": cover,
      "name": nameTextEditor.text,
      "images": jsonEncode(images),
      "original_price": originalPriceTextEditor.text,
      "sell_price":
          sellPriceTextEditor.text.isNotEmpty ? sellPriceTextEditor.text : 0,
      "discount":
          discountTextEditor.text.isNotEmpty ? discountTextEditor.text : 0,
      "cate_id": selectedProductCateId,
      "sub_cate_id": selectedSubCateId,
      "extra_field": 'NA',
      "status": selectedStatus,
      "in_stock": selectedStock,
      "descriptions": descriptionsTextEditor.text,
      "key_features": keyFeaturesTextEditor.text,
      "disclaimer": disclaimerTextEditor.text,
      "in_offer": inOffer == true ? 1 : 0,
      "in_home": inhome,
      "is_single": isSingle == true ? 1 : 0,
      "have_gram": inGram == true ? 1 : 0,
      "gram": inGram == true ? gramTextEditor.text : 0,
      "have_kg": inKG == true ? 1 : 0,
      "kg": inKG == true ? kgTextEditor.text : 0,
      "have_pcs": inPCs == true ? 1 : 0,
      "pcs": inPCs == true ? pcsTextEditor.text : 0,
      "have_liter": inLiter == true ? 1 : 0,
      "liter": inLiter == true ? literTextEditor.text : 0,
      "have_ml": inML == true ? 1 : 0,
      "ml": inML == true ? mlTextEditor.text : 0,
      "rating": 0,
      "total_rating": 0
    };
    debugPrint(body.toString());
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var response = await parser.onSubmitProduct(body);
    debugPrint(response.bodyString);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Addded'.tr);
      Get.find<ProductController>().getMyProducts();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getProductByID() async {
    var response = await parser.getProductByID({"id": productId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      _productDetail = ProductModel();
      _cateInfo = CateData();
      _subCateInfo = SubCateData();

      var body = myMap['data'];
      var cates = myMap['cate'];
      var subCates = myMap['sub_cate'];

      ProductModel data = ProductModel.fromJson(body);
      CateData cateInfo = CateData.fromJson(cates);
      SubCateData subCateInfo = SubCateData.fromJson(subCates);

      _cateInfo = cateInfo;
      _subCateInfo = subCateInfo;
      _productDetail = data;

      debugPrint('====>  ${data.freelacerId}');

      debugPrint(body.toString());

      nameTextEditor.text = _productDetail.name.toString();
      originalPriceTextEditor.text = _productDetail.originalPrice.toString();
      sellPriceTextEditor.text = _productDetail.sellPrice.toString();
      discountTextEditor.text = _productDetail.discount.toString();
      descriptionsTextEditor.text = _productDetail.descriptions.toString();
      keyFeaturesTextEditor.text = _productDetail.keyFeatures.toString();
      disclaimerTextEditor.text = _productDetail.disclaimer.toString();

      selectedProductCateId = _productDetail.cateId.toString();
      selectedSubCateId = _productDetail.subCateId.toString();

      selectedProductCateName = _cateInfo.name.toString();
      selectedSubCateName = _subCateInfo.name.toString();

      isSingleValue = _productDetail.isSingle!;
      isSingle = isSingleValue == 1 ? true : false;

      inOfferValue = _productDetail.inOffer!;
      inOffer = inOfferValue == 1 ? true : false;

      inhome = _productDetail.inHome!;
      showInHome = inhome == 1 ? true : false;

      inGram = _productDetail.haveGram == 1 ? true : false;
      inKG = _productDetail.haveKg == 1 ? true : false;
      inPCs = _productDetail.havePcs == 1 ? true : false;
      inLiter = _productDetail.haveLiter == 1 ? true : false;
      inML = _productDetail.haveMl == 1 ? true : false;

      gramTextEditor.text = _productDetail.gram.toString();
      kgTextEditor.text = _productDetail.kg.toString();
      pcsTextEditor.text = _productDetail.pcs.toString();
      literTextEditor.text = _productDetail.liter.toString();
      mlTextEditor.text = _productDetail.ml.toString();

      cover = _productDetail.cover.toString();

      selectedStatus = _productDetail.status as int;
      selectedStock = _productDetail.inStock as int;
      var imgs = jsonDecode(_productDetail.images.toString());
      int index = 0;
      imgs.forEach((element) {
        images[index] = element.toString();
        index++;
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> onUpdateProduct() async {
    var body = {
      "id": productId,
      "cover": cover,
      "name": nameTextEditor.text,
      "images": jsonEncode(images),
      "original_price": originalPriceTextEditor.text,
      "sell_price":
          sellPriceTextEditor.text.isNotEmpty ? sellPriceTextEditor.text : 0,
      "discount":
          discountTextEditor.text.isNotEmpty ? discountTextEditor.text : 0,
      "cate_id": selectedProductCateId,
      "sub_cate_id": selectedSubCateId,
      "status": selectedStatus,
      "in_stock": selectedStock,
      "descriptions": descriptionsTextEditor.text,
      "key_features": keyFeaturesTextEditor.text,
      "disclaimer": disclaimerTextEditor.text,
      "in_offer": inOffer == true ? 1 : 0,
      "is_single": isSingle == true ? 1 : 0,
      "in_home": inhome,
      "have_gram": inGram == true ? 1 : 0,
      "gram": inGram == true ? gramTextEditor.text : 0,
      "have_kg": inKG == true ? 1 : 0,
      "kg": inKG == true ? kgTextEditor.text : 0,
      "have_pcs": inPCs == true ? 1 : 0,
      "pcs": inPCs == true ? pcsTextEditor.text : 0,
      "have_liter": inLiter == true ? 1 : 0,
      "liter": inLiter == true ? literTextEditor.text : 0,
      "have_ml": inML == true ? 1 : 0,
      "ml": inML == true ? mlTextEditor.text : 0,
    };
    var response = await parser.onUpdateProduct(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('update'.tr);
      Get.find<ProductController>().getMyProducts();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                    "Please wait".tr,
                    style: const TextStyle(fontFamily: 'bold'),
                  )),
                ],
              )
            ],
          ),
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void selectFromGalleryOthers(String kind, int index) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
      Get.dialog(
          SimpleDialog(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      child: Text(
                    "Please wait".tr,
                    style: const TextStyle(fontFamily: 'bold'),
                  )),
                ],
              )
            ],
          ),
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            // cover = body['image_name'];
            images[index] = body['image_name'];
            // debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void onRealPrice(var input) {
    if (input != '' && discountTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      debugPrint(value.toString());
      double sellPriceFinal = num.tryParse(discountTextEditor.text)!.toDouble();
      if (sellPriceFinal > 0 && value > 1) {
        double discountPriceFinal =
            num.tryParse(discountTextEditor.text)!.toDouble();
        double realPrice =
            num.tryParse(originalPriceTextEditor.text)!.toDouble();
        percentage(discountPriceFinal, realPrice);
      }
    }
  }

  void onDiscountPrice(var input) {
    if (input != '' && originalPriceTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      double realPrice = num.tryParse(originalPriceTextEditor.text)!.toDouble();
      if (realPrice > 0 && value <= 99) {
        double discountPriceFinal =
            num.tryParse(discountTextEditor.text)!.toDouble();
        percentage(discountPriceFinal, realPrice);
      }
      if (value >= 99) {
        discountTextEditor.text = '';
        discountTextEditor.text = '99';
        showToast('Discount must be less than 100'.tr);
        update();
      }
    }
  }

  void percentage(double percent, double total) {
    double sum = (total * percent) / 100;
    sum = double.parse((sum).toStringAsFixed(2));
    debugPrint(sum.toString());
    // sellPrice.text = sum.toString();
    double realPrice = num.tryParse(originalPriceTextEditor.text)!.toDouble();
    sellPriceTextEditor.text = (realPrice - sum).toString();
    update();
  }
}
