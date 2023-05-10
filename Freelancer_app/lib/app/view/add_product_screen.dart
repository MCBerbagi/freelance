/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/controller/add_product_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            value.action == 'new'.tr
                ? 'Add New Product'.tr
                : 'Update Product'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                    decoration: myBoxDecoration(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                title: Text('Choose From'.tr),
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('camera');
                                    },
                                    child: Text('Camera'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('gallery');
                                    },
                                    child: Text('Gallery'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'.tr),
                                  )
                                ],
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${value.cover}'),
                              placeholder: const AssetImage(
                                  "assets/images/placeholder.jpeg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/notfound.png',
                                    fit: BoxFit.cover, height: 100, width: 100);
                              },
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.nameTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Product Name".tr),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.onProductCateList();
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Select Category'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    bodyText1(
                                        value.selectedProductCateName == '' ||
                                                value.selectedProductCateName
                                                    .isEmpty
                                            ? 'Select'.tr
                                            : value.selectedProductCateName),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: ThemeProvider.greyColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.onProductSubCateList();
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Select Sub Category'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    bodyText1(value.selectedSubCateName == '' ||
                                            value.selectedSubCateName.isEmpty
                                        ? 'Select'.tr
                                        : value.selectedSubCateName),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: ThemeProvider.greyColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.originalPriceTextEditor,
                              onChanged: (String txt) {
                                value.onRealPrice(txt);
                              },
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Product price".tr),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.discountTextEditor,
                              onChanged: (String txt) {
                                value.onDiscountPrice(txt);
                              },
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Discount".tr),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              readOnly: true,
                              controller: value.sellPriceTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Sell price".tr),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.descriptionsTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Description".tr),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                title: Text('Status'.tr),
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.updateStatus(1);
                                    },
                                    child: Text('Active'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.updateStatus(0);
                                    },
                                    child: Text('Hide'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'.tr),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Status'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    bodyText1(value.selectedStatus == 0
                                        ? 'Hide'.tr
                                        : 'Available'.tr),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: ThemeProvider.greyColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                title: Text('In Stock'.tr),
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.updateStock(1);
                                    },
                                    child: Text('In Stock'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.updateStock(0);
                                    },
                                    child: Text('Out of Stock'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'.tr),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('In Stock'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    bodyText1(value.selectedStock == 0
                                        ? 'Out of Stock'.tr
                                        : 'In Stock'.tr),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: ThemeProvider.greyColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('Is Single'.tr),
                                  Switch(
                                    value: value.isSingle,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.isSinglToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In Offer'.tr),
                                  Switch(
                                    value: value.inOffer,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inOfferToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In Home'.tr),
                                  Switch(
                                    value: value.showInHome,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.showInHomePage(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topLeft,
                          child: heading3('Add Photos'.tr),
                        ),
                        const SizedBox(height: 8),
                        GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(4),
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          crossAxisCount: 3,
                          childAspectRatio: 150 / 100,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            value.images.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoActionSheet(
                                      title: Text('Choose From'.tr),
                                      actions: <CupertinoActionSheetAction>[
                                        CupertinoActionSheetAction(
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            value.selectFromGalleryOthers(
                                                'camera', index);
                                          },
                                          child: Text('Camera'.tr),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            value.selectFromGalleryOthers(
                                                'gallery', index);
                                          },
                                          child: Text('Gallery'.tr),
                                        ),
                                        CupertinoActionSheetAction(
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'.tr),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.images[index].toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In Gram'.tr),
                                  Switch(
                                    value: value.inGram,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inGramToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        value.inGram == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: TextFormField(
                                    controller: value.gramTextEditor,
                                    onChanged: (String txt) {},
                                    cursorColor: ThemeProvider.appColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        border: InputBorder.none,
                                        labelText: "Gram Value".tr),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In KG'.tr),
                                  Switch(
                                    value: value.inKG,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inKGToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        value.inKG == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: TextFormField(
                                    controller: value.kgTextEditor,
                                    onChanged: (String txt) {},
                                    cursorColor: ThemeProvider.appColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        border: InputBorder.none,
                                        labelText: "KG Value".tr),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In Liter'.tr),
                                  Switch(
                                    value: value.inLiter,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inLiterToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        value.inLiter == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: TextFormField(
                                    controller: value.literTextEditor,
                                    onChanged: (String txt) {},
                                    cursorColor: ThemeProvider.appColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        border: InputBorder.none,
                                        labelText: "Liter Value".tr),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In PCs'.tr),
                                  Switch(
                                    value: value.inPCs,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inPCsToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        value.inPCs == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: TextFormField(
                                    controller: value.pcsTextEditor,
                                    onChanged: (String txt) {},
                                    cursorColor: ThemeProvider.appColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        border: InputBorder.none,
                                        labelText: "PCs Value".tr),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('In ML'.tr),
                                  Switch(
                                    value: value.inML,
                                    activeColor: ThemeProvider.appColor,
                                    onChanged: (bool status) {
                                      value.inMLToggle(status);
                                    },
                                  ),
                                ],
                              )),
                        ),
                        value.inML == true
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: TextFormField(
                                    controller: value.mlTextEditor,
                                    onChanged: (String txt) {},
                                    cursorColor: ThemeProvider.appColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        border: InputBorder.none,
                                        labelText: "ML Value".tr),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.keyFeaturesTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Key Features".tr),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: TextFormField(
                              controller: value.disclaimerTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Disclaimer".tr),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyElevatedButton(
                          onPressed: () {
                            if (value.action == 'new') {
                              value.onSubmitProduct();
                            } else {
                              value.onUpdateProduct();
                            }
                          },
                          color: ThemeProvider.appColor,
                          height: 45,
                          width: double.infinity,
                          child: Text(
                            'Submit'.tr,
                            style: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 16,
                                color: ThemeProvider.whiteColor,
                                fontFamily: 'bold'),
                          ),
                        ),
                      ],
                    )),
              ),
      );
    });
  }
}
