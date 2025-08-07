// Updated Navigation Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/model/access_permissions/access_permissions.dart';
import 'package:overseas_front_end/view/screens/Project/client_data_display.dart';
import 'package:overseas_front_end/view/screens/Project/project_data_display.dart';
import 'package:overseas_front_end/view/screens/Project/vacancy_data_display.dart';
import 'package:overseas_front_end/view/screens/campaign/campaign_screen.dart';
import 'package:overseas_front_end/view/screens/dashboard/dashbaord_screen.dart';
import 'package:overseas_front_end/view/screens/registration/register_data_display.dart';
import 'package:overseas_front_end/view/screens/team_lead/team_lead_data_display.dart';
import '../../utils/style/colors/colors.dart';
import '../../view/screens/config/config_screen.dart';
import '../../view/screens/employee/employee_permission_screen.dart';
import '../../view/screens/employee/round_robin_screen.dart';
import '../../view/screens/leads/lead_data_display.dart';
import '../../view/screens/officers/employee_data_display.dart';

class NavigationController extends GetxController {
  var currentMainTab =
      'dashboard'.obs; // 'dashboard', 'leads', 'sales', 'analytics'
  var currentSubTab = 'overview'.obs;
  final Map<String, NavigationSection> navigationSections = {
    'dashboard': NavigationSection(
      title: 'Dashboard',
      icon: Icons.dashboard_rounded,
      color: AppColors.blueSecondaryColor,
      items: [
        NavigationItem(
            label: 'Overview',
            route: 'overview',
            icon: Icons.analytics_outlined,
            screen: DashboardScreen()),
        // NavigationItem(
        //   label: 'Statistics',
        //   route: 'statistics',
        //   icon: Icons.bar_chart_rounded,
        // ),
        // NavigationItem(
        //   label: 'Reports',
        //   route: 'reports',
        //   icon: Icons.report_outlined,
        // ),
      ],
    ),
    'leads': NavigationSection(
      title: 'Leads',
      icon: Icons.people_rounded,
      color: AppColors.violetPrimaryColor,
      items: [
        NavigationItem(
            label: 'Lead',
            route: 'lead',
            icon: Icons.follow_the_signs_rounded,
            screen: LeadDataDisplay()),
        NavigationItem(
          label: 'CRE Followup',
          route: 'cre_followup',
          icon: Icons.mark_email_read_rounded,
        ),
        NavigationItem(
          label: 'Dead Lead',
          route: 'dead_lead',
          icon: Icons.remove_circle_rounded,
        ),
      ],
    ),
    'registrations': NavigationSection(
      title: 'Registrations',
      icon: Icons.app_registration_rounded,
      color: AppColors.greenSecondaryColor,
      items: [
        NavigationItem(
            label: 'Registration Pending',
            route: 'registration_pending',
            icon: Icons.pending_actions_rounded,
            screen: RegisterDataDisplay()),
        NavigationItem(
          label: 'Registration Completed',
          route: 'registration_completed',
          icon: Icons.task_alt_rounded,
        ),
      ],
    ),
    'project': NavigationSection(
      title: 'Project',
      icon: Icons.work_rounded,
      color: AppColors.viloletSecondaryColor,
      items: [
        NavigationItem(
          label: 'Projects',
          route: 'projects',
          icon: Icons.folder_outlined,
          screen:
              ProjectDataDisplay(), // Placeholder, replace with actual screen
        ),
        NavigationItem(
          label: 'Client',
          route: 'client',
          icon: Icons.account_circle_outlined,
          screen:
              ClientDataDisplay(), // Placeholder, replace with actual screen
        ),
        NavigationItem(
          label: 'Vacancies',
          route: 'vacancies',
          icon: Icons.work_outline_rounded,
          screen:
              VacancyDataDisplay(), // Placeholder, replace with actual screen
        ),
      ],
    ),
    'application': NavigationSection(
      title: 'Application',
      icon: Icons.description_rounded,
      color: AppColors.orangeSecondaryColor,
      items: [
        NavigationItem(
          label: 'Application Verification',
          route: 'application_verification',
          icon: Icons.fact_check_rounded,
        ),
        NavigationItem(
          label: 'Application Pending',
          route: 'application_pending',
          icon: Icons.hourglass_empty_rounded,
        ),
        // NavigationItem(
        //   label: 'Offer Letter Apply',
        //   route: 'offer_letter_apply',
        //   icon: Icons.mail_outline_rounded,
        // ),
        // NavigationItem(
        //   label: 'Offer Letter Waiting',
        //   route: 'offer_letter_waiting',
        //   icon: Icons.timer_rounded,
        // ),
        // NavigationItem(
        //   label: 'Offer Letter',
        //   route: 'offer_letter',
        //   icon: Icons.description_rounded,
        // ),
        // NavigationItem(
        //   label: 'Application Schedule',
        //   route: 'application_schedule',
        //   icon: Icons.calendar_month_rounded,
        // ),
      ],
    ),
    'visa': NavigationSection(
      title: 'Visa',
      icon: Icons.card_membership_rounded,
      color: AppColors.redSecondaryColor,
      items: [
        NavigationItem(
          label: 'Visa',
          route: 'visa',
          icon: Icons.contact_page_rounded,
        ),
      ],
    ),
    'ticketing': NavigationSection(
      title: 'Ticketing',
      icon: Icons.airplane_ticket_rounded,
      color: AppColors.skyBlueSecondaryColor,
      items: [
        NavigationItem(
          label: 'Ticketing',
          route: 'ticketing',
          icon: Icons.flight_takeoff_rounded,
        ),
      ],
    ),
    'deployment': NavigationSection(
      title: 'Deployment',
      icon: Icons.message_rounded,
      color: AppColors.greenSecondaryColor,
      items: [
        NavigationItem(
          label: 'Deployed',
          route: 'deployed',
          icon: Icons.send_rounded,
        ),
      ],
    ),
    'employee': NavigationSection(
      title: 'Employee',
      icon: Icons.badge_rounded,
      color: AppColors.pinkSecondaryColor,
      items: [
        NavigationItem(
          label: 'Employee',
          route: 'employee',
          icon: Icons.person_outline_rounded,
          screen:
              EmployeeDataDisplay(), // Placeholder, replace with actual screen
        ),
        NavigationItem(
          label: 'Team Lead',
          route: 'team_lead',
          icon: Icons.settings,
          screen:
              TeamLeadDataDisplay(), // Placeholder, replace with actual screen
        ),
        NavigationItem(
          label: 'Employee Permission',
          route: 'employee_permission',
          icon: Icons.person_outline_rounded,
          screen:
              AccessPermissionScreen(), // Placeholder, replace with actual screen
        ),
        NavigationItem(
          label: 'Round Robin',
          route: 'round_robin',
          icon: Icons.settings,
          screen: RoundRobinScreen(), // Placeholder, replace with actual screen
        ),
      ],
    ),
    'config': NavigationSection(
      title: 'Config',
      icon: Icons.settings,
      color: AppColors.greenSecondaryColor,
      items: [
        NavigationItem(
            label: 'Config',
            route: 'config',
            icon: Icons.settings,
            screen: ConfigScreen()),
      ],
    ),
    'campaign': NavigationSection(
      title: 'Campaign',
      icon: Icons.campaign,
      color: AppColors.greenSecondaryColor,
      items: [
        NavigationItem(
            label: 'Campaign',
            route: 'campaign',
            icon: Icons.campaign,
            screen: CampaignScreen()),
      ],
    ),
  };

