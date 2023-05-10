/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/slider_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:get/get.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      onSelected: (value) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: IconButton(
          icon: const Icon(Icons.translate),
          color: ThemeProvider.appColor,
          onPressed: () {},
        ),
      ),
      itemBuilder: (context) => AppConstants.languages
          .map((e) => PopupMenuItem<String>(
                value: e.languageCode.toString(),
                onTap: () {
                  var locale = Locale(e.languageCode.toString());
                  Get.updateLocale(locale);
                  Get.find<SliderController>().saveLanguage(e.languageCode);
                },
                child: Text(e.languageName.toString()),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: ThemeProvider.transParent,
            elevation: 0,
            actions: <Widget>[getLanguages()],
          ),
          body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .4,
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .45,
                              decoration: const BoxDecoration(
                                color: ThemeProvider.appColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            value.imgList.asMap().entries.map(
                                          (entry) {
                                            return GestureDetector(
                                              onTap: () => value.controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 10.0,
                                                height: 10.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: (Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? ThemeProvider
                                                              .whiteColor
                                                          : ThemeProvider
                                                              .secondaryAppColor)
                                                      .withOpacity(
                                                          value.current ==
                                                                  entry.key
                                                              ? 1
                                                              : 0.6),
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * .9,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              value.updateSliderIndex(index);
                            },
                            // autoPlay: true,
                          ),
                          items: value.imgList
                              .map(
                                (e) => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      e.img,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .4,
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      padding: const EdgeInsets.all(40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            child: Text(
                                              e.detail.tr,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              e.text.tr,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'medium',
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          MyElevatedButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRouter
                                                      .getChooseLocationRoute(),
                                                );
                                              },
                                              color: ThemeProvider.whiteColor,
                                              height: 45,
                                              width: double.infinity,
                                              child: Text(
                                                'Get Started'.tr,
                                                style: const TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 16,
                                                    color:
                                                        ThemeProvider.appColor,
                                                    fontFamily: 'bold'),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          carouselController: value.controller,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
