// Updated Navigation Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/screens/campaign/campaign_screen.dart';
import 'package:overseas_front_end/view/screens/dashboard/dashbaord_screen.dart';
import 'package:overseas_front_end/view/screens/team_lead/team_lead_data_display.dart';
import '../../model/lead/lead_model.dart';
import '../../utils/style/colors/colors.dart';
import '../../view/screens/config/config_screen.dart';
import '../../view/screens/employee/employee_permission_screen.dart';
import '../../view/screens/employee/round_robin_screen.dart';
import '../../view/screens/leads/add_lead_screen.dart';

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
            // screen: LeadDataDisplay()),
            screen: AddLeadScreen(
              leadToEdit: LeadModel.fromJson({
                "_id": "693280ea138d99fa16ea4cb7",
                "client_id": "AELID00007",
                "name": "sibin",
                "email": "sibinjames.sibin@gmail.com",
                "phone": "9074033910",
                "country_code": "+91",
                "alternate_phone": "+44 9596473754",
                "whatsapp": "+91 9496473754",
                "gender": "Male",
                "dob": "1996-02-12T00:00:00.000Z",
                "marital_status": "Single",
                "service_type": "LEAD",
                "address": "aikatra",
                "city": "vellarikudnu",
                "state": "kerala",
                "country": "indfia",
                "pincode": "671533",
                "lead_source": "FACEBOOK",
                "source_campaign": "sdf",
                "status": "NEW",
                "note": "123df",
                "interested_in": ["MIGRATION"],
                "feedback": "looking for",
                "loan_required": true,
                "on_call_communication": true,
                "phone_communication": true,
                "email_communication": true,
                "whatsapp_communication": true,
                "product_interested": [],
                "budget": 12344,
                "preferred_location": "esf",
                "preferred_date": "2025-12-24T00:00:00.000Z",
                "officer_id": "692a9e99750ef4355983d19b",
                "academic_records": [
                  {
                    "qualification": "13",
                    "institution": "23",
                    "year_of_passing": 2023,
                    "percentage": 23,
                    "board": "22",
                    "description": "3"
                  }
                ],
                "birth_place": "fdf",
                "country_interested": ["US", "QATAR"],
                "courses_interested": ["MBBS"],
                "emergency_contact": "9074022910",
                "exam_records": [
                  {
                    "exam_name": "123",
                    "score": 13,
                    "test_date": "2000-01-26T00:00:00.000Z",
                    "validity": "2025-12-26T00:00:00.000Z",
                    "description": "1we"
                  }
                ],
                "group_type": "Family",
                "has_existing_loans": true,
                "has_relatives_abroad": true,
                "religion": "Christianity",
                "requires_flight_booking": true,
                "requires_home_loan": false,
                "requires_hotel_booking": true,
                "requires_job_assistance": true,
                "requires_legal_assistance": true,
                "requires_travel_insurance": true,
                "total_peoples": "3",
                "travel_records": [
                  {
                    "country": "123",
                    "purpose": "134",
                    "duration": "444",
                    "year": 2000,
                    "description": "134"
                  }
                ],
                "visited_countries": [],
                "work_records": [
                  {
                    "company": "Tcs",
                    "position": "se",
                    "start_date": "2025-12-02T00:00:00.000Z",
                    "end_date": "2025-12-25T00:00:00.000Z",
                    "description": "12"
                  },
                  {
                    "company": "133",
                    "position": "34",
                    "start_date": "2025-12-02T00:00:00.000Z",
                    "end_date": "2025-12-31T00:00:00.000Z",
                    "description": "123"
                  }
                ],
                "created_at": "2025-12-05T06:51:22.728Z",
                "updated_at": "2025-12-05T11:09:13.391Z",
                "branch": "TATA",
                "email_password": "123",
                "first_job_date": "2025-12-03T00:00:00.000Z",
                "gst_number": "27ABCDE1234F1Z5",
                "highest_qualification": "13",
                "model_preference": "13",
                "pan_card_number": "GNRPS2950F",
                "passport_expiry_date": "2025-12-25T00:00:00.000Z",
                "passport_number": "32743",
                "possession_timeline": "25/12/2025",
                "preferred_settlement_city": "",
                "profession": "355",
                "qualification": "13",
                "relative_country": "123",
                "relative_relation": "13",
                "skills": "1edf",
                "specialized_in": "134",
                "vehicle_type": "CAR",
                "annual_income": 443,
                "credit_score": 300,
                "employment_status": "Employed",
                "expected_salary": 55,
                "experience": 4,
                "job_gap_months": 4,
                "loan_amount_required": 34,
                "batch_preference": "Afternoon",
                "field_of_study": "UG",
                "preferred_study_mode": "Online",
                "year_of_passing": 2000,
                "accommodation_preference": "Apartment",
                "number_of_travelers": 12,
                "travel_duration": 23,
                "travel_purpose": "Business",
                "visa_type_required": "Business",
                "target_visa_type": "Work Visa",
                "furnishing_preference": "Semi-Furnished",
                "property_type": "Apartment",
                "property_use": "Commercial",
                "brand_preference": "TATA",
                "down_payment_available": 1233,
                "fuel_type": "Petrol",
                "insurance_type": "Comprehensive",
                "transmission": "Automatic",
                "birth_country": "UAE"
              }),
            )),
        // screen: Scaffold()),
        // NavigationItem(
        //   label: 'CRE Followup',
        //   route: 'cre_followup',
        //   icon: Icons.mark_email_read_rounded,
        // ),
        NavigationItem(
          label: 'Follow Up',
          route: 'follow_up',
          icon: Icons.call_sharp,
        ),
        NavigationItem(
          label: 'Dead Lead',
          route: 'dead_lead',
          icon: Icons.remove_circle_rounded,
        ),
      ],
    ),
    'customers': NavigationSection(
      title: 'Customers',
      icon: Icons.app_registration_rounded,
      color: AppColors.greenSecondaryColor,
      items: [
        // NavigationItem(
        //     label: 'Registration Pending',
        //     route: 'registration_pending',
        //     icon: Icons.pending_actions_rounded,
        //     screen: RegisterDataDisplay()),
        NavigationItem(
          label: 'Customer',
          route: 'customer',
          icon: Icons.task_alt_rounded,
        ),
      ],
    ),
    'products': NavigationSection(
      title: 'Products',
      icon: Icons.work_rounded,
      color: AppColors.viloletSecondaryColor,
      items: [
        // NavigationItem(
        //   label: 'Products',
        //   route: 'products',
        //   icon: Icons.folder_outlined,
        //   screen:
        //       ProjectDataDisplay(), // Placeholder, replace with actual screen
        // ),
        // NavigationItem(
        //   label: 'Client',
        //   route: 'client',
        //   icon: Icons.account_circle_outlined,
        //   screen:
        //       ClientDataDisplay(), // Placeholder, replace with actual screen
        // ),
        // NavigationItem(
        //   label: 'Vacancies',
        //   route: 'vacancies',
        //   icon: Icons.work_outline_rounded,
        //   screen:
        //       VacancyDataDisplay(), // Placeholder, replace with actual screen
        // ),
      ],
    ),
    'accounts': NavigationSection(
      title: 'Accounts',
      icon: Icons.book_rounded,
      color: AppColors.orangeSecondaryColor,
      items: [
        // NavigationItem(
        //   label: 'Accounts',
        //   route: 'accounts',
        //   icon: Icons.book_rounded,
        //   screen:
        //       ProjectDataDisplay(), // Placeholder, replace with actual screen
        // ),
        // NavigationItem(
        //   label: 'Reports',
        //   route: 'reports',
        //   icon: Icons.assessment_rounded,
        //   screen:
        //       ProjectDataDisplay(), // Placeholder, replace with actual screen
        // ),
        // NavigationItem(
        //   label: 'Client',
        //   route: 'client',
        //   icon: Icons.account_circle_outlined,
        //   screen:
        //       ClientDataDisplay(), // Placeholder, replace with actual screen
        // ),
        // NavigationItem(
        //   label: 'Vacancies',
        //   route: 'vacancies',
        //   icon: Icons.work_outline_rounded,
        //   screen:
        //       VacancyDataDisplay(), // Placeholder, replace with actual screen
        // ),
      ],
    ),
    'quotation': NavigationSection(
      title: 'Quotation',
      icon: Icons.request_quote_rounded,
      color: AppColors.redSecondaryColor,
      items: [
        NavigationItem(
          label: 'Quotation',
          route: 'quotation',
          icon: Icons.description_rounded,
        ),
        // Add more quotation-related items here if needed
      ],
    ),
    // 'application': NavigationSection(
    //   title: 'Application',
    //   icon: Icons.description_rounded,
    //   color: AppColors.orangeSecondaryColor,
    //   items: [
    //     NavigationItem(
    //       label: 'Application Verification',
    //       route: 'application_verification',
    //       icon: Icons.fact_check_rounded,
    //     ),
    //     NavigationItem(
    //       label: 'Application Pending',
    //       route: 'application_pending',
    //       icon: Icons.hourglass_empty_rounded,
    //     ),
    //     // NavigationItem(
    //     //   label: 'Offer Letter Apply',
    //     //   route: 'offer_letter_apply',
    //     //   icon: Icons.mail_outline_rounded,
    //     // ),
    //     // NavigationItem(
    //     //   label: 'Offer Letter Waiting',
    //     //   route: 'offer_letter_waiting',
    //     //   icon: Icons.timer_rounded,
    //     // ),
    //     // NavigationItem(
    //     //   label: 'Offer Letter',
    //     //   route: 'offer_letter',
    //     //   icon: Icons.description_rounded,
    //     // ),
    //     // NavigationItem(
    //     //   label: 'Application Schedule',
    //     //   route: 'application_schedule',
    //     //   icon: Icons.calendar_month_rounded,
    //     // ),
    //   ],
    // ),
    // 'visa': NavigationSection(
    //   title: 'Visa',
    //   icon: Icons.card_membership_rounded,
    //   color: AppColors.redSecondaryColor,
    //   items: [
    //     NavigationItem(
    //       label: 'Visa',
    //       route: 'visa',
    //       icon: Icons.contact_page_rounded,
    //     ),
    //   ],
    // ),
    // 'ticketing': NavigationSection(
    //   title: 'Ticketing',
    //   icon: Icons.airplane_ticket_rounded,
    //   color: AppColors.skyBlueSecondaryColor,
    //   items: [
    //     NavigationItem(
    //       label: 'Ticketing',
    //       route: 'ticketing',
    //       icon: Icons.flight_takeoff_rounded,
    //     ),
    //   ],
    // ),
    // 'deployment': NavigationSection(
    //   title: 'Deployment',
    //   icon: Icons.message_rounded,
    //   color: AppColors.greenSecondaryColor,
    //   items: [
    //     NavigationItem(
    //       label: 'Deployed',
    //       route: 'deployed',
    //       icon: Icons.send_rounded,
    //     ),
    //   ],
    // ),
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
      color: AppColors.blueSecondaryColor,
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
