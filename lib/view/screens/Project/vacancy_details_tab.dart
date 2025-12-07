// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/project/project_controller.dart';
// import 'package:overseas_front_end/model/project/vacancy_model.dart';
// import 'package:overseas_front_end/view/screens/project/tabs/matching_tab.dart';
// import 'package:overseas_front_end/view/screens/project/tabs/short_list_tab.dart';
// import '../../../utils/style/colors/colors.dart';
// import '../../widgets/custom_info_chip.dart';
// import '../../widgets/custom_text.dart';
// import 'tabs/client_tab.dart';
// import 'tabs/project_tab.dart';

// class VacancyDetailTab extends StatefulWidget {
//   final VacancyModel vacancy;
//   final String id;

//   const VacancyDetailTab({
//     super.key,
//     required this.vacancy,
//     required this.id,
//   });

//   @override
//   State<VacancyDetailTab> createState() => _VacancyDetailTabState();
// }

// class _VacancyDetailTabState extends State<VacancyDetailTab> {
//   int _selectedTabIndex = 0;
//   final _projectController = Get.find<ProjectController>();

//   late List<Map<String, dynamic>> _tabs = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabs = [
//       {
//         'icon': Icons.assessment,
//         'label': 'Project',
//         'widget': ProjectTab(data: widget.vacancy),
//         'completed': true,
//       },
//       {
//         'icon': Icons.account_tree,
//         'label': 'Client',
//         'widget': ClientTab(id: widget.id),
//         'completed': true,
//       },
//       {
//         'icon': Icons.account_box,
//         'label': 'Matching',
//         'widget': MatchingTab(
//           qualification: widget.vacancy.qualifications?[0],
//           country: widget.vacancy.country,
//         ),
//         'completed': false,
//       },
//       {
//         'icon': Icons.list,
//         'label': 'Shortlist',
//         'widget': ShortListedtab(),
//         'completed': false,
//       },
//     ];
//   }

//   bool get _isMobile => MediaQuery.of(context).size.width < 768;
//   bool get _isTablet =>
//       MediaQuery.of(context).size.width >= 768 &&
//       MediaQuery.of(context).size.width < 1024;
//   bool get _isDesktop => MediaQuery.of(context).size.width >= 1024;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Dialog(
//       insetPadding: EdgeInsets.all(_isMobile ? 8 : 16),
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: _isMobile ? screenSize.width * 0.98 : screenSize.width * 0.95,
//         height: _isMobile ? screenSize.height * 0.98 : screenSize.height * 0.95,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(_isMobile ? 12 : 20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             _buildHeader(context),
//             _buildVacancyInfoCard(),
//             Expanded(
//               child: _isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primaryColor,
//             AppColors.primaryColor.withOpacity(0.8)
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(_isMobile ? 12 : 20),
//           topRight: Radius.circular(_isMobile ? 12 : 20),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: _isMobile ? 16 : 24, vertical: _isMobile ? 12 : 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(Icons.work_outline,
//                       color: Colors.white, size: _isMobile ? 20 : 24),
//                 ),
//                 SizedBox(width: _isMobile ? 8 : 12),
//                 CustomText(
//                   text: 'Vacancy Details',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//             IconButton(
//               icon: Icon(Icons.close_rounded,
//                   color: Colors.white, size: _isMobile ? 24 : 28),
//               onPressed: () => Navigator.of(context).pop(),
//               style: IconButton.styleFrom(
//                 backgroundColor: Colors.white.withOpacity(0.2),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVacancyInfoCard() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(_isMobile ? 16 : 24),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primaryColor.withOpacity(0.1),
//             AppColors.primaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         border: Border(
//           bottom: BorderSide(
//             color: AppColors.iconWhiteColour.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(_isMobile ? 12 : 16),
//             decoration: BoxDecoration(
//               gradient: AppColors.buttonGraidentColour,
//               borderRadius: BorderRadius.circular(_isMobile ? 12 : 16),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primaryColor.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Icon(Icons.work_rounded, color: Colors.white, size: 24),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(
//                   text:
//                       widget.vacancy.project?.projectName ?? 'Unknown Project',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//                 const SizedBox(height: 8),
//                 Wrap(
//                   children: [
//                     const SizedBox(width: 8),
//                     CustomInfoChip(
//                       icon: Icons.work_outline,
//                       text: '${widget.vacancy.jobCategory}',
//                       color: AppColors.orangeSecondaryColor,
//                     ),
//                     const SizedBox(width: 8),
//                     if (widget.vacancy.lastDateToApply != null) ...[
//                       CustomInfoChip(
//                         icon: Icons.access_time_rounded,
//                         text: 'Deadline: ${widget.vacancy.lastDateToApply}',
//                         color: AppColors.redSecondaryColor,
//                       ),
//                     ],
//                     const SizedBox(width: 8),
//                     CustomInfoChip(
//                       icon: Icons.work_outline,
//                       text: 'Vacancies: ${widget.vacancy.totalVacancies}',
//                       color: AppColors.greenSecondaryColor,
//                     ),
//                     const SizedBox(width: 8),
//                     CustomInfoChip(
//                       icon: Icons.work_outline,
//                       text: 'Target: ${widget.vacancy.totalTargetCv}',
//                       color: AppColors.orangeSecondaryColor,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileLayout() {
//     return Column(
//       children: [
//         // Mobile Tab Bar
//         Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             border: Border(
//               bottom: BorderSide(
//                 color: AppColors.iconWhiteColour.withOpacity(0.3),
//               ),
//             ),
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemCount: _tabs.length,
//             itemBuilder: (context, index) {
//               final tab = _tabs[index];
//               final isSelected = _selectedTabIndex == index;

