import '../../../../config/flavour_config.dart';

import 'maxima_fields.dart';
import 'affiniks_fields.dart';
import 'sejeya_fields.dart';

class EmployeeFlavour {
  static List<Map<String, dynamic>> userTableList() {
    switch (FlavourConfig.partner()) {
      case Partner.travel:
        return AffiniksFields().userTableList();
      case Partner.migration:
        return partner1Fields().userTableList();
      case Partner.vehicle:
        return MaximaFields().userTableList();
      case Partner.education:
        return MaximaFields().userTableList();
      case Partner.realestate:
        return MaximaFields().userTableList();
      case Partner.others:
        return MaximaFields().userTableList();
      default:
        return AffiniksFields().userTableList();
    }
  }
}
