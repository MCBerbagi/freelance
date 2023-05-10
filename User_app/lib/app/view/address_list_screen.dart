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
import 'package:handyman/app/controller/address_list_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:skeletons/skeletons.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Select Address'.tr,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  value.onNewAddress();
                },
                icon: const Icon(
                  Icons.add,
                  color: ThemeProvider.whiteColor,
                ))
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: MyElevatedButton(
                    onPressed: () {
                      value.saveAndClose();
                    },
                    color: ThemeProvider.appColor,
                    height: 40,
                    width: double.infinity,
                    child: Text('Save'.tr)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: ThemeProvider.greyColor,
                    height: 40,
                    width: double.infinity,
                    child: Text('Cancle'.tr)),
              )
            ],
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) => Column(
                      children: [
                        Card(
                          child: ListTile(
                            horizontalTitleGap: 0,
                            minVerticalPadding: 20,
                            title: Container(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(value
                                    .titles[value.addressList[i].title as int]
                                    .toString())),
                            subtitle: Text('${value.addressList[i].address} '
                                ' ${value.addressList[i].house} '
                                ' ${value.addressList[i].landmark} '
                                ' ${value.addressList[i].pincode}'),
                            trailing: Radio(
                              activeColor: ThemeProvider.appColor,
                              value: value.addressList[i].id.toString(),
                              groupValue: value.selectedAddressId,
                              onChanged: (data) {
                                value.saveAdd(data.toString());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
