import '../../config/flavour_config.dart';

class Constant {
  // Base URL DEV
  String get featureBaseUrl {
    switch (FlavourConfig.partner()) {
      case Partner.travel:
        return 'http://localhost:3000/'; // 'https://api-3tqsqkjuba-uc.a.run.app/'; //'http://52.66.252.146:3000/';
      case Partner.migration:
        return '';
      case Partner.vehicle:
        return "";
      case Partner.education:
        return "";
      case Partner.realestate:
        return "";
      case Partner.others:
        return "";
      default:
        return 'http://localhost:3000/';
    }
  }

  String productList = 'product/productList';
  String addProduct = 'product/productCreate';
  String updateProduct = 'product/productUpdate';
  String productDetails = 'product/productDetails';
  String productInterested = 'product/getProductIntrested';
  String getCustomerInteraction = 'lead/interactions/';

  String callEventList = "customer/customercall";
  String updateFeedback = 'customer/updatelog';
  String addFeedback = 'customer/logCallEvent';

  String getAllFilterdLeads = 'lead/getAllFilterdLeads';
  String getAllFilterdHistory = 'lead/getAllFilterdHistory';
  String getLeadCount = 'lead/getLeadCount';
  String allLeads = 'lead/getAllLeads';
  String addLead = 'lead/insertLead';
  String addBulkLead = 'lead/bulkInsertLeads';
  String updateLead = 'lead/updateLead';
  String getLeadDetail = 'lead/getLead';
  String updateLeadStatus = 'lead/updateLeadStatus';
  String addProductInterest = 'lead/addProductInterested/';
  String uploadLeadDocument = 'lead/updateClientRequiredDocuments/';

  String officerLogin = 'officer/login';
  String officerPasswordReset = 'officer/resetPassword';
  String officerInsert = 'officer/insert';
  String officerUpdate = 'officer/updateOfficer';
  String officerList = 'officer/list';
  String officerDetails = 'officer/details/';
  String officerResetPassword = 'officer/updatePassword';
  String officerUpdateStatus = 'officer/updateStatus/';
  String officerDelete = 'officer/delete';

  String roundRobinList = 'officer/listRoundRobin';
  String insertOfficersInToRoundRobinList = 'officer/insertStaffToRoundRobin';
  String removeOfficersInToRoundRobinList = 'officer/removeStaffFromRoundRobin';
  String insertRoundRobin = 'officer/insertRoundRobin';
  String deleteRoundRobin = 'officer/deleteRoundRobin';

  String projectList = "project/projectList";
  String addProject = "project/createProject";
  String deleteProject = "project/deleteProject";
  String editProject = "project/projectUpdate";

  String configList = 'config/list';
  String editConfigList = 'config/edit_configList';

  String camapignList = 'campaign/list';
  String deleteCampaign = 'campaign/delete/';
  String addCampaign = 'campaign/insert';

  String teamLeadList = 'officer/listLeadOfficers';
  String addOfficerToLead = 'officer/addOfficerToLead';
  String deleteOfficerFromLead = 'officer/deleteOfficerFromLead';

  // String editConfig = customer/register/incompleteList lead/getAllDeadLeads customer/register/update_academic_records 'config/edit_configList'; customer/logCallEvent officer/addOfficerToLead officer/deleteOfficerFromLead lead/getAllLeads getCustomer lead/insertLead projectList

  String accessPermissions = 'config/access_permission';
  String accessPermissionsEdit = 'config/edit_accessList';
  String accessPermissionsDelete = 'config/delete_accesspermission';
  String accessPermissionsAdd = 'config/insert_accesspermission';
}