//               return GestureDetector(
//                 onTap: () => setState(() => _selectedTabIndex = index),
//                 child: Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     gradient:
//                         isSelected ? AppColors.buttonGraidentColour : null,
//                     color: isSelected ? null : Colors.transparent,
//                     borderRadius: BorderRadius.circular(25),
//                     border: isSelected
//                         ? null
//                         : Border.all(color: AppColors.iconWhiteColour),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         tab['icon'] as IconData,
//                         color:
//                             isSelected ? Colors.white : AppColors.primaryColor,
//                         size: 18,
//                       ),
//                       const SizedBox(width: 8),
//                       CustomText(
//                         text: tab['label'] as String,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color:
//                             isSelected ? Colors.white : AppColors.primaryColor,
//                       ),
//                       if (tab['completed'] as bool) ...[
//                         const SizedBox(width: 6),
//                         Icon(
//                           Icons.check_circle_rounded,
//                           color: isSelected
//                               ? Colors.white
//                               : AppColors.greenSecondaryColor,
//                           size: 16,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         // Mobile Content
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: _tabs[_selectedTabIndex]['widget'] as Widget,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDesktopLayout() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(_isMobile ? 12 : 20),
//           bottomRight: Radius.circular(_isMobile ? 12 : 20),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Desktop Sidebar
//           Container(
//             width: 240,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.primaryColor,
//                   AppColors.primaryColor.withOpacity(0.9),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(_isMobile ? 12 : 20),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(_isTablet ? 16 : 20),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.tab_rounded,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       SizedBox(width: _isTablet ? 8 : 12),
//                       CustomText(
//                         text: 'Navigation',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     itemCount: _tabs.length,
//                     itemBuilder: (context, index) {
//                       final tab = _tabs[index];
//                       final isSelected = _selectedTabIndex == index;

