// import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';

class Dimension {
  bool getHeight(context){
    bool isMobile=false;
    return isMobile=MediaQuery.of(context).size.width<600;
  }
  // static double get screenHeight => Get.height;
  // static double get screenWidth => Get.width;

  // static bool get isMobile => Get.width < 600;
  // static bool get isTablet => Get.width >= 600 && Get.width < 1200;
  // static bool get isDesktop => Get.width >= 1200;
}
