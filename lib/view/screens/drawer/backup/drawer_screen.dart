// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/controller/app_user_provider.dart';
// import 'package:overseas_front_end/model/officer/user_model.dart';
// import 'package:overseas_front_end/view/screens/config/config_screen.dart';
// import 'package:overseas_front_end/view/screens/drawer/widget/appbar_widget.dart';
// import 'package:overseas_front_end/view/screens/leads/lead_data_display.dart';
// import 'package:overseas_front_end/view/screens/project/project_data_display.dart';
// import 'package:overseas_front_end/view/screens/project/vacancy_data_display.dart';
// import 'package:overseas_front_end/view/screens/registration/register_data_display.dart';
// import 'package:overseas_front_end/view/screens/team_lead/team_lead_data_display.dart';
// import 'package:provider/provider.dart';
// import '../../../../res/style/colors/colors.dart';
// import '../../../controller/auth/login_controller.dart';
// import '../../../model/officer/officer_model.dart';
// import '../leads/dead_lead_data_display.dart';
// import '../project/client_display.dart';
// import '../campaign/campaign_screen.dart';
// import '../dashboard/dashbaord_screen.dart';
// import '../employee/employee_permission_screen.dart';
// import '../employee/round_robin_screen.dart';
// import '../officers/employee_data_display.dart';
// import 'custom_drawer.dart';

// class DrawerScreen extends StatefulWidget {
//   final String currentTab;
//   const DrawerScreen({super.key, required this.currentTab});
//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }

