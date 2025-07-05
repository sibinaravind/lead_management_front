// import 'package:flutter/services.dart';

import '../core/flavor/flavor_config.dart';

enum Partner { affiniks, partner1, partner2 }

var appFlavor = FlavorConfigration.instance.name;

class FlavourConfig {
  static Partner partner() {
    switch (appFlavor) {
      case Partner.affiniks:
        return Partner.affiniks;
      case Partner.partner1:
        return Partner.partner1;
      case Partner.partner2:
        return Partner.partner2;

      default:
        return Partner.affiniks;
    }
  }

  static String partnerName() {
    switch (partner()) {
      case Partner.affiniks:
        return 'Affiniks';
      case Partner.partner1:
        return 'partner1';
      case Partner.partner2:
        return '';
      default:
        return '';
    }
  }

  static String appLogo() {
    switch (partner()) {
      case Partner.affiniks:
        return 'assets/images/affiniks_logo.webp';
      case Partner.partner1:
        return 'assets/images/app_logo.png';
      case Partner.partner2:
        return 'assets/images/app_logo.png';
      default:
        return '';
    }
  }
}