  void updateTab(String mainTab, String subTab) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentMainTab.value = mainTab;
      currentSubTab.value = subTab;
    });
  }

  void navigateTo(String mainTab, String subTab) {
    currentMainTab.value = mainTab;
    currentSubTab.value = subTab;
    update();
  }

  // bool isRouteSelected(String mainTab, String route) {
  //   return currentMainTab.value == mainTab && currentSubTab.value == route;
  // }

  // int getMainTabIndex(String mainTab) {
  //   final keys = navigationSections.keys.toList();
  //   return keys.indexOf(mainTab);
  // }

  // void navigateToDashboardOverview() {
  //   currentMainTab.value = 'dashboard';
  //   currentSubTab.value = 'overview';
  // }

  // String getMainTabName(int index) {
  //   final keys = navigationSections.keys.toList();
  //   return index < keys.length ? keys[index] : 'dashboard';
  // }

  // String getDefaultSubTab(String mainTab) {
  //   return navigationSections[mainTab]?.items.first.route ?? 'overview';
  // }
}

// Navigation Models (updated)
class NavigationItem {
  final String label;
  final String route;
  final IconData icon;
  final Widget? screen; // Optional screen for direct navigation

  NavigationItem({
    required this.label,
    required this.route,
    required this.icon,
    this.screen,
  });
}

class NavigationSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<NavigationItem> items;

  NavigationSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}
