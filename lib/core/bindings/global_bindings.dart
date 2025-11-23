import 'package:get/get.dart';
import 'package:overseas_front_end/controller/auth/login_controller.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/round_robin_controller.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import 'package:overseas_front_end/controller/registration/registration_controller.dart';
import 'package:overseas_front_end/controller/team_lead/team_lead_controller.dart';

import '../../controller/app_common/bloc/app_user_contoller.dart'
    show AppUserController;
import '../../controller/campaign/campaign_controller.dart';
import '../../controller/officers_controller/officers_controller.dart';
import '../../controller/permission_controller/access_permission_controller.dart';
import '../../view/screens/accounting/accounting.dart';
import '../../view/screens/product/product_list_screen.dart';
// import 'package:overseas_front_end/controller/employee/bloc/employee_data_controller.dart';
// import 'package:overseas_front_end/controller/leads/bloc/call_data_controller.dart';
// import 'package:overseas_front_end/controller/leads/bloc/lead_data_controller.dart';
// import 'package:overseas_front_end/controller/officer/bloc/officer_controller.dart';
// import 'package:overseas_front_end/controller/registration/bloc/registration_data_controller.dart';
// import 'package:overseas_front_end/controller/visa/bloc/visa_data_controller.dart';

// import '../../controller/app_common/bloc/app_user_contoller.dart';
// import '../../controller/application/bloc/app_data_controller.dart';
// import '../../controller/projects/bloc/projects_data_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(AppUserController());
    Get.lazyPut(() => AppUserController());
    Get.put(ConfigController());
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => AccessPermissionController());
    Get.lazyPut(() => CampaignController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RoundRobinController());
    Get.lazyPut(() => OfficersController());
    Get.lazyPut(() => TeamLeadController());
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => LeadController());
    Get.lazyPut(() => CustomerProfileController());
    Get.lazyPut(() => ProductServiceController());
    Get.lazyPut(() => BillController());

    // Get.lazyPut(() => RegistrationDataController());
    // Get.lazyPut(() => ProjectsDataContorller());
    // Get.lazyPut(() => EmployeeDataController());
    // Get.lazyPut(() => ApplicationDataController());
    // Get.lazyPut(() => OfficerController());
    // Get.lazyPut(() => VisaDataController());
    // Get.lazyPut(() => CallDataController());

    // Get.lazyPut(() => DrawerMoveController());
    // Get.lazyPut(() => LogoutController());
    // Get.lazyPut(() => UserDetailsController());
    // Get.lazyPut(() => UserListController());
    // Get.lazyPut(() => AuthController());
    // Get.lazyPut(() => AllUserListController());
    // Get.lazyPut(() => EligibleUsersListController());
    // Get.lazyPut(() => AllUserDetailsController());
  }
}
