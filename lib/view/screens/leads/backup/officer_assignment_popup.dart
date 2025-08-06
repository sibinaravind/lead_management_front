// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/controller/lead/lead_provider.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import 'package:provider/provider.dart';

// class OfficerAssignmentPopup extends StatefulWidget {
//   const OfficerAssignmentPopup({super.key, required this.leadId});

//   final String leadId;

//   @override
//   State<OfficerAssignmentPopup> createState() => _OfficerAssignmentPopupState();
// }

// class _OfficerAssignmentPopupState extends State<OfficerAssignmentPopup>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();

//   String? _selectedClientId;
//   String? _selectedOfficerId;

//   // Controllers
//   final TextEditingController _commentController = TextEditingController();

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _selectedClientId = widget.leadId;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.4;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.5;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.7;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.7,
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
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
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
//                             Icons.assignment_ind_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: 'OfficerModel Assignment ',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: 'Assign officer to client',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(24),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       // Client ID Dropdown
//                                       // CustomDropdownField(
//                                       //   label: 'Client ID',
//                                       //   value: _selectedClientId,
//                                       //   items: const [
//                                       //     '6878fde17154b526aac72d2f',
//                                       //     '6878fde17154b526aac72d30',
//                                       //     '6878fde17154b526aac72d31',
//                                       //   ], // Replace with your actual client list
//                                       //   onChanged: (val) => setState(
//                                       //       () => _selectedClientId = val),
//                                       //   isRequired: true,
//                                       // ),
//                                       // const SizedBox(height: 16),

//                                       // OfficerModel ID Dropdown
//                                       CustomDropdownField(
//                                         isSplit: true,
//                                         label: 'OfficerModel ID',
//                                         value: _selectedOfficerId,
//                                         items: Provider.of<
//                                                         OfficersControllerProvider>(
//                                                     context)
//                                                 .allOfficersListData
//                                                 ?.map(
//                                                     (e) => "${e.name},${e.sId}")
//                                                 .toList() ??
//                                             [], // Replace with your actual officer list
//                                         onChanged: (val) => setState(() =>
//                                             _selectedOfficerId =
//                                                 val?.split(",").last ?? ''),
//                                         isRequired: true,
//                                       ),
//                                       const SizedBox(height: 16),

//                                       // Comment Field
//                                       CustomTextFormField(
//                                         label: 'Comment',
//                                         hintText: 'Enter your comment...',
//                                         controller: _commentController,
//                                         maxLines: 3,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),

//                             // Action Buttons
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomActionButton(
//                                     text: 'Cancel',
//                                     icon: Icons.close_rounded,
//                                     textColor: Colors.grey,
//                                     onPressed: () => Navigator.pop(context),
//                                     borderColor: Colors.grey.shade300,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   flex: 2,
//                                   child: CustomActionButton(
//                                     text: 'Assign OfficerModel',
//                                     icon: Icons.assignment_turned_in_rounded,
//                                     isFilled: true,
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color(0xFF7F00FF),
//                                         Color(0xFFE100FF)
//                                       ],
//                                     ),
//                                     onPressed: () {
//                                       if (_formKey.currentState?.validate() ??
//                                           false) {
//                                         // Create the assignment data
//                                         final assignmentData = {
//                                           "clientId": _selectedClientId,
//                                           "officerId": _selectedOfficerId,
//                                           "comment":
//                                               _commentController.text.trim(),
//                                         };

//                                         Provider.of<LeadProvider>(context,
//                                                 listen: false)
//                                             .restoreDeadLead(
//                                                 context, assignmentData);

//                                         // You can call your provider method here
//                                         // Provider.of<LeadProvider>(context, listen: false)
//                                         //     .assignOfficer(context, assignmentData);

//                                         // For now, just print the data
//                                         print(
//                                             'Assignment Data: $assignmentData');

//                                         Navigator.pop(context, assignmentData);
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
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
