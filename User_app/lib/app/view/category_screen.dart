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
import 'package:handyman/app/controller/category_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Category'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(16),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 3,
                  childAspectRatio: 90 / 100,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    value.categoryList.length,
                    (i) {
                      return GestureDetector(
                        onTap: () {
                          value.onFreelancerList(
                              value.categoryList[i].id as int,
                              value.categoryList[i].name.toString());
                        },
                        child: Container(
                          decoration: myBoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: FadeInImage(
                                  width: 60,
                                  height: 60,
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.categoryList[i].cover.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/placeholder.jpeg',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover);
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  value.categoryList[i].name.toString(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'medium'),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