//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         decoration: BoxDecoration(
//                           gradient: isSelected
//                               ? AppColors.buttonGraidentColour
//                               : null,
//                           color: isSelected ? null : Colors.transparent,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 4,
//                           ),
//                           leading: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? Colors.white.withOpacity(0.2)
//                                   : Colors.white.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               tab['icon'] as IconData,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                           ),
//                           title: CustomText(
//                             text: tab['label'] as String,
//                             fontSize: 14,
//                             fontWeight:
//                                 isSelected ? FontWeight.w600 : FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                           trailing: tab['completed'] as bool
//                               ? Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Icon(
//                                     Icons.check_rounded,
//                                     color: Colors.white,
//                                     size: 16,
//                                   ),
//                                 )
//                               : Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white.withOpacity(0.3),
//                                     ),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Icon(
//                                     Icons.radio_button_unchecked_rounded,
//                                     color: Colors.white.withOpacity(0.6),
//                                     size: 16,
//                                   ),
//                                 ),
//                           onTap: () =>
//                               setState(() => _selectedTabIndex = index),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Desktop Content
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               child: _tabs[_selectedTabIndex]['widget'] as Widget,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:overseas_front_end/controller/project/project_controller.dart';
// // import 'package:overseas_front_end/model/project/vacancy_model.dart';
// // import 'package:overseas_front_end/view/screens/Project/widget/tabs/matching_tab.dart';
// // import 'package:overseas_front_end/view/screens/Project/widget/tabs/short_list_tab.dart';
// // import '../../../../utils/style/colors/colors.dart';
// // import '../../../widgets/custom_text.dart';
// // import 'tabs/client_tab.dart';
// // import 'tabs/project_tab.dart';

// // class VacancyDetailTab extends StatefulWidget {
// //   final VacancyModel vacancy;
// //   final String id;
// //   const VacancyDetailTab({
// //     super.key,
// //     required this.vacancy,
// //     required this.id,
// //   });

// //   @override
// //   State<VacancyDetailTab> createState() => _ProjectDetailsTabState();
// //   // final ProjectModel? project;
// // }

// // class _ProjectDetailsTabState extends State<VacancyDetailTab> {
// //   int _selectedTabIndex = 0;
// //   final _projectController = Get.find<ProjectController>();

// //   late List<Map<String, dynamic>> _tabs = [];

