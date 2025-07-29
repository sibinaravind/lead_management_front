import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/controller/navigation_controller/navigation_controller.dart';
import 'package:overseas_front_end/core/services/user_cache_service.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'dart:io' show Platform;
import '../../../core/di/service_locator.dart';
import 'animated_drawer.dart';
import 'widget/appbar_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  final String mainTab;
  final String subTab;

  const MainLayoutScreen({
    super.key,
    required this.mainTab,
    required this.subTab,
  });

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late NavigationController navigationController;
  bool _isInitialized = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  OfficerModel? user;
  @override
  void initState() {
    super.initState();

    navigationController = Get.put(NavigationController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      navigationController.updateTab(widget.mainTab, widget.subTab);
      _isInitialized = true;
      user = serviceLocator<UserCacheService>().getUser();
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(MainLayoutScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.mainTab != oldWidget.mainTab ||
            widget.subTab != oldWidget.subTab) &&
        _isInitialized) {
      navigationController.updateTab(widget.mainTab, widget.subTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;
    final isWeb = identical(0, 0.0);
    final isMobile = !isWeb && (Platform.isAndroid || Platform.isIOS);

    return Scaffold(
      key: scaffoldKey,
      drawer: !isDesktop
          ? AnimatedDrawer(
              user: OfficerModel(
                id: user?.id ?? "1",
                officerId: user?.officerId ?? "",
                name: user?.name ?? "",
              ),
              ismobile: true,
            )
          : null,
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          if (isDesktop)
            AnimatedDrawer(
              user: OfficerModel(
                id: user?.id ?? "1",
                officerId: user?.officerId ?? "",
                name: user?.name ?? "",
              ),
            ),
          Expanded(
            child: Column(
              children: [
                AppBarContainer(
                  isdesktop: isDesktop,
                  user: OfficerModel(
                    id: "1",
                    officerId: "OFF123",
                    name: "John Doe",
                  ),
                  onDrawerButtonPressed: () =>
                      scaffoldKey.currentState?.openDrawer(),
                ),
                _getContentForRoute(widget.mainTab, widget.subTab),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildBottomNavigationBar() : null,
    );
  }

  Widget _buildBottomNavigationBar() {
    final navigationController = Get.find<NavigationController>();

    return Obx(() {
      final tabs = ['dashboard', 'leads', 'sales', 'analytics'];
      final subTabs = ['overview', 'overview', 'overview', 'overview'];
      final currentIndex =
          tabs.indexOf(navigationController.currentMainTab.value);

      return Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(4, (index) {
            final isSelected = currentIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  final newTab = tabs[index];
                  final newSubTab = subTabs[index];
                  navigationController.navigateTo(newTab, newSubTab);
                  context.go('/dashboard/$newTab/$newSubTab');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getIcon(index),
                          size: 22,
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        _getLabel(index),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard_rounded;
      case 1:
        return Icons.people_alt_rounded;
      case 2:
        return Icons.trending_up_rounded;
      case 3:
        return Icons.analytics_rounded;
      default:
        return Icons.dashboard_rounded;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Leads';
      case 2:
        return 'Sales';
      case 3:
        return 'Analytics';
      default:
        return 'Dashboard';
    }
  }

  Widget _getContentForRoute(String mainTab, String subTab) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;

    // Get the current navigation section
    final section = navigationController.navigationSections[mainTab];
    if (section == null) {
      return Center(child: Text('Tab $mainTab not found'));
    }

    // Find the matching navigation item
    NavigationItem? item;
    try {
      item = section.items.firstWhere((item) => item.route == subTab);
    } catch (e) {
      // If subTab not found, try to use the first item
      if (section.items.isNotEmpty) {
        item = section.items.first;
      }
    }

    if (item == null) {
      return Center(child: Text('No content available for $mainTab/$subTab'));
    }

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isDesktop ? 16 : 8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: item.screen,
      ),
    );
  }
}


// Widget _buildBottomNavigationBar() {
  //   final navigationController = Get.find<NavigationController>();

  //   return Obx(() {
  //     final tabs = ['dashboard', 'leads', 'sales', 'analytics'];
  //     final currentIndex =
  //         tabs.indexOf(navigationController.currentMainTab.value);

  //     return Container(
  //       decoration: BoxDecoration(
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.1),
  //             blurRadius: 10,
  //             spreadRadius: 2,
  //             offset: Offset(0, -2),
  //           ),
  //         ],
  //       ),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //         child: BottomNavigationBar(
  //           currentIndex: currentIndex,
  //           onTap: (index) {
  //             final newTab = tabs[index];
  //             navigationController.navigateTo(newTab, 'overview');
  //             context.go('/dashboard/$newTab/overview');
  //           },
  //           type: BottomNavigationBarType.fixed,
  //           backgroundColor: Colors.white,
  //           selectedItemColor: AppColors.primaryColor, // Use your primary color
  //           unselectedItemColor: Colors.grey[600],
  //           selectedLabelStyle: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 12,
  //           ),
  //           unselectedLabelStyle: TextStyle(
  //             fontWeight: FontWeight.w500,
  //             fontSize: 12,
  //           ),
  //           elevation: 10,
  //           items: [
  //             BottomNavigationBarItem(
  //               icon: _AnimatedNavIcon(
  //                 icon: Icons.dashboard_rounded,
  //                 isSelected: currentIndex == 0,
  //                 color: AppColors.primaryColor,
  //               ),
  //               label: 'Dashboard',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: _AnimatedNavIcon(
  //                 icon: Icons.people_alt_rounded,
  //                 isSelected: currentIndex == 1,
  //                 color: AppColors.primaryColor,
  //               ),
  //               label: 'Leads',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: _AnimatedNavIcon(
  //                 icon: Icons.trending_up_rounded,
  //                 isSelected: currentIndex == 2,
  //                 color: AppColors.primaryColor,
  //               ),
  //               label: 'Sales',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: _AnimatedNavIcon(
  //                 icon: Icons.analytics_rounded,
  //                 isSelected: currentIndex == 3,
  //                 color: AppColors.primaryColor,
  //               ),
  //               label: 'Analytics',
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }
// class _AnimatedNavIcon extends StatelessWidget {
//   final IconData icon;
//   final bool isSelected;
//   final Color color;

//   const _AnimatedNavIcon({
//     required this.icon,
//     required this.isSelected,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             padding: EdgeInsets.all(isSelected ? 8 : 6),
//             decoration: BoxDecoration(
//               color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               size: isSelected ? 24 : 22,
//               color: isSelected ? color : Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 4),
//           if (isSelected)
//             Container(
//               width: 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: color,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
