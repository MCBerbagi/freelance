/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/model/slider_model.dart';
import 'package:handyman/app/backend/parse/slider_parse.dart';

class SliderController extends GetxController implements GetxService {
  final SliderParser parser;
  int current = 0;

  List<Item> imgList = const <Item>[
    Item('assets/images/bob.gif', 'Welcome to Handyman',
        'In publishing and graphic design lorem ipsum is a filler text commonly used to demonstrate.'),
    Item('assets/images/bob.gif', 'Door to Door Supprot',
        'In publishing and graphic design lorem ipsum is a filler text commonly used to demonstrate.'),
    Item('assets/images/bob.gif', 'Easy Track Order',
        'In publishing and graphic design lorem ipsum is a filler text commonly used to demonstrate.'),
  ];

  final CarouselController controller = CarouselController();

  SliderController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    update();
  }

  void updateSliderIndex(int index) {
    current = index;
    update();
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
    update();
  }
}
