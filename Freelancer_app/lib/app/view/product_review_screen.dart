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
import 'package:handyman_freelancer/app/controller/product_review_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:skeletons/skeletons.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductReviewController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Product Reviews'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: value.reviewList.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(
                              'No Data Found'.tr,
                              style: const TextStyle(
                                color: ThemeProvider.appColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView.builder(
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
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              width: 36,
                                              height: 36,
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.reviewList[i].productCover.toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/notfound.png',
                                                      width: 36,
                                                      height: 36,
                                                      fit: BoxFit.cover);
                                                },
                                                fit: BoxFit.cover,
                                                width: 36,
                                                height: 36,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                value.reviewList[i].name
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'medium',
                                                    color: ThemeProvider
                                                        .blackColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(
                                            thickness: 2,
                                            color:
                                                ThemeProvider.backgroundColor),
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              width: 50,
                                              height: 50,
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.reviewList[i].userCover.toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/notfound.png',
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                    height: 50,
                                                  );
                                                },
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  heading4(
                                                      '${value.reviewList[i].firstName.toString()} ${value.reviewList[i].lastName.toString()}'),
                                                  const SizedBox(height: 4),
                                                  smallText(value
                                                      .reviewList[i].createdAt!
                                                      .substring(0, 10))
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.star,
                                                    color: ThemeProvider
                                                        .neutralAppColor1,
                                                    size: 12),
                                                const SizedBox(width: 4),
                                                Text(
                                                  value.reviewList[i].rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'medium',
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        lightText(value.reviewList[i].notes
                                            .toString())
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
              ),
      );
    });
  }
}
