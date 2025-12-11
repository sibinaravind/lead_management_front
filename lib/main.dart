import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_strategy/url_strategy.dart';
import 'config/flavour_config.dart';
import 'core/di/service_locator.dart';
import 'core/flavor/flavor_config.dart';
import 'core/services/native_call_handler.dart';
import 'my_app.dart';

Future<void> requestCallPermissions() async {
  if (!kIsWeb) {
    await [
      Permission.phone,
    ].request();
  }
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString("token");
  // final officerData = prefs.getString("officer");
  FlavorConfigration(
    name: Partner.travel, //
    color: Colors.blue,
    // variables: {
    //   "counter": 5,
    //   "baseUrl": "https://www.example.com",
    // },
  );
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  setPathUrlStrategy();
  await setupServiceLocator();
  await requestCallPermissions();
  if (!kIsWeb) {
    await NativeCallHandler.initPhoneCallListener();
  }
  runApp(MyApp(
      // isLoggedIn: token != null && officerData != null,
      ));
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final GoRouter router = GoRouter(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const HomeScreen(),
//         ),
//         // Single dashboard route that handles all tabs
//         GoRoute(
//           path: '/dashboard/:tab',
//           builder: (context, state) {
//             final tab = state.pathParameters['tab'] ?? 'overview';
//             return DashboardScreen(currentTab: tab);
//           },
//         ),
//         // Default dashboard route
//         GoRoute(
//           path: '/dashboard',
//           redirect: (context, state) => '/dashboard/overview',
//         ),
//       ],
//     );

//     return GetMaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerDelegate: router.routerDelegate,
//       routeInformationParser: router.routeInformationParser,
//       routeInformationProvider: router.routeInformationProvider,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//     );
//   }
// }

// // GetX Controller for managing tab state
// class DashboardController extends GetxController {
//   var selectedTabIndex = 0.obs;

//   final List<TabInfo> tabs = [
//     TabInfo(
//       id: 'overview',
//       title: 'Overview',
//       icon: Icons.dashboard_outlined,
//       selectedIcon: Icons.dashboard,
//     ),
//     TabInfo(
//       id: 'analytics',
//       title: 'Analytics',
//       icon: Icons.analytics_outlined,
//       selectedIcon: Icons.analytics,
//     ),
//     TabInfo(
//       id: 'users',
//       title: 'Users',
//       icon: Icons.people_outline,
//       selectedIcon: Icons.people,
//     ),
//     TabInfo(
//       id: 'settings',
//       title: 'Settings',
//       icon: Icons.settings_outlined,
//       selectedIcon: Icons.settings,
//     ),
//     TabInfo(
//       id: 'profile',
//       title: 'Profile',
//       icon: Icons.person_outline,
//       selectedIcon: Icons.person,
//     ),
//   ];

//   void selectTabByIndex(int index) {
//     selectedTabIndex.value = index;
//   }

//   void selectTabById(String tabId) {
//     final index = tabs.indexWhere((tab) => tab.id == tabId);
//     if (index != -1) {
//       selectedTabIndex.value = index;
//     }
//   }

//   String get currentTabId => tabs[selectedTabIndex.value].id;
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: Colors.blue.shade100,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to Multi-Tab Demo',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => context.go('/dashboard/overview'),
//               child: const Text('Go to Dashboard'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () => context.go('/dashboard/profile'),
//               child: const Text('Go to Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardScreen extends StatefulWidget {
//   final String currentTab;

//   const DashboardScreen({super.key, required this.currentTab});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   late DashboardController controller;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controller and set current tab
//     controller = Get.put(DashboardController());
//     controller.selectTabById(widget.currentTab);
//   }

//   @override
//   void didUpdateWidget(DashboardScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update tab when URL changes
//     if (widget.currentTab != oldWidget.currentTab) {
//       controller.selectTabById(widget.currentTab);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         backgroundColor: Colors.blue.shade100,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.home),
//             onPressed: () => context.go('/'),
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//           // Left Side Navigation
//           Container(
//             width: 280,
//             color: Colors.grey.shade50,
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   width: double.infinity,
//                   color: Colors.blue.shade50,
//                   child: const Text(
//                     'Navigation',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.tabs.length,
//                     itemBuilder: (context, index) {
//                       final tab = controller.tabs[index];
//                       final isSelected =
//                           controller.selectedTabIndex.value == index;

//                       return Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 2),
//                         child: ListTile(
//                           leading: Icon(
//                             isSelected ? tab.selectedIcon : tab.icon,
//                             color:
//                                 isSelected ? Colors.blue : Colors.grey.shade600,
//                           ),
//                           title: Text(
//                             tab.title,
//                             style: TextStyle(
//                               color: isSelected
//                                   ? Colors.blue
//                                   : Colors.grey.shade800,
//                               fontWeight: isSelected
//                                   ? FontWeight.w600
//                                   : FontWeight.normal,
//                             ),
//                           ),
//                           selected: isSelected,
//                           selectedTileColor: Colors.blue.shade100,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           onTap: () {
//                             // Update URL and let GoRouter handle the navigation
//                             context.go('/dashboard/${tab.id}');
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Vertical Divider
//           const VerticalDivider(thickness: 1, width: 1),

//           // Main Content Area
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               child: Obx(() {
//                 return _getTabContent(controller.selectedTabIndex.value);
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getTabContent(int index) {
//     switch (index) {
//       case 0:
//         return const OverviewTab();
//       case 1:
//         return const AnalyticsTab();
//       case 2:
//         return const UsersTab();
//       case 3:
//         return const SettingsTab();
//       case 4:
//         return const ProfileTab();
//       default:
//         return const OverviewTab();
//     }
//   }

//   @override
//   void dispose() {
//     Get.delete<DashboardController>();
//     super.dispose();
//   }
// }

// class TabInfo {
//   final String id;
//   final String title;
//   final IconData icon;
//   final IconData selectedIcon;

//   TabInfo({
//     required this.id,
//     required this.title,
//     required this.icon,
//     required this.selectedIcon,
//   });
// }

// // Tab Content Widgets
// class OverviewTab extends StatelessWidget {
//   const OverviewTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Overview Dashboard',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             children: [
//               _buildStatCard('Total Users', '1,234', Icons.people, Colors.blue),
//               _buildStatCard(
//                   'Revenue', '\$12,345', Icons.attach_money, Colors.green),
//               _buildStatCard(
//                   'Orders', '567', Icons.shopping_cart, Colors.orange),
//               _buildStatCard(
//                   'Growth', '+12%', Icons.trending_up, Colors.purple),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(
//       String title, String value, IconData icon, Color color) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 48, color: color),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnalyticsTab extends StatelessWidget {
//   const AnalyticsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Analytics Dashboard',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: ListView(
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Monthly Performance',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16),
//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'Chart Placeholder',
//                             style: TextStyle(fontSize: 18, color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UsersTab extends StatelessWidget {
//   const UsersTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Users Management',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.blue.shade100,
//                     child: Text('U${index + 1}'),
//                   ),
//                   title: Text('User ${index + 1}'),
//                   subtitle: Text('user${index + 1}@example.com'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.more_vert),
//                     onPressed: () {},
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SettingsTab extends StatelessWidget {
//   const SettingsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Settings',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: ListView(
//             children: [
//               _buildSettingItem('Notifications',
//                   'Manage notification preferences', Icons.notifications),
//               _buildSettingItem('Privacy', 'Privacy and security settings',
//                   Icons.privacy_tip),
//               _buildSettingItem(
//                   'Account', 'Account management', Icons.account_circle),
//               _buildSettingItem(
//                   'Appearance', 'Theme and display settings', Icons.palette),
//               _buildSettingItem('Data', 'Data and storage', Icons.storage),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSettingItem(String title, String subtitle, IconData icon) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.blue),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {},
//       ),
//     );
//   }
// }

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'User Profile',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.person, size: 60, color: Colors.white),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'John Doe',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   'john.doe@example.com',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 32),
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Profile Information',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 16),
//                         _buildProfileField('Name', 'John Doe'),
//                         _buildProfileField('Email', 'john.doe@example.com'),
//                         _buildProfileField('Phone', '+1 234 567 8900'),
//                         _buildProfileField('Department', 'Engineering'),
//                         _buildProfileField('Role', 'Senior Developer'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProfileField(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               '$label:',
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';

// // App Colors
// class AppColors {
//   static const Color iconWhiteColour = Color(0xFFE2E8F0);
//   static const Color textWhiteColour = Color(0xFFF8FAFC);
//   static const Color blueSecondaryColor = Color(0xFF3B82F6);
//   static const Color violetPrimaryColor = Color(0xFF8B5CF6);
//   static const Color greenPrimaryColor = Color(0xFF10B981);
//   static const Color orangePrimaryColor = Color(0xFFF59E0B);
//   static const Color redPrimaryColor = Color(0xFFEF4444);
// }

// // Custom Text Widget
// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color color;
//   final FontWeight fontWeight;

//   const CustomText({
//     Key? key,
//     required this.text,
//     this.fontSize = 14,
//     this.color = Colors.black,
//     this.fontWeight = FontWeight.normal,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }

// // User Model
// class UserModel {
//   final String name;
//   final String email;

//   UserModel({required this.name, required this.email});
// }

// // Navigation Controller with GoRouter integration
// class NavigationController extends GetxController {
//   var currentRoute = '/'.obs;
//   var selectedTabIndex = 0.obs;

//   final List<NavigationSection> navigationSections = [
//     NavigationSection(
//       title: 'Dashboard',
//       icon: Icons.dashboard_rounded,
//       color: AppColors.blueSecondaryColor,
//       items: [
//         NavigationItem(
//           label: 'Overview',
//           route: '/dashboard/overview',
//           icon: Icons.analytics_outlined,
//         ),
//         NavigationItem(
//           label: 'Statistics',
//           route: '/dashboard/statistics',
//           icon: Icons.bar_chart_rounded,
//         ),
//         NavigationItem(
//           label: 'Reports',
//           route: '/dashboard/reports',
//           icon: Icons.report_outlined,
//         ),
//       ],
//     ),
//     NavigationSection(
//       title: 'Leads',
//       icon: Icons.people_rounded,
//       color: AppColors.violetPrimaryColor,
//       items: [
//         NavigationItem(
//           label: 'All Leads',
//           route: '/leads/all',
//           icon: Icons.follow_the_signs_rounded,
//         ),
//         NavigationItem(
//           label: 'CRE Followup',
//           route: '/leads/followup',
//           icon: Icons.mark_email_read_rounded,
//         ),
//         NavigationItem(
//           label: 'Dead Leads',
//           route: '/leads/dead',
//           icon: Icons.remove_circle_rounded,
//         ),
//       ],
//     ),
//     NavigationSection(
//       title: 'Sales',
//       icon: Icons.trending_up_rounded,
//       color: AppColors.greenPrimaryColor,
//       items: [
//         NavigationItem(
//           label: 'Opportunities',
//           route: '/sales/opportunities',
//           icon: Icons.business_center_rounded,
//         ),
//         NavigationItem(
//           label: 'Quotes',
//           route: '/sales/quotes',
//           icon: Icons.receipt_long_rounded,
//         ),
//         NavigationItem(
//           label: 'Deals',
//           route: '/sales/deals',
//           icon: Icons.handshake_rounded,
//         ),
//       ],
//     ),
//     NavigationSection(
//       title: 'Analytics',
//       icon: Icons.analytics_rounded,
//       color: AppColors.orangePrimaryColor,
//       items: [
//         NavigationItem(
//           label: 'Performance',
//           route: '/analytics/performance',
//           icon: Icons.speed_rounded,
//         ),
//         NavigationItem(
//           label: 'Metrics',
//           route: '/analytics/metrics',
//           icon: Icons.timeline_rounded,
//         ),
//         NavigationItem(
//           label: 'Insights',
//           route: '/analytics/insights',
//           icon: Icons.insights_rounded,
//         ),
//       ],
//     ),
//   ];

//   void updateRoute(String route) {
//     currentRoute.value = route;
//   }

//   bool isRouteSelected(String route) {
//     return currentRoute.value == route;
//   }
// }

// // Navigation Models
// class NavigationItem {
//   final String label;
//   final String route;
//   final IconData icon;

//   NavigationItem({
//     required this.label,
//     required this.route,
//     required this.icon,
//   });
// }

// class NavigationSection {
//   final String title;
//   final IconData icon;
//   final Color color;
//   final List<NavigationItem> items;

//   NavigationSection({
//     required this.title,
//     required this.icon,
//     required this.color,
//     required this.items,
//   });
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final GoRouter router = GoRouter(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const HomeScreen(),
//         ),
//         GoRoute(
//           path: '/dashboard/:tab',
//           builder: (context, state) {
//             final tab = state.pathParameters['tab'] ?? 'overview';
//             return MainLayoutScreen(currentRoute: '/dashboard/$tab');
//           },
//         ),
//         GoRoute(
//           path: '/leads/:tab',
//           builder: (context, state) {
//             final tab = state.pathParameters['tab'] ?? 'all';
//             return MainLayoutScreen(currentRoute: '/leads/$tab');
//           },
//         ),
//         GoRoute(
//           path: '/sales/:tab',
//           builder: (context, state) {
//             final tab = state.pathParameters['tab'] ?? 'opportunities';
//             return MainLayoutScreen(currentRoute: '/sales/$tab');
//           },
//         ),
//         GoRoute(
//           path: '/analytics/:tab',
//           builder: (context, state) {
//             final tab = state.pathParameters['tab'] ?? 'performance';
//             return MainLayoutScreen(currentRoute: '/analytics/$tab');
//           },
//         ),
//       ],
//     );

//     return GetMaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerDelegate: router.routerDelegate,
//       routeInformationParser: router.routeInformationParser,
//       routeInformationProvider: router.routeInformationProvider,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F172A),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to CRM Dashboard',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textWhiteColour,
//               ),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () => context.go('/dashboard/overview'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.blueSecondaryColor,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               ),
//               child: const Text(
//                 'Enter Dashboard',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MainLayoutScreen extends StatefulWidget {
//   final String currentRoute;

//   const MainLayoutScreen({super.key, required this.currentRoute});

//   @override
//   State<MainLayoutScreen> createState() => _MainLayoutScreenState();
// }

// class _MainLayoutScreenState extends State<MainLayoutScreen> {
//   late NavigationController navigationController;

//   @override
//   void initState() {
//     super.initState();
//     navigationController = Get.put(NavigationController());
//     navigationController.updateRoute(widget.currentRoute);
//   }

//   @override
//   void didUpdateWidget(MainLayoutScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.currentRoute != oldWidget.currentRoute) {
//       navigationController.updateRoute(widget.currentRoute);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: Row(
//         children: [
//           AnimatedDrawer(
//             user: UserModel(
//               name: "John Doe",
//               email: "john.doe@example.com",
//             ),
//           ),
//           Expanded(
//             child: _getContentForRoute(widget.currentRoute),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getContentForRoute(String route) {
//     // Extract the main section and subsection from route
//     final parts = route.split('/');
//     if (parts.length >= 3) {
//       final section = parts[1];
//       final subsection = parts[2];

//       return Container(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () => context.go('/'),
//                   icon: const Icon(Icons.home, color: Color(0xFF64748B)),
//                 ),
//                 const SizedBox(width: 16),
//                 Text(
//                   '${section.toUpperCase()} / ${subsection.toUpperCase()}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF64748B),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             Text(
//               '${_capitalize(section)} ${_capitalize(subsection)}',
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1E293B),
//               ),
//             ),
//             const SizedBox(height: 32),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         _getIconForRoute(route),
//                         size: 64,
//                         color: AppColors.blueSecondaryColor.withOpacity(0.3),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Content for ${_capitalize(section)} ${_capitalize(subsection)}',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF475569),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Route: $route',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF94A3B8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return const Center(
//       child: Text('Page not found'),
//     );
//   }

//   String _capitalize(String text) {
//     return text[0].toUpperCase() + text.substring(1);
//   }

//   IconData _getIconForRoute(String route) {
//     if (route.contains('dashboard')) return Icons.dashboard;
//     if (route.contains('leads')) return Icons.people;
//     if (route.contains('sales')) return Icons.trending_up;
//     if (route.contains('analytics')) return Icons.analytics;
//     return Icons.help_outline;
//   }
// }

// class AnimatedDrawer extends StatefulWidget {
//   final UserModel user;
//   final bool ismobile;

//   const AnimatedDrawer({
//     super.key,
//     required this.user,
//     this.ismobile = false,
//   });

//   @override
//   State<AnimatedDrawer> createState() => _AnimatedDrawerState();
// }

// class _AnimatedDrawerState extends State<AnimatedDrawer>
//     with TickerProviderStateMixin {
//   late NavigationController navigationController;
//   late AnimationController _slideController;
//   late AnimationController _fadeController;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   final ScrollController _controller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     navigationController = Get.find<NavigationController>();

//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(-0.3, 0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutCubic,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));

//     _slideController.forward();
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _slideController.dispose();
//     _fadeController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _fadeAnimation,
//       builder: (context, child) {
//         return FadeTransition(
//           opacity: _fadeAnimation,
//           child: SlideTransition(
//             position: _slideAnimation,
//             child: Container(
//               width: widget.ismobile ? double.infinity : 300,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF1E293B),
//                     Color(0xFF0F172A),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: const Offset(2, 0),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildHeader(),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Scrollbar(
//                         controller: _controller,
//                         child: ListView.builder(
//                           controller: _controller,
//                           itemCount:
//                               navigationController.navigationSections.length,
//                           itemBuilder: (context, index) {
//                             return _buildAnimatedExpansionTile(
//                               section: navigationController
//                                   .navigationSections[index],
//                               delay: index * 100.0,
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   _buildFooter(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF374151),
//             Color(0xFF1F2937),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           CircleAvatar(
//             radius: 35,
//             backgroundColor: AppColors.blueSecondaryColor.withOpacity(0.2),
//             child: const Icon(
//               Icons.person_rounded,
//               size: 35,
//               color: AppColors.blueSecondaryColor,
//             ),
//           ),
//           const SizedBox(height: 16),
//           CustomText(
//             text: widget.user.name,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textWhiteColour,
//           ),
//           const SizedBox(height: 4),
//           CustomText(
//             text: widget.user.email,
//             fontSize: 14,
//             color: AppColors.textWhiteColour.withOpacity(0.7),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: AppColors.iconWhiteColour.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//       ),
//       child: InkWell(
//         onTap: () => context.go('/'),
//         borderRadius: BorderRadius.circular(8),
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.logout_rounded,
//                 color: AppColors.redPrimaryColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 12),
//               CustomText(
//                 text: 'Logout',
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.redPrimaryColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedExpansionTile({
//     required NavigationSection section,
//     required double delay,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 400 + delay.toInt()),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(0, 20 * (1 - value)),
//           child: Opacity(
//             opacity: value,
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: const Color(0xFF475569),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   dividerColor: Colors.transparent,
//                   expansionTileTheme: ExpansionTileThemeData(
//                     backgroundColor: Colors.transparent.withOpacity(0.1),
//                     collapsedBackgroundColor:
//                         Colors.transparent.withOpacity(0.1),
//                     iconColor: AppColors.iconWhiteColour,
//                     collapsedIconColor: AppColors.iconWhiteColour.withAlpha(90),
//                     textColor: AppColors.iconWhiteColour.withAlpha(90),
//                     collapsedTextColor: AppColors.iconWhiteColour.withAlpha(90),
//                     tilePadding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 8,
//                     ),
//                     childrenPadding: const EdgeInsets.only(
//                       left: 20,
//                       right: 20,
//                       bottom: 12,
//                     ),
//                   ),
//                 ),
//                 child: ExpansionTile(
//                   leading: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           section.color.withOpacity(0.2),
//                           section.color.withOpacity(0.1),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: section.color.withOpacity(0.3),
//                         width: 1,
//                       ),
//                     ),
//                     child: Icon(
//                       section.icon,
//                       size: 20,
//                       color: section.color,
//                     ),
//                   ),
//                   title: CustomText(
//                     text: section.title,
//                     fontSize: 15,
//                     color: AppColors.textWhiteColour,
//                   ),
//                   children: section.items.asMap().entries.map((itemEntry) {
//                     int itemIndex = itemEntry.key;
//                     NavigationItem item = itemEntry.value;
//                     return _buildAnimatedDrawerTile(
//                       item: item,
//                       color: section.color,
//                       delay: itemIndex * 25.0,
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedDrawerTile({
//     required NavigationItem item,
//     required Color color,
//     required double delay,
//   }) {
//     return Obx(() {
//       final isSelected = navigationController.isRouteSelected(item.route);

//       return TweenAnimationBuilder<double>(
//         duration: Duration(milliseconds: 300 + delay.toInt()),
//         tween: Tween(begin: 0.0, end: 1.0),
//         curve: Curves.easeOutCubic,
//         builder: (context, value, child) {
//           return Transform.translate(
//             offset: Offset(20 * (1 - value), 0),
//             child: Opacity(
//               opacity: value,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   gradient: isSelected
//                       ? LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: [
//                             color.withOpacity(0.15),
//                             color.withOpacity(0.05),
//                           ],
//                         )
//                       : null,
//                   border: isSelected
//                       ? Border.all(
//                           color: color.withOpacity(0.4),
//                           width: 1.5,
//                         )
//                       : null,
//                   boxShadow: isSelected
//                       ? [
//                           BoxShadow(
//                             color: color.withOpacity(0.2),
//                             blurRadius: 12,
//                             offset: const Offset(0, 4),
//                           ),
//                         ]
//                       : null,
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     splashColor: color.withOpacity(0.1),
//                     highlightColor: color.withOpacity(0.05),
//                     onTap: () {
//                       context.go(item.route);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 14,
//                       ),
//                       child: Row(
//                         children: [
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 200),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? color.withOpacity(0.15)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               item.icon,
//                               size: 16,
//                               color: isSelected
//                                   ? color
//                                   : const Color.fromARGB(255, 196, 207, 225),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: CustomText(
//                               text: item.label,
//                               fontSize: 13,
//                               fontWeight: isSelected
//                                   ? FontWeight.w600
//                                   : FontWeight.w500,
//                               color: isSelected
//                                   ? AppColors.textWhiteColour.withOpacity(0.9)
//                                   : AppColors.textWhiteColour.withOpacity(0.6),
//                             ),
//                           ),
//                           if (isSelected)
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: color.withOpacity(0.6),
//                                     blurRadius: 6,
//                                     spreadRadius: 1,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
