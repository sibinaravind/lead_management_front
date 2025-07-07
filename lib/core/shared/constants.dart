import '../../config/flavour_config.dart';

class Constant {
  // Base URL DEV
  String get featureBaseUrl {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return 'http://52.66.252.146:3000/';
      case Partner.partner1:
        return '';
      case Partner.partner2:
        return "";
      default:
        return ".";
    }
  }

  String officerInsert = 'officer/insert';
  String officerUpdate = 'officer/updateOfficer/';
  String officerList = 'officer/list';
  String officerDetails = 'officer/details/';
  String officerResetPassword = 'officer/updatePassword';
  String officerUpdateStatus = 'officer/updateStatus/';

  String configList = 'config/list';
  String editConfigList = 'config/edit_configList';
  String camapignList = 'campaign/list';
  String deleteCampaign = 'campaign/delete/';
  String addCampaign = 'campaign/insert';
}
// campaign/delete/campaign/insert

  // String authApiBaseUrl() = 'https://dev.api.neobank.gojoco.io/partner1/auth/';
  // String featureBaseUrl = 'https://dev.api.neobank.gojoco.io/partner1/neobank/';
  // String poolId() = "ap-southeast-1_IBVInfCNH";
  // String clientId = "412j3ucjmd3l9tbu5t4ebtj8fp";
  // Base URL PROD
  // String authApiBaseUrl() = 'https://api.partner1.gojoco.io/neobank/auth/';
  // String featureBaseUrl = 'https://api.partner1.gojoco.io/neobank/neobank/';
  // String poolId() = "ap-southeast-1_0eLpdTJis";
  // String clientId = "2ae5nfakgle2p2o2kqrc3apas7";