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
import 'package:handyman_freelancer/app/controller/add_service_controller.dart';
import 'package:handyman_freelancer/app/controller/service_category_controller.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddServiceController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            value.action == 'new'.tr
                ? 'Add New Service'.tr
                : 'Update Service'.tr,
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
                                  labelText: "Service Name".tr),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.delete<ServiceCategoryController>(force: true);
                            Get.toNamed(AppRouter.getServiceCategoryRoute(),
                                arguments: [value.selectedCateId]);
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
                                    bodyText1(value.selectedCateName == '' ||
                                            value.selectedCateName.isEmpty
                                        ? 'Select'.tr
                                        : value.selectedCateName),
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
                              controller: value.priceTextEditor,
                              onChanged: (String txt) {
                                value.onRealPrice(txt);
                              },
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Service price".tr),
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
                              controller: value.offTextEditor,
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
                              controller: value.durationTextEditor,
                              onChanged: (String txt) {},
                              cursorColor: ThemeProvider.appColor,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.greyColor),
                                  border: InputBorder.none,
                                  labelText: "Service Duration".tr),
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
                                smallText('Status'),
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
                                          'assets/images/placeholder.jpeg',
                                          fit: BoxFit.cover);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyElevatedButton(
                          onPressed: () {
                            if (value.action == 'new') {
                              value.onSubmit();
                            } else {
                              value.onUpdateService();
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
