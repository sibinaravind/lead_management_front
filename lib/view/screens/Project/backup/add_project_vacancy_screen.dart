// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/project/project_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// import 'widget/client_mangement_tab.dart';
// import 'widget/add_edit_project.dart';

// class AddNewProject extends StatefulWidget {
//   final bool isEditMode;
//   final ProjectModel? projectList;
//   const AddNewProject({super.key, required this.isEditMode , this.projectList});

//   @override
//   State<AddNewProject> createState() =>
//       _AddNewProjectState();
// }

// class _AddNewProjectState
//     extends State<AddNewProject>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isActive = true;

//   @override
//   void initState() {

//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(16),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           // double dialogWidth = maxWidth > 900
//           //     ? maxWidth * 0.8
//           //     : maxWidth > 900
//           //         ? maxWidth * 0.8
//           //         : maxWidth;
//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.6;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.7;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.8;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(

//                 minWidth: 320,
//                 maxWidth: 800,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Header
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.85),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.business_center_outlined,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomText(
//                                 text: widget.isEditMode
//                                     ? 'Edit Project '
//                                     : 'Add Project',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text:widget.isEditMode?'Manage projects Edit':'Manage projects  Creation' ,
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 26),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Expanded(
//                             child:AddNewProjectTab(
//                               project: widget.projectList,
//                                 isEditMode: widget.isEditMode,)
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
