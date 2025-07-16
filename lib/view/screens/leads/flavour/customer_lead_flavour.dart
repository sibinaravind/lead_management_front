import '../../../../config/flavour_config.dart';
import 'maxima_fields.dart';
import 'affiniks_fields.dart';
import 'sejeya_fields.dart';

class CustomerLeadFlavour {
  static List<Map<String, dynamic>> userTableList() {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return AffiniksFields().userTableList();
      case Partner.partner1:
        return partner1Fields().userTableList();
      case Partner.partner2:
        return MaximaFields().userTableList();
      default:
        return [];
    }
  }
}