// class _DrawerScreenState extends State<DrawerScreen> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width > 1000;
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: Consumer2<AppUserProvider, LoginProvider>(
//         builder: (context, value, value2, child) => CustomDrawer(
//           ismobile: true,
//           user: value.userModel ?? UserModel(),
//           // officer: value2.officer ?? OfficerModel(),
//         ),
//       ),
//       floatingActionButton: Consumer<AppUserProvider>(
//         builder: (context, value, child) =>
//             LayoutBuilder(builder: (context, constraints) {
//           final isDesktop = constraints.maxWidth > 1000;
//           if (!isDesktop && value.selectedIndex == 2) {
//             return FloatingActionButton(
//                 backgroundColor: AppColors.primaryColor,
//                 child: const Text(
//                   "+",
//                   style:
//                       TextStyle(fontSize: 35, color: AppColors.whiteMainColor),
//                 ),
//                 onPressed: () {});
//           } else {
//             return const SizedBox.shrink();
//           }
//         }),
//       ),
//       backgroundColor: AppColors.backgroundColor,
//       // appBar: MediaQuery.of(context).size.width < 1000
//       //     ? AppBar(
//       //         centerTitle: true,
//       //         title: const CustomText(
//       //           text: "Affiniks",
//       //           color: AppColors.whiteMainColor,
//       //           fontWeight: FontWeight.w600,
//       //           fontSize: 20,
//       //         ),
//       //         backgroundColor: AppColors.primaryColor,
//       //       )
//       //     : null, // no appBar on desktop
//       // bottomNavigationBar: isDesktop
//       //     ? null
//       //     : Consumer<AppUserProvider>(
//       //         builder: (context, value, child) => BottomNavigationBar(
//       //           backgroundColor: AppColors.textGrayColour,
//       //           currentIndex: value.selectedIndex ?? 0,
//       //           selectedItemColor: AppColors.primaryColor,
//       //           unselectedItemColor: AppColors.textGrayColour,
//       //           onTap: (index) {
//       //             // setState(() {
//       //             value.selectedIndex = index;
//       //             // });
//       //           },
//       //           items: const [
//       //             BottomNavigationBarItem(
//       //               icon: Icon(Icons.dashboard),
//       //               label: 'Dashboard',
//       //             ),
//       //             BottomNavigationBarItem(
//       //               icon: Icon(Icons.call),
//       //               label: 'Call',
//       //             ),
//       //             BottomNavigationBarItem(
//       //               icon: Icon(Icons.people),
//       //               label: 'Client',
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final loginProvider = Provider.of<LoginProvider>(context);
//           final officer = loginProvider.officer;
//           final isDesktop = MediaQuery.of(context).size.width > 1000;
//           // return Container();
//           return isDesktop
//               ? Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Consumer<AppUserProvider>(
//                         builder: (context, value, child) => CustomDrawer(
//                               user: value.userModel ?? UserModel(),
//                               // officer: officer ?? OfficerModel(),
//                             )),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: AppColors.backgroundGraident,
//                         ),
//                         child: Column(
//                           children: [
//                             AppBarContainer(
//                               user: officer ?? OfficerModel(),
//                               isdesktop: isDesktop,
//                               onDrawerButtonPressed: () {
//                                 print("is desktop $isDesktop");
//                                 scaffoldKey.currentState?.openDrawer();
//                               },
//                             ),
//                             Expanded(
//                               child: Consumer<AppUserProvider>(
//                                   builder: (context, value, child) {
//                                 switch (value.selectedIndex) {
//                                   case 1:
//                                     return Expanded(child: LeadDataDisplay());
//                                   case 4:
//                                     return Expanded(
//                                         child: DeadLeadDataDisplay());
//                                   case 5:
//                                     return Expanded(
//                                         child: RegisterDataDisplay());
//                                   case 7:
//                                     return Expanded(
//                                         child: ProjectDataDisplay());
//                                   case 23:
//                                     return Expanded(
//                                         child: EmployeeDataDisplay());
//                                   case 37:
//                                     return Expanded(
//                                         child: AccessPermissionScreen());

//                                   case 39:
//                                     return Expanded(
//                                         child: TeamLeadDataDisplay());

//                                   case 38:
//                                     return Expanded(child: CampaignScreen());
//                                   case 36:
//                                     return Expanded(child: ConfigScreen());
//                                   case 31:
//                                     return Expanded(child: ClientDataDisplay());
//                                   case 40:
//                                     return Expanded(child: RoundRobinScreen());
//                                   case 35:
//                                     return Expanded(
//                                         child: VacancyDataDisplay());
//                                   default:
//                                     return Expanded(
//                                       child: DashboardScreen(),
//                                     );
//                                 }
//                               }),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : Container(
//                   decoration: BoxDecoration(
//                     gradient: AppColors.backgroundGraident,
//                   ),
//                   child: Column(
//                     children: [
//                       AppBarContainer(
//                         user: officer ?? OfficerModel(),
//                         isdesktop: isDesktop,
//                         onDrawerButtonPressed: () {
//                           scaffoldKey.currentState?.openDrawer();
//                         },
//                       ),
//                       Expanded(
//                         child: Consumer<AppUserProvider>(
//                             builder: (context, value, child) {
//                           switch (value.selectedIndex) {
//                             case 1:
//                               return Expanded(child: LeadDataDisplay());
//                             case 4:
//                               return Expanded(child: DeadLeadDataDisplay());
//                             case 5:
//                               return Expanded(child: RegisterDataDisplay());
//                             case 7:
//                               return Expanded(child: ProjectDataDisplay());
//                             case 23:
//                               return Expanded(child: EmployeeDataDisplay());
//                             case 37:
//                               return Expanded(child: AccessPermissionScreen());

//                             case 39:
//                               return Expanded(child: TeamLeadDataDisplay());

//                             case 38:
//                               return Expanded(child: CampaignScreen());
//                             case 36:
//                               return Expanded(child: ConfigScreen());
//                             case 31:
//                               return Expanded(child: ClientDataDisplay());
//                             case 35:
//                               return Expanded(child: VacancyDataDisplay());
//                             default:
//                               return Expanded(
//                                 child: DashboardScreen(),
//                               );
//                           }
//                         }),
//                       ),
//                     ],
//                   ),
//                 );
//         },
//       ),

//       // body: LayoutBuilder(
//       //     builder: (context, constraints) {
//       //       final isDesktop = MediaQuery.of(context).size.width > 1000;
//       //       // return Container();
//       //       return isDesktop
//       //           ? Row(
//       //               crossAxisAlignment: CrossAxisAlignment.start,
//       //               children: [
//       //                 Consumer<AppUserProvider>(
//       //                     builder: (context, value, child) =>
//       //                         CustomDrawer(user: value.userModel ?? UserModel())),
//       //                 Consumer<AppUserProvider>(
//       //                   builder: (context, value, child) => Expanded(
//       //                     child: value.selectedIndex == 36
//       //                         ? ConfigScreen()
//       //                         : value.selectedIndex == 37
//       //                             ? AccessPermissionScreen()
//       //                             : DashboardScreen(),
//       //                   ),
//       //                 ),
//       //               ],
//       //             )
//       //           : Container();
//       //     },
//       //   ),
//     );
//   }
// }
