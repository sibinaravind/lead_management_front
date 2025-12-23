import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/core/bindings/global_bindings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/model/product/product_model.dart';
import 'package:overseas_front_end/view/screens/auth/login_screen.dart';
import 'view/screens/booking/add_edit_booking_screen.dart';
import 'view/screens/booking/booking_details_screen.dart';
import 'view/screens/drawer/main_layout_screen.dart';
import 'view/screens/error_screen/error_screen.dart';
import 'core/services/navigation_service.dart';
import 'view/screens/leads/widgets/call_record_popup.dart';

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
          path: '/login', //test move to /
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
        // GoRoute(
        //   path: '/test',
        //   builder: (context, state) => VacancyDetailTab(
        //     vacancy: VacancyModel.fromJson({
        //       "_id": "68764a2f4eadcf60814e94c5",
        //       "job_title": "Nurse for Saudi",
        //       "job_category": "Nurse",
        //       "qualifications": ["BSC", "GNM"],
        //       "experience": "2",
        //       "salary_from": 60000,
        //       "salary_to": 6000879,
        //       "lastdatetoapply": "27/08/2025",
        //       "description": "nurse with",
        //       "country": "US",
        //       "city": "Bangalore",
        //       "status": "ACTIVE",
        //       "project": {
        //         "_id": "6871fce9deb23f3a0f52cebc",
        //         "project_name": "SAUDI mooh1",
        //         "organization_type": "GOV",
        //         "organization_category": "Hospital",
        //         "organization_name": "proyasis",
        //         "country": "QATAR",
        //         "city": "riyadh"
        //       },
        //       "specialization_totals": [
        //         {"specialization": "OT", "count": 10, "target_cv": 20},
        //         {"specialization": "GENERAL", "count": 100, "target_cv": 250}
        //       ],
        //       "total_vacancies": 110,
        //       "total_target_cv": 270
        //     }),
        //     id: '68764a2f4eadcf60814e94c5',
        //   ),
        //   // builder: (context, state) => CustomerJourneyScreen(),
        // ),
        // GoRoute(
        //   path: '/test', //test move to /
        //   builder: (context, state) => Scaffold(
        //     body: BookingDetailsScreen(
        //       // clientId: "",
        //       // clientName: "",
        //       bookingId: '6949325fdb98126c71bd6dbd',
        //     ),
        //   ),
        // ),
        GoRoute(
          path: '/test', //test move to /
          builder: (context, state) => Scaffold(
            body: BookingScreen(
              product: ProductModel.fromJson({
                "_id": "692ac813cdc77773395fbdf8",
                "product_id": "AEPID00001",
                "name": "Europe Holiday Packagess",
                "code": "EHP-2025",
                "category": null,
                "subCategory": "TOUR_PACKAGE",
                "requiresAgreement": true,
                "supportAvailable": true,
                "providerDetails": {
                  "name": "Global Travel Solutions",
                  "contact": "+91 9876543210",
                  "email": "info@globaltravel.com",
                  "address": "MG Road, Bangalore"
                },
                "status": "ACTIVE",
                "updated_at": "2025-12-18T16:51:01.865Z",
                "created_at": "2025-11-29T10:16:51.386Z",
                "advanceRequiredPercent": 30,
                "ageLimit": "18 - 60 years",
                "basePrice": 120000,
                "bhk": "3 BHK",
                "brand": "BMW",
                "city": "Bangalore",
                "costPrice": 100000,
                "country": "UAE",
                "countryOfStudy": "Canada",
                "courseDuration": "2 Years",
                "courseLevel": "MBBS",
                "description":
                    "A premium Europe holiday package covering 6 countries in 10 days.",
                "documentsRequired": [
                  {"docName": "Passport", "mandatory": true},
                  {"docName": "Pan Card", "mandatory": true},
                  {"docName": "Bank Statement (6 Months)", "mandatory": true}
                ],
                "duration": "10D/9N",
                "exclusions": [
                  "Lunch & Dinner",
                  "Personal expenses",
                  "Extra travel activities"
                ],
                "experienceRequired": "rrtty",
                "fuelType": "Diesel",
                "furnishingStatus": "Semi-Furnished",
                "images": [
                  "uploads/product_images/doc_product_692ac813cdc77773395fbdf8_1765992577545_ioe0q.webp"
                ],
                "inclusions": [
                  "Hotel stay",
                  "Breakfast",
                  "Airport transfers",
                  "Sightseeing",
                  "Travel insurance"
                ],
                "institutionName": "University of Toronto",
                "insuranceValidTill": "2026-05-20",
                "interviewPreparation": false,
                "isRefundable": true,
                "jobAssistance": false,
                "kmsDriven": "18,000 KM",
                "location": "Whitefield, Bangalore",
                "minIncomeRequired": "₹35,000 monthly",
                "model": "X5",
                "notes":
                    "Check Schengen visa availability depending on travel dates.",
                "possessionTime": "2026 Q2",
                "priceComponents": [
                  {
                    "title": "Service Fee",
                    "amount": 34554,
                    "gstPercent": 18,
                    "cgstPercent": 9,
                    "sgstPercent": 9
                  },
                  {
                    "title": "Processing Fee",
                    "amount": 354353,
                    "gstPercent": 12,
                    "cgstPercent": 6,
                    "sgstPercent": 6
                  }
                ],
                "processingTime": "7-14 working days",
                "propertyType": "Residential",
                "qualificationRequired": "rtrt",
                "refundPolicy":
                    "Full refund if cancelled 30 days before travel. 50% refund if cancelled within 15 days.",
                "registrationYear": "2022",
                "sellingPrice": 135000,
                "serviceMode": "HYBRID",
                "shortDescription": "Europe 10D/9N Holiday Package.",
                "size": "1500 sq ft",
                "state": "Karnataka",
                "stepList": [
                  "Enquiry Received",
                  "Package Selection",
                  "Document Submission",
                  "Visa Processing",
                  "Ticketing & Hotel Confirmation",
                  "Travel Start"
                ],
                "supportDuration": "6 Months",
                "tags": ["travel", "europe", "holiday", "international"],
                "termsAndConditions":
                    "Payment must be completed before travel date. Passport should be valid for at least 6 months.",
                "transmission": "Automatic",
                "travelType": "TOUR",
                "validity": "Valid for 6 months from date of purchase",
                "visaType": "Tourist Visa",
                "warrantyInfo": "Travel insurance covers major risks only.",
                "documents": [
                  {
                    "doc_type": "product_image",
                    "file_path":
                        "uploads/product_images/product_image_product_692ac813cdc77773395fbdf8_1765990280519_wzno5.webp",
                    "uploaded_at": "2025-12-17T16:51:21.046Z"
                  }
                ],
                "downpayment": 324,
                "loanEligibility": 454545,
                "productType": "3bhk",
                "discounts": []
              }),
            ),
          ),
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(),
      // initialLocation: '/dashboard/leads/lead',
      initialLocation: '/test',
    );
    // Initialize the navigation service with the router
    NavigationService.initialize(router);
    return GetMaterialApp.router(
      initialBinding: GlobalBindings(),
      // title: ' ${FlavourConfig.partnerName()} ',
      title: 'Alead',
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


//service type to get Intrested  in  dropdown

//leadSource for face ,

//courseType for course type Field of Study

//courses for Courses Interested