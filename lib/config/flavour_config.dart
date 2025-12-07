// import 'package:flutter/services.dart';

import '../core/flavor/flavor_config.dart';

enum Partner { travel, migration, vehicle, education, realestate, others }

var appFlavor = FlavorConfigration.instance.name;

class FlavourConfig {
  static Partner partner() {
    switch (appFlavor) {
      case Partner.travel:
        return Partner.travel;
      case Partner.migration:
        return Partner.migration;
      case Partner.vehicle:
        return Partner.vehicle;
      case Partner.education:
        return Partner.education;
      case Partner.realestate:
        return Partner.realestate;
      case Partner.others:
        return Partner.others;
      default:
        return Partner.others;
    }
  }

  static String partnerName() {
    switch (partner()) {
      case Partner.travel:
        return 'Travel';
      case Partner.migration:
        return 'Migration';
      case Partner.vehicle:
        return 'Vehicle';
      case Partner.education:
        return 'education';
      case Partner.realestate:
        return 'realestate';
      case Partner.others:
        return 'others';
    }
  }

  static String appLogo() {
    // switch (partner()) {
    //   case Partner.travel:
    return 'assets/images/affiniks_logo.webp';
    //     case Partner.migration:
    //       return 'assets/images/app_logo.png';
    //     case Partner.vehicle:
    //       return 'assets/images/app_logo.png';
    //     case Partner.education:
    //       return 'assets/images/app_logo.png';
    //     case Partner.realestate:
    //       return 'assets/images/app_logo.png';
    //     case Partner.others:
    //       return 'assets/images/app_logo.png';
    //   }
  }
}
