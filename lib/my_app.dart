import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/config/flavour_config.dart';
import 'package:overseas_front_end/core/bindings/global_bindings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/view/screens/auth/login_screen.dart';
import 'view/screens/drawer/main_layout_screen.dart';
import 'view/screens/error_screen/error_screen.dart';
import 'core/services/navigation_service.dart';
import 'view/screens/registration/registeration_add.dart';

final GlobalKey<NavigatorState> routerNavigatorKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    // Create a separate navigator key for GoRouter
    // UserCacheService().saveAuthToken(
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODZjZWRhOWU5Mjk5ZjM0MjlkNjIzOWEiLCJvZmZpY2VyX2lkIjoiNCIsImRlc2lnbmF0aW9uIjpbIkNPVU5TSUxPUiIsIkFETUlOIl0sImJyYW5jaCI6WyJUU1QxMyJdLCJvZmZpY2VycyI6W3sib2ZmaWNlcl9pZCI6IjY4NmZmMzA3MWRhNWViYmE1YzZjZjBiOSIsInN0YWZmX2lkIjoiMjMiLCJlZGl0X3Blcm1pc3Npb24iOmZhbHNlfSx7Im9mZmljZXJfaWQiOiI2ODdiNWIxYjBhZTY1ZjhjZTlkNDYwMWEiLCJzdGFmZl9pZCI6IjIzIiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg2Y2VkYTllOTI5OWYzNDI5ZDYyMzlhIiwic3RhZmZfaWQiOiI0IiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg3YjY4ZTAwYWU2NWY4Y2U5ZDQ2MDFiIiwic3RhZmZfaWQiOiIxMjEiLCJlZGl0X3Blcm1pc3Npb24iOmZhbHNlfSx7Im9mZmljZXJfaWQiOiI2ODdlM2RiY2NkYjdjNTJjOWQ5OTM1ZWIiLCJzdGFmZl9pZCI6Ijg1IiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg2Y2VkYTllOTI5OWYzNDI5ZDYyMzlhIiwic3RhZmZfaWQiOiI0IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODZkMWVkZGU5Mjk5ZjM0MjlkNjIzYTUiLCJzdGFmZl9pZCI6IjY0IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODdiMzM0NTBhZTY1ZjhjZTlkNDYwMTUiLCJzdGFmZl9pZCI6IjI1IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODdiNWIxYjBhZTY1ZjhjZTlkNDYwMWEiLCJzdGFmZl9pZCI6IjEwMCIsImVkaXRfcGVybWlzc2lvbiI6dHJ1ZX1dLCJpYXQiOjE3NTQ0NjU5MDYsImV4cCI6MTc1NDQ2NzcwNn0.vXpF291lBByUtS3my-AOhkr79JXneSIJWBugLSl7U8o');
    final GoRouter router = GoRouter(
      navigatorKey: routerNavigatorKey, // Use separate key for GoRouter
      // redirect: (context, state) {
      //   final loggedIn = UserCacheService().isLogin();
      //   if (!loggedIn && state.matchedLocation != '/') {
      //     return '/';
      //   }
      //   if (loggedIn && state.matchedLocation == '/') {
      //     return '/dashboard/dashboard/overview';
      //   }
      //   return null;
      // }, // Uncomment if you want to prpoerp logout //test
      routes: [
        GoRoute(
          path: '/', //test move to /
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard/:mainTab/:subTab',
          builder: (context, state) {
            final mainTab = state.pathParameters['mainTab'] ?? 'dashboard';
            final subTab = state.pathParameters['subTab'] ?? 'overview';
            return MainLayoutScreen(mainTab: mainTab, subTab: subTab);
          },
        ),
        GoRoute(
          path: '/test',
          builder: (context, state) => RegistrationAdd(
            lead: LeadModel.fromJson({
              "_id": "6878fe2a3e1c829a55bcebec",
              "client_id": "AECID00050",
              "branch": "Affinix",
              "officer_id": "686d1edde9299f3429d623a5",
              "recruiter_id": "686d1edde9299f3429d623a5",
              "status": "REGISTER",
              "name": "John",
              "email": "john.doe@example.com",
              "phone": "1234567890",
              "country_code": "+1",
              "alternate_phone": "+1 2345678901",
              "whatsapp": "+1 2345678903",
              "gender": "male",
              "dob": "12/02/1996",
              "matrial_status": "single",
              "address": "123 Main St",
              "city": "New York",
              "state": "NY",
              "country": "USA",
              "job_interests": ["Developer", "Researcher"],
              "country_interested": ["USA", "Canada"],
              "expected_salary": 80000,
              "qualification": "B.Tech Computer Science",
              "experience": 3,
              "skills": ["JavaScript", "Node.js"],
              "profession": "Engineer",
              "specialized_in": ["Software", "AI"],
              "lead_source": "direct",
              "note": "Looking for new opportunities",
              "on_call_communication": true,
              "on_whatsapp_communication": true,
              "on_email_communication": false,
              "service_type": "MIGRATION",
              "created_at": "2025-07-17T13:44:10.781Z",
              "birth_country": "USA",
              "birth_place": "New York",
              "email_password": "password123",
              "emergency_contact": "+1 2345678902",
              "last_name": "Doe",
              "marital_status": "single",
              "passport_expiry_date": "12/02/2024",
              "passport_number": "A1234567",
              "religion": "Christian",
              "updated_at": "2025-08-10T05:26:03.809Z",
              "academic_records": [
                {
                  "qualification": "BSc",
                  "institution": "ABC College",
                  "university": "XYZ University",
                  "start_year": 2022,
                  "end_year": 2030,
                  "grade": "A",
                  "percentage": 82.5
                },
                {
                  "qualification": "MSc",
                  "institution": "DEF College",
                  "university": "XYZ University",
                  "start_year": 2019,
                  "end_year": 2021,
                  "grade": "A+",
                  "percentage": 88
                }
              ],
              "exam_records": [
                {
                  "exam": "BSc",
                  "status": "PASS",
                  "validity_date": "2027-02-12T00:00:00.000Z",
                  "exam_date": "2027-02-12T00:00:00.000Z",
                  "grade": "A"
                },
                {
                  "exam": "BSc",
                  "status": "PASS",
                  "validity_date": "2027-02-12T00:00:00.000Z",
                  "exam_date": "2027-02-12T00:00:00.000Z",
                  "grade": "A",
                  "score": 2
                }
              ],
              "travel_records": [
                {
                  "country": "Canada",
                  "visa_type": "WORK",
                  "departure_date": "2021-02-12T00:00:00.000Z",
                  "return_date": null,
                  "visa_valid_date": "2023-02-12T00:00:00.000Z"
                },
                {
                  "country": "Uk",
                  "visa_type": "WORK",
                  "departure_date": "2021-02-12T00:00:00.000Z",
                  "return_date": "2022-02-12T00:00:00.000Z",
                  "visa_valid_date": "2022-02-12T00:00:00.000Z"
                }
              ],
              "first_job_date": "2016-06-01T00:00:00.000Z",
              "job_gap_months": 12,
              "work_records": [
                {
                  "position": "Staff Nurse",
                  "department": "ICU",
                  "organization": "ABC Hospital",
                  "country": "India",
                  "from_date": "2018-06-01T00:00:00.000Z",
                  "to_date": "2020-06-30T00:00:00.000Z"
                },
                {
                  "position": "Dr",
                  "department": "ICU",
                  "organization": "ABC Hospital",
                  "country": "India",
                  "from_date": "2016-06-01T00:00:00.000Z",
                  "to_date": "2017-06-30T00:00:00.000Z"
                }
              ],
              "documents": [
                {
                  "doc_type": "passport",
                  "required": false,
                  "file_path":
                      "uploads/client_documents/passport_client_6878fe2a3e1c829a55bcebec_1753462751121_spb6j.webp",
                  "uploaded_at": "2025-07-25T16:59:11.152Z"
                },
                {
                  "doc_type": "12th",
                  "required": true,
                  "file_path": null,
                  "uploaded_at": null
                }
              ]
            }),
          ),
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(),
      initialLocation: '/test',
    );
    // Initialize the navigation service with the router
    NavigationService.initialize(router);
    return GetMaterialApp.router(
      initialBinding: GlobalBindings(),
      title: ' ${FlavourConfig.partnerName()} ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: GoogleFonts.notoSansArmenianTextTheme(),
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: child!,
        );
      },
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
    );
  }
}
