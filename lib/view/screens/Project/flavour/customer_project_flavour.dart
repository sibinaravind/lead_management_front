import '../../../../config/flavour_config.dart';

import 'maxima_fields.dart';
import 'affiniks_fields.dart';
import 'sejeya_fields.dart';

class ProjectFlavour {
  static List<Map<String, dynamic>> projectTableList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().projectTableList();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> clientTableList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().clientTableList();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> vacancyTableList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().vacancyTableList();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> matchingList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().matchingList();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> shortListedList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().shortListed();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }
}