// //   @override
// //   void initState() {
// //     _tabs = [
// //       {
// //         'icon': Icons.assessment,
// //         'label': 'Project',
// //         'widget': ProjectTab(
// //           project: widget.vacancy.project,
// //         ),
// //         'completed': true,
// //       },
// //       {
// //         'icon': Icons.account_tree,
// //         'label': 'Client',
// //         'widget': ClientTab(
// //           id: widget.id,
// //         ),
// //         // 'widget':  ClientDashboard(),
// //         'completed': true,
// //       },
// //       {
// //         'icon': Icons.account_box,
// //         'label': 'Matching',
// //         'widget': MatchingTab(),
// //         'completed': false,
// //       },
// //       {
// //         'icon': Icons.list,
// //         'label': 'Shortlist',
// //         'widget': ShortlistTab(),
// //         'completed': false,
// //       },
// //       // {
// //       //   'icon': Icons.account_circle_rounded,
// //       //   'label': 'Interview',
// //       //   'widget': InterviewTab(),
// //       //   'completed': false,
// //       // },
// //     ];
// //     // TODO: implement initState
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       insetPadding: const EdgeInsets.all(16),
// //       backgroundColor: Colors.white,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       child: ConstrainedBox(
// //         constraints: BoxConstraints(
// //           maxWidth: MediaQuery.of(context).size.width * 0.95,
// //           maxHeight: MediaQuery.of(context).size.height * 0.95,
// //         ),
// //         child: Column(
// //           children: [
// //             // Header with gradient
// //             Container(
// //               decoration: const BoxDecoration(
// //                 color: AppColors.primaryColor,
// //                 borderRadius: const BorderRadius.only(
// //                   topLeft: Radius.circular(16),
// //                   topRight: Radius.circular(16),
// //                 ),
// //               ),
// //               child: Padding(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     const CustomText(
// //                       text: 'Vacancy Details',
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                     IconButton(
// //                       icon: const Icon(Icons.close,
// //                           color: Colors.white, size: 24),
// //                       onPressed: () => Navigator.of(context).pop(),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // Customer Info Card
// //             Container(
// //               width: double.maxFinite,
// //               // margin: const EdgeInsets.all(16),
// //               padding: EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: AppColors.primaryColor,
// //                 // borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.1),
// //                     spreadRadius: 1,
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ],
// //                 border: Border.all(color: AppColors.iconWhiteColour),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Container(
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           gradient: AppColors.buttonGraidentColour,
// //                           borderRadius: BorderRadius.circular(50),
// //                         ),
// //                         child: const Icon(Icons.work,
// //                             color: Colors.white, size: 32),
// //                       ),
// //                       SizedBox(width: 16),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 CustomText(
// //                                   text:
// //                                       widget.vacancy.project?.projectName ?? '',
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: AppColors.textWhiteColour,
// //                                 ),
// //                                 // CustomGradientButton(
// //                                 //   text: 'Edit Vacancy',
// //                                 //   gradientColors: AppColors.redGradient,
// //                                 //   onPressed: () {
// //                                 //     showDialog(
// //                                 //         context: context,
// //                                 //         builder: (context) => Dialog(
// //                                 //               child: AddNewProjectTab(
// //                                 //                 isEditMode: true,
// //                                 //                 project: widget.vacancy.project,
// //                                 //               ),
// //                                 //             ));
// //                                 //   },
// //                                 // ),
// //                               ],
// //                             ),
// //                             // Align(
// //                             //   alignment: Alignment.centerLeft,
// //                             //   child: Wrap(
// //                             //     spacing: 12,
// //                             //     runSpacing: 8,
// //                             //     children: [
// //                             //       _buildInfoChip(
// //                             //           Icons.date_range,
// //                             //           'Deadline: ${widget.vacancy.lastDateToApply}',
// //                             //           AppColors.blueSecondaryColor),
// //                             //       // _buildInfoChip(
// //                             //       //     Icons.numbers,
// //                             //       //     'No of vacancies:${widget.project}',
// //                             //       //     AppColors.greenSecondaryColor),
// //                             //     ],
// //                             //   ),
// //                             // ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // Tab and content section
// //             Expanded(
// //               child: Container(
// //                 // margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.only(
// //                     bottomRight: Radius.circular(12),
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.white.withOpacity(0.1),
// //                       spreadRadius: 1,
// //                       blurRadius: 10,
// //                       offset: const Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     // Left Tab List
// //                     Container(
// //                       width: 200,
// //                       decoration: const BoxDecoration(
// //                         color: AppColors.primaryColor,
// //                         borderRadius: BorderRadius.only(
// //                           // topLeft: Radius.circular(12),
// //                           bottomLeft: Radius.circular(12),
// //                         ),
// //                       ),
// //                       child: ListView.builder(
// //                         padding: const EdgeInsets.all(8),
// //                         itemCount: _tabs.length,
// //                         itemBuilder: (context, index) {
// //                           final tab = _tabs[index];
// //                           final isSelected = _selectedTabIndex == index;
// //                           return Container(
// //                             margin: const EdgeInsets.only(bottom: 4),
// //                             decoration: BoxDecoration(
// //                               gradient: isSelected
// //                                   ? AppColors.buttonGraidentColour
// //                                   : null,
// //                               color: isSelected ? null : Colors.transparent,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             child: ListTile(
// //                               dense: true,
// //                               leading: Icon(
// //                                 tab['icon'] as IconData,
// //                                 color: isSelected
// //                                     ? Colors.white
// //                                     : AppColors.textGrayColour,
// //                                 size: 22,
// //                               ),
// //                               title: CustomText(
// //                                 text: tab['label'] as String,
// //                                 fontSize: 14,
// //                                 fontWeight: isSelected
// //                                     ? FontWeight.w600
// //                                     : FontWeight.w100,
// //                                 color: isSelected
// //                                     ? Colors.white
// //                                     : Colors.white.withOpacity(0.5),
// //                               ),
// //                               trailing: tab['completed'] as bool
// //                                   ? Icon(
// //                                       Icons.check_circle,
// //                                       color: isSelected
// //                                           ? Colors.white
// //                                           : AppColors.greenSecondaryColor,
// //                                       size: 18,
// //                                     )
// //                                   : Icon(
// //                                       Icons.radio_button_unchecked,
// //                                       color: isSelected
// //                                           ? Colors.white70
// //                                           : AppColors.textGrayColour,
// //                                       size: 18,
// //                                     ),
// //                               onTap: () {
// //                                 setState(() {
// //                                   _selectedTabIndex = index;
// //                                 });
// //                               },
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ),

