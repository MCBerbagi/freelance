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
import 'package:handyman/app/controller/handyman_profile_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class HandymanProfileScreen extends StatefulWidget {
  const HandymanProfileScreen({Key? key}) : super(key: key);

  @override
  State<HandymanProfileScreen> createState() => _HandymanProfileScreenState();
}

class _HandymanProfileScreenState extends State<HandymanProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HandymanProfileController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              value.apiCalled == true
                  ? value.freelancerDetail.name.toString()
                  : '',
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  value.addToFav();
                },
                icon: Icon(
                  value.isFav == true ? Icons.favorite : Icons.favorite_border,
                  color: ThemeProvider.whiteColor,
                ),
              ),
            ]),
        body: value.apiCalled == false
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 3,
                        maxHeight: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          alignment: Alignment.center,
                          height: 40,
                          width: 200,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                    Row(children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 110,
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 110,
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 110,
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            : value.freelancerDetail.name!.isNotEmpty
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: myBoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 100,
                                width: 100,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.freelancerDetail.cover.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/notfound.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover);
                                  },
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  heading2(
                                    value.freelancerDetail.name.toString(),
                                  ),
                                  const SizedBox(width: 8),
                                  value.freelancerDetail.verified == 1
                                      ? const CircleAvatar(
                                          radius: 8,
                                          backgroundColor:
                                              ThemeProvider.appColor,
                                          child: Icon(
                                            Icons.done,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              const SizedBox(height: 10),
                              bodyText1(
                                '${value.freelancerDetail.totalExperience.toString()} ${'year experience'.tr}',
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,
                                      color: value.freelancerDetail.rating! >= 1
                                          ? ThemeProvider.neutralAppColor1
                                          : ThemeProvider.greyColor,
                                      size: 18),
                                  Icon(Icons.star,
                                      color: value.freelancerDetail.rating! >= 2
                                          ? ThemeProvider.neutralAppColor1
                                          : ThemeProvider.greyColor,
                                      size: 18),
                                  Icon(Icons.star,
                                      color: value.freelancerDetail.rating! >= 3
                                          ? ThemeProvider.neutralAppColor1
                                          : ThemeProvider.greyColor,
                                      size: 18),
                                  Icon(Icons.star,
                                      color: value.freelancerDetail.rating! >= 4
                                          ? ThemeProvider.neutralAppColor1
                                          : ThemeProvider.greyColor,
                                      size: 18),
                                  Icon(Icons.star,
                                      color: value.freelancerDetail.rating! >= 5
                                          ? ThemeProvider.neutralAppColor1
                                          : ThemeProvider.greyColor,
                                      size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    value.freelancerDetail.totalRating
                                        .toString(),
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontFamily: 'medium',
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                value.currencySide == 'left'
                                    ? '${value.currencySymbol}${value.freelancerDetail.hourlyPrice}/${'hr'.tr}'
                                    : '${value.freelancerDetail.hourlyPrice}${value.currencySymbol}/${'hr'.tr}',
                                style: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold',
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 8),
                                      child: MyElevatedButton(
                                        onPressed: () {
                                          value.onServices(
                                              value.freelancerDetail.uid as int,
                                              value.freelancerDetail.name
                                                  .toString());
                                        },
                                        color: ThemeProvider.appColor,
                                        height: 45,
                                        width: double.infinity,
                                        child: Text(
                                          'Book Now'.tr,
                                          style: const TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 16,
                                              color: ThemeProvider.whiteColor,
                                              fontFamily: 'bold'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  value.freelancerDetail.haveShop == 1
                                      ? Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 16, left: 8),
                                            child: MyElevatedButton(
                                              onPressed: () {
                                                value.onProducts(
                                                    value.freelancerDetail.uid
                                                        as int,
                                                    value.freelancerDetail.name
                                                        .toString());
                                              },
                                              color: ThemeProvider
                                                  .secondaryAppColor,
                                              height: 45,
                                              width: double.infinity,
                                              child: Text(
                                                'Buy Products'.tr,
                                                style: const TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 16,
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'bold'),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          child: CupertinoSlidingSegmentedControl(
                            groupValue: value.selectedTab,
                            backgroundColor: Colors.black12,
                            children: {
                              0: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: heading4('Info'.tr),
                              ),
                              1: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: heading4('Gallery'.tr),
                              ),
                              2: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: heading4('Review'.tr),
                              ),
                            },
                            onValueChanged: (i) {
                              value.updateSegment(i as int);
                            },
                          ),
                        ),
                        Column(
                          children: [
                            if (value.selectedTab == 0)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: myBoxDecoration(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heading4('Service Provided'.tr),
                                    const SizedBox(height: 6),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        value.freelancerDetail.webCatesData!
                                            .length,
                                        (index) => lightText(
                                          value.freelancerDetail
                                              .webCatesData![index].name
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: heading4('Descriptions'.tr),
                                    ),
                                    lightText(
                                      value.freelancerDetail.descriptions
                                          .toString(),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: heading4('Contact Detail'.tr),
                                    ),
                                    lightText(value
                                        .freelancerDetail.userInfo!.email
                                        .toString()),
                                    lightText(value
                                        .freelancerDetail.userInfo!.mobile
                                        .toString())
                                  ],
                                ),
                              )
                            else if (value.selectedTab == 1)
                              value.gallery.isNotEmpty
                                  ? GridView.count(
                                      primary: false,
                                      padding: const EdgeInsets.all(4),
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      crossAxisCount: 3,
                                      childAspectRatio: 150 / 100,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      children: List.generate(
                                        value.gallery.length,
                                        (i) {
                                          return GestureDetector(
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.gallery[i].toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/notfound.png',
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                    width: 100,
                                                  );
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image.asset(
                                            "assets/images/no-data.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Text(
                                            'No Data Found'.tr,
                                            style: const TextStyle(
                                                fontFamily: 'bold'),
                                          ),
                                        ),
                                      ],
                                    )
                            else if (value.selectedTab == 2)
                              value.reviewList.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: value.reviewList.length,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) => Column(
                                        children: [
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                decoration: myBoxDecoration(),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          height: 50,
                                                          width: 50,
                                                          child: Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            width: 50,
                                                            height: 50,
                                                            child: FadeInImage(
                                                              image: NetworkImage(
                                                                  '${Environments.apiBaseURL}storage/images/${value.reviewList[i].user!.cover.toString()}'),
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/images/placeholder.jpeg"),
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  'assets/images/notfound.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 50,
                                                                  width: 50,
                                                                );
                                                              },
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              heading3(
                                                                  '${value.reviewList[i].user!.firstName.toString()} ${value.reviewList[i].user!.lastName.toString()}'),
                                                              const SizedBox(
                                                                  height: 4),
                                                              smallText(value
                                                                  .reviewList[i]
                                                                  .createdAt!
                                                                  .substring(
                                                                      0, 10))
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.star,
                                                                color: ThemeProvider
                                                                    .neutralAppColor1,
                                                                size: 12),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              value
                                                                  .reviewList[i]
                                                                  .rating
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: ThemeProvider
                                                                      .greyColor,
                                                                  fontFamily:
                                                                      'medium',
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    lightText(value
                                                        .reviewList[i].notes
                                                        .toString())
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image.asset(
                                            "assets/images/no-data.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Text(
                                            'No Data Found'.tr,
                                            style: const TextStyle(
                                                fontFamily: 'bold'),
                                          ),
                                        ),
                                      ],
                                    ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                  ),
      );
    });
  }
}
