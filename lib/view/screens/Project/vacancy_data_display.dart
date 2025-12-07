// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/project/project_controller.dart';
// import 'package:overseas_front_end/view/screens/project/widget/create_edit_vacancy_popup.dart';
// import '../../../utils/style/colors/colors.dart';
// import '../../../utils/style/colors/dimension.dart';
// import '../../widgets/custom_toast.dart';
// import '../../widgets/widgets.dart';
// import 'widget/vacancy_user_list_table.dart';

// class VacancyDataDisplay extends StatefulWidget {
//   const VacancyDataDisplay({super.key});

//   @override
//   State<VacancyDataDisplay> createState() => _VacancyDataDisplayState();
// }

// class _VacancyDataDisplayState extends State<VacancyDataDisplay> {
//   String selectedFilter = 'all';
//   final _projectController = Get.find<ProjectController>();

//   @override
//   void initState() {
//     super.initState();
//     _loadVacancies();
//   }

//   Future<void> _loadVacancies() async {
//     try {
//       await _projectController.fetchVacancies();
//     } catch (e) {
//       CustomToast.showToast(
//           context: context, message: "Error loading vacancies: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         if (_projectController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 // Header section
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   decoration: BoxDecoration(
//                     gradient: AppColors.blackGradient,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.primaryColor.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.3),
//                             width: 1,
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.analytics_outlined,
//                           color: AppColors.textWhiteColour,
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: 24),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: "Vacancy Management Dashboard",
//                               color: AppColors.textWhiteColour,
//                               fontSize: Dimension().isMobile(context) ? 13 : 19,
//                               maxLines: 2,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: AppColors.buttonGraidentColour,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color:
//                                   AppColors.violetPrimaryColor.withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20),
//                             onTap: () async {
//                               // Clear search and filters
//                               showLoaderDialog(context);
//                               await _projectController.fetchProjects();
//                               await _projectController.fetchClients();
//                               Navigator.pop(context);
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => CreateEditVacancyPopup(),
//                               );
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 10,
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add_circle_outline,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   SizedBox(width: 12),
//                                   CustomText(
//                                     text: 'New Vacancy',
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Search and filter section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: SizedBox(
//                         width: 300,
//                         height: 40,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: TextField(
//                             onChanged: _projectController.searchVacancies,
//                             decoration: InputDecoration(
//                               hintText: "Search Vacancies...",
//                               hintStyle: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 15,
//                               ),
//                               hoverColor: Colors.white,
//                               fillColor: AppColors.whiteMainColor,
//                               filled: true,
//                               suffixIcon: const IconButton(
//                                 icon: Icon(Icons.search,
//                                     size: 20, color: Colors.grey),
//                                 onPressed: null,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                                 borderSide: const BorderSide(
//                                   color: Colors.black,
//                                   width: 0.3,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                                 borderSide: const BorderSide(
//                                   color: AppColors.primaryColor,
//                                   width: 1,
//                                 ),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 15,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Main content area
//                 Container(
//                   width: double.maxFinite,
//                   margin: const EdgeInsets.only(top: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 20,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: VacancyUserListTable(
//                           userlist: _projectController.filteredVacancies,
//                         ),
//                       ),

//                       // Footer with Pagination
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF8FAFC),
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                           border: Border(
//                             top: BorderSide(
//                               color: AppColors.textGrayColour.withOpacity(0.1),
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     gradient: AppColors.blackGradient,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: const Icon(
//                                     Icons.analytics_outlined,
//                                     color: Colors.white,
//                                     size: 18,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomText(
//                                       text:
//                                           "${_projectController.filteredVacancies.length} Vacancies",
//                                       color: AppColors.primaryColor,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
