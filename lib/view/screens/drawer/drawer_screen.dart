import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/view/screens/configuration/config_screen.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../model/models.dart';
import '../../../../res/style/colors/colors.dart';
import '../dashboard/dashbaord_screen.dart';
import '../employee/employee_permission_screen.dart';
import 'custom_drawer.dart';

class DrawerScreen extends StatefulWidget {
  // const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;
    // final drawerController = Get.find<AppUserController>();
    // final user = drawerController.getUserDetails();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: scaffoldKey,
      // drawer: CustomDrawer(
      //   ismobile: true,
      //   user: user,
      // ),
      floatingActionButton: Consumer<AppUserProvider>(
        builder: (context, value, child) =>
            LayoutBuilder(builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 1000;
          if (!isDesktop && value.selectedIndex == 2) {
            return FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                child: const Text(
                  "+",
                  style:
                      TextStyle(fontSize: 35, color: AppColors.whiteMainColor),
                ),
                onPressed: () {});
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
      backgroundColor: AppColors.backgroundColor,
      appBar: MediaQuery.of(context).size.width < 1000
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "Affiniks",
                color: AppColors.whiteMainColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              backgroundColor: AppColors.primaryColor,
            )
          : null, // no appBar on desktop
      bottomNavigationBar: isDesktop
          ? null
          : Consumer<AppUserProvider>(
              builder: (context, value, child) => BottomNavigationBar(
                backgroundColor: AppColors.textGrayColour,
                currentIndex: value.selectedIndex!,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.textGrayColour,
                onTap: (index) {
                  // setState(() {

                  value.selectedIndex = index;

                  // });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.call),
                    label: 'Call',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Client',
                  ),
                ],
              ),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = MediaQuery.of(context).size.width > 1000;
          // return Container();
          return isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AppUserProvider>(
                        builder: (context, value, child) =>
                            CustomDrawer(user: value.userModel ?? UserModel())),
                    Consumer<AppUserProvider>(
                      builder: (context, value, child) => Expanded(
                        child: value.selectedIndex == 36
                            ? ConfigScreen()
                            : value.selectedIndex == 37
                                ? AccessPermissionScreen()
                                : DashboardScreen(),
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }

  Widget _buildContentMobile(
      UserModel user, GlobalKey<ScaffoldState> key, bool isDesktop) {
    // final drawerController = Get.find<AppUserController>();

    return SizedBox(
      child: Column(
        children: [
          Consumer<AppUserProvider>(
            builder: (context, value, child) => Expanded(
                child: value.selectedIndex == 0
                    ? /* DashboardScreen() */ const Center(
                        child: Text("No tab selected"))
                    : value.selectedIndex == 1
                        ? /* CallLogDisplay() */ const Center(
                            child: Text("No tab selected"))
                        : value.selectedIndex == 2
                            ? /* ClientScreen() */ const Center(
                                child: Text("No tab selected"))
                            : const Center(child: Text("No tab selected"))),
          ),
        ],
      ),
    );
  }

  // Widget _buildContent(
  // UserModel user, GlobalKey<ScaffoldState> key, bool isDesktop) {
  // final drawerController = Get.find<AppUserController>();

  // return Container(
  //   decoration: BoxDecoration(
  //     gradient: AppColors.backgroundGraident,
  //   ),
  //   child: Column(
  //     children: [
  //       AppBarContainer(
  //         user: user,
  //         isdesktop: isDesktop,
  //         onDrawerButtonPressed: () => key.currentState?.openDrawer(),
  //       ),
  // Expanded(
  //   child: Obx(() {
  //     switch (drawerController.selectedIndex.value) {
  //       case 0:
  //         return DashboardScreen();
  //       case 0 || 1 || 2 || 3 || 4 || 32:
  //         return LeadDataDisplay();
  //       case 5 || 6:
  //         return RegisterDataDisplay();
  //       case 7 || 34:
  //         return ProjectDataDisplay();
  //       case 8:
  //         return InterviewDataDisplay();
  //       case 9 || 10 || 11 || 12 || 13 || 14 || 32:
  //         return ApplicationDataDisplay();
  //       case 15 || 16 || 17 || 18:
  //         return VisaDataDisplay();
  //       case 19:
  //         return TicketingDataDisplay();
  //       case 20 || 21 || 22:
  //         return DispatchedDataDisplay();
  //       case 23 || 24 || 25:
  //         return EmployeeDataDisplay();
  //       case 26 || 27 || 28 || 29:
  //         return LeadDataDisplay();
  //       case 30:
  //         return LeadDataDisplay();
  //       case 31:
  //         return ClientDataDisplay();
  //       // case 32:
  //       // return ApplicationPending();
  //       case 35:
  //         return CallLogDisplay();
  //       default:
  //         return const Center(child: Text("No tab selected"));
  //     }
  //   }),
  // ),
  // ],
  // ),
  // );
  // }
}
