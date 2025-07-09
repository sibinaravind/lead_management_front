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

  String teamLeadList = 'officer/listLeadOfficers';
  String addOfficerToLead = 'officer/addOfficerToLead';
  String deleteOfficerFromLead = 'officer/deleteOfficerFromLead';

  // String editConfig = 'config/edit_configList';officer/addOfficerToLead officer/deleteOfficerFromLead

  String accessPermissions = 'config/access_permission';
  String accessPermissionsEdit = 'config/edit_accessList';
}