// //                     // Right content
// //                     Expanded(
// //                       child: Container(
// //                         padding: const EdgeInsets.all(3),
// //                         child: _tabs[_selectedTabIndex]['widget'] as Widget,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import '../../widgets/custom_text.dart';
// // // import './tabs/lead_details_tab.dart';
// // // import './tabs/call_history_tab.dart';
// // // import './tabs/campaign_tab.dart';
// // // import './tabs/registration_personal_tab.dart';
// // // import './tabs/academic_tab.dart';
// // // import './tabs/language_test_tab.dart';
// // // import './tabs/job_details_tab.dart';
// // // import './tabs/migration_tab.dart';
// // // import './tabs/interview_tab.dart';
// // // import './tabs/travel_history_tab.dart';
// // // import './tabs/documents_tab.dart';
// // // import './tabs/verification_status_tab.dart';
// // // import './tabs/application_status_tab.dart';

// // // class CustomerProfileScreen extends StatefulWidget {
// // //   const CustomerProfileScreen({super.key});

// // //   @override
// // //   State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
// // // }

// // // class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
// // //   int _selectedTabIndex = 0;

// // //   final List<Map<String, dynamic>> _tabs = [
// // //     {
// // //       'icon': Icons.assignment_outlined,
// // //       'label': 'Lead Details',
// // //       'widget': const LeadDetailsTab(),
// // //       'completed': true,
// // //     },
// // //     {
// // //       'icon': Icons.call_outlined,
// // //       'label': 'Call History',
// // //       'widget': const CallHistoryTab(),
// // //       'completed': true,
// // //     },
// // //     {
// // //       'icon': Icons.campaign_outlined,
// // //       'label': 'Campaign',
// // //       'widget': const CampaignTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.person_outline,
// // //       'label': 'Registration Personal',
// // //       'widget': const RegistrationPersonalTab(),
// // //       'completed': true,
// // //     },
// // //     {
// // //       'icon': Icons.school_outlined,
// // //       'label': 'Academic',
// // //       'widget': const AcademicTab(),
// // //       'completed': true,
// // //     },
// // //     {
// // //       'icon': Icons.language_outlined,
// // //       'label': 'Language Test',
// // //       'widget': const LanguageTestTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.work_outline,
// // //       'label': 'My Job Details',
// // //       'widget': const JobDetailsTab(),
// // //       'completed': true,
// // //     },
// // //     {
// // //       'icon': Icons.flight_takeoff_outlined,
// // //       'label': 'Migration',
// // //       'widget': const MigrationTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.question_answer_outlined,
// // //       'label': 'Interview',
// // //       'widget': const InterviewTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.history_outlined,
// // //       'label': 'Travel History',
// // //       'widget': const TravelHistoryTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.description_outlined,
// // //       'label': 'Documents',
// // //       'widget': const DocumentsTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.verified_outlined,
// // //       'label': 'Verification Status',
// // //       'widget': const VerificationStatusTab(),
// // //       'completed': false,
// // //     },
// // //     {
// // //       'icon': Icons.app_registration_outlined,
// // //       'label': 'Application Status',
// // //       'widget': const ApplicationStatusTab(),
// // //       'completed': false,
// // //     },
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Dialog(
// // //       insetPadding: const EdgeInsets.all(16),
// // //       child: ConstrainedBox(
// // //         constraints: BoxConstraints(
// // //           maxWidth: MediaQuery.of(context).size.width * 0.9,
// // //           maxHeight: MediaQuery.of(context).size.height * 0.9,
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             // Header row
// // //             Padding(
// // //               padding: const EdgeInsets.symmetric(
// // //                 horizontal: 16,
// // //               ),
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   const CustomText(
// // //                     text: 'View',
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                   IconButton(
// // //                     icon: const Icon(Icons.close),
// // //                     onPressed: () => Navigator.of(context).pop(),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),

// // //             // Info section
// // //             Container(
// // //               width: double.maxFinite,
// // //               margin: const EdgeInsets.symmetric(horizontal: 10),
// // //               padding: const EdgeInsets.all(16.0),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.grey[100],
// // //                 borderRadius: BorderRadius.circular(4.0),
// // //               ),
// // //               child: Wrap(
// // //                 spacing: 16,
// // //                 runSpacing: 8,
// // //                 crossAxisAlignment: WrapCrossAlignment.center,
// // //                 children: [
// // //                   const CircleAvatar(
// // //                     backgroundColor: Colors.amber,
// // //                     child: Icon(Icons.person, color: Colors.white),
// // //                   ),
// // //                   const CustomText(
// // //                     text: 'Sibin PP',
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                   _buildTag(Icons.phone, 'Mobile: 91623'),
// // //                   _buildTag(Icons.person, 'Counselling by: Sibin - Recruiter'),
// // //                   _buildStatusTag('MIGRATION', Colors.grey[300]!),
// // //                   _buildStatusTag('REGISTRATION', Colors.red[100]!),
// // //                   _buildStatusTag('Registration Completed', Colors.green[100]!),
// // //                   ElevatedButton.icon(
// // //                     onPressed: () {},
// // //                     icon: const Icon(Icons.delete, color: Colors.white),
// // //                     label: const CustomText(
// // //                         text: 'Delete Lead', color: Colors.white),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.red,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),

// // //             const SizedBox(height: 8),

// // //             // Tab and content section
// // //             Expanded(
// // //               child: Row(
// // //                 children: [
// // //                   // Left Tab List
// // //                   Container(
// // //                     width: 250,
// // //                     color: Colors.grey[100],
// // //                     child: ListView.builder(
// // //                       itemCount: _tabs.length,
// // //                       itemBuilder: (context, index) {
// // //                         final tab = _tabs[index];
// // //                         return ListTile(
// // //                           selected: _selectedTabIndex == index,
// // //                           selectedTileColor: Colors.blue[50],
// // //                           leading: Icon(
// // //                             tab['icon'] as IconData,
// // //                             color: _selectedTabIndex == index
// // //                                 ? Colors.blue
// // //                                 : Colors.grey,
// // //                           ),
// // //                           title: CustomText(
// // //                             text: tab['label'] as String,
// // //                             fontWeight: _selectedTabIndex == index
// // //                                 ? FontWeight.bold
// // //                                 : FontWeight.normal,
// // //                             color: _selectedTabIndex == index
// // //                                 ? Colors.blue
// // //                                 : Colors.black,
// // //                           ),
// // //                           trailing: tab['completed'] as bool
// // //                               ? const Icon(Icons.check_circle,
// // //                                   color: Colors.green, size: 20)
// // //                               : null,
// // //                           onTap: () {
// // //                             setState(() {
// // //                               _selectedTabIndex = index;
// // //                             });
// // //                           },
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),

// // //                   // Right content
// // //                   Expanded(
// // //                     child: Container(
// // //                       color: Colors.white,
// // //                       padding: const EdgeInsets.all(16),
// // //                       child: _tabs[_selectedTabIndex]['widget'] as Widget,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTag(IconData icon, String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         border: Border.all(color: Colors.grey),
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Icon(icon, size: 16),
// // //           const SizedBox(width: 4),
// // //           CustomText(text: text),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildStatusTag(String text, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         color: color,
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: CustomText(text: text),
// // //     );
// // //   }
// // // }
