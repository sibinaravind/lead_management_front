import '../../config/flavour_config.dart';

class Constant {
  // Base URL DEV
  String get featureBaseUrl {
    switch (FlavourConfig.partner()) {
      case Partner.affiniks:
        return 'http://localhost:3000/'; //'http://52.66.252.146:3000/';
      case Partner.partner1:
        return '';
      case Partner.partner2:
        return "";
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

  String configList = 'config/list';
  String editConfigList = 'config/edit_configList';

  String camapignList = 'campaign/list';
  String deleteCampaign = 'campaign/delete/';
  String addCampaign = 'campaign/insert';

  String teamLeadList = 'officer/listLeadOfficers';
  String addOfficerToLead = 'officer/addOfficerToLead';
  String deleteOfficerFromLead = 'officer/deleteOfficerFromLead';

  String allLeads = 'lead/getAllLeads';
  String addLead = 'lead/insertLead';
  String updateLead = 'lead/updateLead';
  String getLeadDetail = 'customer/getCustomer';
  String getDeadLeads = 'lead/getAllDeadLeads';
  String restoreDeadLead = 'lead/restoreClientFromDead';

  String addFeedback = 'customer/logCallEvent';
  String getIncompleteList = 'customer/register/incompleteList';

  String editRegistration = 'customer/register/update_basic_info';
  String updateAcademicRecords = 'customer/register/update_academic_records';

  // String editConfig = customer/register/incompleteList lead/getAllDeadLeads customer/register/update_academic_records 'config/edit_configList'; customer/logCallEvent officer/addOfficerToLead officer/deleteOfficerFromLead lead/getAllLeads getCustomer lead/insertLead projectList

  String accessPermissions = 'config/access_permission';
  String accessPermissionsEdit = 'config/edit_accessList';
  String accessPermissionsDelete = 'config/delete_accesspermission';
  String accessPermissionsAdd = 'config/insert_accesspermission';
}
