/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/address_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Address'.tr,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.only(left: 6),
              ),
              onPressed: () {
                value.onAddNewAddress();
              },
              child: Text(
                'Add+'.tr,
                style: const TextStyle(
                  color: ThemeProvider.whiteColor,
                  fontFamily: 'medium',
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (var item in value.addressList)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 30),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.titles[item.title as int].toString(),
                                  style: const TextStyle(
                                      fontFamily: 'medium', fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.updateAddress(item.id as int);
                                      },
                                      child: const Icon(Icons.edit,
                                          color: ThemeProvider.appColor),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const Icon(Icons.delete,
                                                        size: 40,
                                                        color: ThemeProvider
                                                            .neutralAppColor2),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Are you sure'.tr,
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontFamily: 'medium'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('to delete Address ?'
                                                        .tr),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .whiteColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Cancel'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              Get.find<
                                                                      AddressController>()
                                                                  .deleteAddress(
                                                                      item.id
                                                                          as int);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .whiteColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .appColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Delete'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(Icons.delete,
                                          color:
                                              ThemeProvider.neutralAppColor2),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(
                                  '${item.address} ${item.house} ${item.landmark} ${item.pincode}'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      );
    });
  }
}
