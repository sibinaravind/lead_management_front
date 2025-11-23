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

  String addClient = "project/clientCreate";
  String clientList = "project/clientList";
  String updateClient = "project/clientUpdate";
  String deleteClient = "project/deleteClient";

  String projectList = "project/projectList";
  String addProject = "project/createProject";
  String deleteProject = "project/deleteProject";
  String editProject = "project/projectUpdate";

  String callEventList = "customer/customercall";

  String vacancyList = "project/vacancyList";
  String createVacancy = "project/createVacancy";
  String editVacancy = "project/editVacancy";
  String deleteVacancy = "project/deleteVacancy";
  String vacancyClientList = "project/getClientListOnVacancy";
  String removeClientFromVacancy = "project/removeClient";
  String addClientToVacancy = "project/insertClient/";
  String editClientInVacancy = "project/editClientInVacancy/";
  String getMatchingProfiles = "project/getMatchingProfiles";
  String addClientToFavourites = "project/addClientToFavourites";
  String removeClientFromFavourites = "project/removeClientFromFavourites";
  String getFavouriteClients = "project/getFavouriteClients/";

  String configList = 'config/list';
  String editConfigList = 'config/edit_configList';

  String camapignList = 'campaign/list';
  String deleteCampaign = 'campaign/delete/';
  String addCampaign = 'campaign/insert';

  String teamLeadList = 'officer/listLeadOfficers';
  String addOfficerToLead = 'officer/addOfficerToLead';
  String deleteOfficerFromLead = 'officer/deleteOfficerFromLead';

  String getAllFilterdLeads = 'lead/getAllFilterdLeads';
  String getAllFilterdHistory = 'lead/getAllFilterdHistory';
  String getLeadCount = 'lead/getLeadCount';
  String allLeads = 'lead/getAllLeads';
  String addLead = 'lead/insertLead';
  String updateLead = 'lead/updateLead';
  String getLeadDetail = 'customer/getCustomer';
  String getDeadLeads = 'lead/getAllDeadLeads';
  String restoreDeadLead = 'lead/restoreClientFromDead';

  String getCustomerInteraction = 'customer/getCustomerInteraction/';

  String addFeedback = 'customer/logCallEvent';
  String getIncompleteList = 'customer/register/incompleteList';

  // String editConfig = customer/register/incompleteList lead/getAllDeadLeads customer/register/update_academic_records 'config/edit_configList'; customer/logCallEvent officer/addOfficerToLead officer/deleteOfficerFromLead lead/getAllLeads getCustomer lead/insertLead projectList

  String accessPermissions = 'config/access_permission';
  String accessPermissionsEdit = 'config/edit_accessList';
  String accessPermissionsDelete = 'config/delete_accesspermission';
  String accessPermissionsAdd = 'config/insert_accesspermission';

  String updatePersonalDetails = 'customer/register/update_basic_info';
  String updateAcademicRecords = 'customer/register/update_academic_records';
  String updateTravelHistory = 'customer/register/travel_history_records';
  String updateExamRecords = 'customer/register/update_exam_records';
  String updateWorkRecords = 'customer/register/work_history_records';
  String setRequiredDocuments = 'customer/register/setRequiredDocuments';
  String updateClientRequiredDocuments =
      'customer/register/updateClientRequiredDocuments';
}
