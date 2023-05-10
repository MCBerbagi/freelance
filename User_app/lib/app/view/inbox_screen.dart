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
import 'package:handyman/app/controller/inbox_controller.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/navbar.dart';
import 'package:skeletons/skeletons.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InboxController>(
      builder: (value) {
        return Scaffold(
          drawer: const NavBar(),
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Inbox'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.parser.haveLoggedIn() == false
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/search.png',
                          width: 60, height: 60),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () {
                            value.onLoginRoutes();
                          },
                          child: Text(
                            'Opps, Please Login or Register first!'.tr,
                            style: const TextStyle(
                                fontFamily: 'bold',
                                color: ThemeProvider.appColor),
                          )),
                    ],
                  ),
                )
              : value.apiCalled == false
                  ? SkeletonListView(
                      itemCount: 5,
                    )
                  : value.chatList.isEmpty
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
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children:
                                List.generate(value.chatList.length, (index) {
                              return value.chatList[index].senderId
                                          .toString() ==
                                      value.uid
                                  ? GestureDetector(
                                      onTap: () {
                                        value.onChat(
                                            value.chatList[index].receiverId
                                                .toString(),
                                            '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: myBoxDecoration(),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: FadeInImage(
                                                  height: 30,
                                                  width: 30,
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.chatList[index].receiverCover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/notfound.png',
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                )),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      heading4(
                                                        '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}',
                                                      ),
                                                      smallText(value
                                                          .chatList[index]
                                                          .updatedAt
                                                          .toString())
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        value.onChat(
                                            value.chatList[index].senderId
                                                .toString(),
                                            '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: myBoxDecoration(),
                                        child: Row(
                                          children: [
                                            Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: FadeInImage(
                                                  height: 30,
                                                  width: 30,
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.chatList[index].senderCover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/notfound.png',
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                )),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      heading4(
                                                        '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}',
                                                      ),
                                                      smallText(value
                                                          .chatList[index]
                                                          .updatedAt
                                                          .toString())
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                          ),
                        ),
        );
      },
    );
  }
}
