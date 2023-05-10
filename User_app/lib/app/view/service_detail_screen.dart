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
import 'package:handyman/app/controller/service_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:skeletons/skeletons.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              value.serviceDetail.name.toString(),
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.serviceDetail.cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/notfound.png',
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover);
                                    },
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: ThemeProvider.appColorTint,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Text(
                                          '${value.serviceDetail.discount} %',
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontFamily: 'bold',
                                              fontSize: 14),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  heading1(value.serviceDetail.name.toString()),
                                  const SizedBox(height: 12),
                                  heading4(value
                                      .serviceDetail.webCatesData!.name
                                      .toString()),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    child: Text(
                                      value.serviceDetail.descriptions
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${value.serviceDetail.price}'
                                            : '${value.serviceDetail.price}${value.currencySymbol}',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: ThemeProvider.greyColor,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${value.serviceDetail.off}'
                                            : '${value.serviceDetail.off}${value.currencySymbol}',
                                        style: const TextStyle(
                                            color: ThemeProvider.appColor,
                                            fontFamily: 'bold',
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${'Duration'.tr}: ${value.serviceDetail.duration} min',
                                    style: const TextStyle(
                                        color: ThemeProvider.secondaryAppColor,
                                        fontFamily: 'medium'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: MyElevatedButton(
                                      onPressed: () {
                                        if (value.serviceDetail.isChecked ==
                                            true) {
                                          value.onRemoveService();
                                        } else {
                                          value.onAddService();
                                        }
                                      },
                                      color: ThemeProvider.appColor,
                                      height: 38,
                                      width: 150,
                                      child: Text(
                                        value.serviceDetail.isChecked == false
                                            ? 'Add Service'.tr
                                            : 'Remove Service'.tr,
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 16,
                                            color: ThemeProvider.whiteColor,
                                            fontFamily: 'bold'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
