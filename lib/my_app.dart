import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/flavour_config.dart';
import 'core/shared/app_routes.dart';
import 'view/features/drawer/drawer_screen.dart';

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' ${FlavourConfig.partnerName()} ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme:
            GoogleFonts.notoSansArmenianTextTheme(), //ptSansCaptionTextTheme
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => DrawerScreen(),
          // page: () => Scaffold(body: TransferDialogue()),
        ),
        // GetPage(
        //   name: AppRoutes.home,
        //   page: () => AddProjectVacancyScreen(),
        // ),
        // GetPage(
        //   name: AppRoutes.eligibleUserList,
        //   page: () => const EligibleUserList(),
        // ),
        // GetPage(
        //   name: AppRoutes.mobileUserList,
        //   page: () => const UserList(),
        // ),
        // GetPage(
        //   name: AppRoutes.resetPassword,
        //   page: () {
        //     final email = Get.parameters['email'] ?? '';
        //     final code = Get.parameters['code'] ?? '';
        //     return ResetPasswordScreen(email: email, code: code);
        //   },
        //   binding: ResetPasswordBinding(),
        // ),
        // GetPage(
        //   name: AppRoutes.officers,
        //   page: () => OfficersListScreen(
        //     officersListBloc:
        //         OfficersListBloc(getOfficersUseCase: GetOfficersUseCase()),
        //   ),
        // ),
        // GetPage(
        //   name: AppRoutes.officerDetails,
        //   page: () => OfficerDetailsScreen(
        //     officerDetailsBloc: Get.find(),
        //   ),
        //   binding: OfficerDetailsBinding(),
        // ),
      ],
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(child: Text('404 - Page not found')),
        ),
      ),
    );
  }
}



       // return Right(response.data['data']
        //     .map((json) => ConfigListModel.fromJson(json))
        //     .toList()); //for list 
        