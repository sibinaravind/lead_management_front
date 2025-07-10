import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/view/screens/config/config_screen.dart';
import 'package:overseas_front_end/view/screens/drawer/widget/appbar_widget.dart';
import 'package:overseas_front_end/view/screens/team_lead/team_lead_data_display.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../model/models.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../controller/auth/login_controller.dart';
import '../Project/client_display.dart';
import '../campaign/campaign_screen.dart';
import '../dashboard/dashbaord_screen.dart';
import '../employee/employee_permission_screen.dart';
import '../officers/employee_data_display.dart';
import 'custom_drawer.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).loadFromPreferences();

    Future.delayed(Duration.zero, () {
      Provider.of<ConfigProvider>(context, listen: false).getConfigList();
      Provider.of<OfficersControllerProvider>(context, listen: false)
          .fetchOfficersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;

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
          final loginProvider = Provider.of<LoginProvider>(context);
          final officer = loginProvider.officer;
          final isDesktop = MediaQuery.of(context).size.width > 1000;
          // return Container();
          return isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AppUserProvider>(
                        builder: (context, value, child) =>
                            CustomDrawer(user: value.userModel ?? UserModel(), officer: officer!,)),


                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.backgroundGraident,
                        ),
                        child: Column(
                          children: [
                            AppBarContainer(
                              user: officer!,
                              isdesktop: isDesktop,
                              onDrawerButtonPressed: () => scaffoldKey.currentState?.openDrawer(),
                            ),
                            Expanded(
                              child: Consumer<AppUserProvider>(builder: (context, value, child) {
                                switch (value.selectedIndex) {
                                  case 23:
                                    return Expanded(child: EmployeeDataDisplay());
                                  case 37:
                                    return Expanded(child: AccessPermissionScreen());

                                  case 39:
                                    return Expanded(child: TeamLeadDataDisplay());

                                  case 38:
                                    return Expanded(child: CampaignScreen());
                                  case 36:
                                    return Expanded(child: ConfigScreen());
                                    case 31:
                                    return Expanded(child: ClientDataDisplay());
                                  default:
                                    return Expanded(
                                      child: DashboardScreen(),
                                    );
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),

      // body: LayoutBuilder(
      //     builder: (context, constraints) {
      //       final isDesktop = MediaQuery.of(context).size.width > 1000;
      //       // return Container();
      //       return isDesktop
      //           ? Row(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Consumer<AppUserProvider>(
      //                     builder: (context, value, child) =>
      //                         CustomDrawer(user: value.userModel ?? UserModel())),
      //                 Consumer<AppUserProvider>(
      //                   builder: (context, value, child) => Expanded(
      //                     child: value.selectedIndex == 36
      //                         ? ConfigScreen()
      //                         : value.selectedIndex == 37
      //                             ? AccessPermissionScreen()
      //                             : DashboardScreen(),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           : Container();
      //     },
      //   ),
    );
  }
}
