// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/utils/functions/format_date.dart';
// import 'package:overseas_front_end/view/widgets/popup_date_field.dart';

// import '../../../../controller/config/config_controller.dart';
// import '../../../../controller/registration/registration_controller.dart';
// import '../../../../model/lead/lead_model.dart';
// import '../../../../model/lead/work_record_model.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_toast.dart';
// import '../../../widgets/widgets.dart';

// class WorkExperience extends StatefulWidget {
//   final LeadModel leadModel;
//   const WorkExperience({super.key, required this.leadModel});

//   @override
//   State<WorkExperience> createState() => _AcadamicTabState();
// }

// class _AcadamicTabState extends State<WorkExperience> {
//   final List<WorkRecordModel> _records = [];

//   @override
//   void initState() {
//     super.initState();
//     _records.addAll(widget.leadModel.workRecords ?? []);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CustomText(
//               text: 'Work Records', fontSize: 16, fontWeight: FontWeight.bold),
//           const SizedBox(height: 16),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Column(
//               children: [
//                 // Header
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   color: Colors.grey[200],
//                   child: const Row(
//                     children: [
//                       Expanded(
//                           flex: 3,
//                           child: CustomText(
//                               text: 'Position', fontWeight: FontWeight.bold)),
//                       Expanded(
//                         flex: 2,
//                         child: SizedBox(
//                             width: 100,
//                             child: CustomText(
//                                 text: 'Department',
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                           flex: 2,
//                           child: CustomText(
//                               text: 'Organisation',
//                               fontWeight: FontWeight.bold)),
//                       Expanded(
//                           flex: 2,
//                           child: CustomText(
//                               text: 'Country', fontWeight: FontWeight.bold)),
//                       Expanded(
//                           flex: 2,
//                           child: CustomText(
//                               text: 'Start Date', fontWeight: FontWeight.bold)),
//                       Expanded(
//                           flex: 2,
//                           child: CustomText(
//                               text: 'End Date', fontWeight: FontWeight.bold)),
//                       SizedBox(
//                           width: 100,
//                           child: CustomText(
//                               text: 'Total Years',
//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 if (_records.isEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: const Center(
//                       child: CustomText(text: 'No Experience  added yet'),
//                     ),
//                   )
//                 else
//                   ..._records.asMap().entries.map((entry) {
//                     final i = entry.key;
//                     final record = entry.value;
//                     return Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: Colors.grey[300]!),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               flex: 3,
//                               child: CustomText(text: record.position ?? '')),
//                           Expanded(
//                               flex: 2,
//                               child: CustomText(text: record.department ?? '')),
//                           Expanded(
//                               flex: 2,
//                               child:
//                                   CustomText(text: record.organization ?? '')),
//                           Expanded(
//                               flex: 2,
//                               child: CustomText(text: record.country ?? '')),
//                           Expanded(
//                               flex: 2,
//                               child: CustomText(
//                                   text: formatDatetoString(record.fromDate))),
//                           Expanded(
//                               flex: 2,
//                               child: CustomText(
//                                   text: formatDatetoString(record.toDate))),
//                           SizedBox(
//                             width: 100,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.edit,
//                                       color: AppColors.blueSecondaryColor),
//                                   tooltip: 'Edit',
//                                   onPressed: () => _showRecordDialog(
//                                     recordToEdit: record,
//                                     editIndex: i,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       color: AppColors.redSecondaryColor),
//                                   tooltip: 'Delete',
//                                   onPressed: () => _showDeleteConfirmation(i),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//               onPressed: () => _showRecordDialog(),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 minimumSize: const Size(200, 48),
//               ),
//               child: const CustomText(
//                 text: 'Add Experience',
//                 color: AppColors.textWhiteColour,
//               )),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 30.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const CustomText(text: 'Cancel')),
//                 const SizedBox(width: 16),
//                 if (_records.isNotEmpty)
//                   CustomButton(
//                     text: 'Save',
//                     width: 100,
//                     onTap: () async {
//                       showLoaderDialog(context);
//                       bool result = await Get.find<RegistrationController>()
//                           .updateWorkRecords(
//                         data: _records,
//                         customerId: widget.leadModel.sId ?? '',
//                       );

//                       if (result) {
//                         Navigator.pop(context);
//                         CustomToast.showToast(
//                           context: context,
//                           backgroundColor: Colors.green,
//                           message: 'Personal details Successfully updated ',
//                         );
//                       } else {
//                         Navigator.pop(context);
//                         CustomToast.showToast(
//                           context: context,
//                           backgroundColor: Colors.red,
//                           message:
//                               Get.find<RegistrationController>().errorMessage ??
//                                   'Failed to update personal details',
//                         );
//                       }
//                     },
//                   )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showRecordDialog({WorkRecordModel? recordToEdit, int? editIndex}) {
//     final isEditing = recordToEdit != null;
//     final position = TextEditingController(
//       text: recordToEdit?.position ?? '',
//     );
//     final departments = TextEditingController(
//       text: recordToEdit?.department ?? '',
//     );
//     final organisation = TextEditingController(
//       text: recordToEdit?.organization ?? '',
//     );
//     final country = TextEditingController(
//       text: recordToEdit?.country ?? '',
//     );
//     final fromDate = TextEditingController(
//       text: formatDatetoString(recordToEdit?.fromDate) ?? '',
//     );
//     final toDate = TextEditingController(
//       text: formatDatetoString(recordToEdit?.toDate) ?? '',
//     );
//     final dialogFormKey = GlobalKey<FormState>();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (dialogContext, setDialogState) => Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 8,
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             constraints: const BoxConstraints(maxWidth: 500),
//             padding: const EdgeInsets.all(24),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header with icon and title - FIXED
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           isEditing ? Icons.edit : Icons.add,
//                           color: AppColors.primaryColor,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: isEditing
//                                   ? 'Edit Work Record' // FIXED: Changed from "Exam Record"
//                                   : 'Add Work Record', // FIXED: Changed from "Exam Record"
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             const SizedBox(height: 4),
//                             CustomText(
//                               text: isEditing
//                                   ? 'Update your work experience' // FIXED: Changed from "Exam information"
//                                   : 'Enter your work experience', // FIXED: Changed from "Exam details"
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Form(
//                     key: dialogFormKey,
//                     child: Column(
//                       children: [
//                         PopupDropDownField(
//                           label: 'Job Title',
//                           icon: Icons.work,
//                           isRequired: true,
//                           value: position.text,
//                           items: Get.find<ConfigController>()
//                                   .configData
//                                   .value
//                                   .jobCategory
//                                   ?.map((e) => e.name ?? "")
//                                   .toList() ??
//                               [],
//                           onChanged: (value) {
//                             setDialogState(() {
//                               position.text = value ?? '';

//                               departments.text = '';
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         PopupDropDownField(
//                           key: ValueKey(position.text),
//                           label: 'Specialization',
//                           isRequired: true,
//                           value: departments.text,
//                           icon: Icons.category,
//                           items: Get.find<ConfigController>()
//                                   .configData
//                                   .value
//                                   .specialized
//                                   ?.where((e) {
//                                     return e.category?.toLowerCase() ==
//                                         position.text.trim().toLowerCase();
//                                   })
//                                   .map((e) => e.name ?? "")
//                                   .toList() ??
//                               [],
//                           onChanged: (value) {
//                             setDialogState(() {
//                               departments.text = value ?? '';
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         PopupTextField(
//                           requiredField: true,
//                           controller: organisation,
//                           icon: Icons.business,
//                           label: 'Organization',
//                           hint: 'Aegis Health, Apollo Hospital, etc.',
//                         ),
//                         const SizedBox(height: 16),

//                         PopupDropDownField(
//                           // key: ValueKey(position.text),
//                           label: 'Country',
//                           isRequired: true,
//                           value: country.text,
//                           icon: Icons.location_on,
//                           items: Get.find<ConfigController>()
//                                   .configData
//                                   .value
//                                   .country
//                                   ?.map((e) => e.name ?? "")
//                                   .toList() ??
//                               [],
//                           onChanged: (value) {
//                             setDialogState(() {
//                               country.text = value ?? '';
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         // REMOVED: Duplicate SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: PopupDateField(
//                                 isRequired: true,
//                                 label: "From Date",
//                                 controller: fromDate,
//                                 firstDate: DateTime.now().subtract(
//                                     const Duration(
//                                         days: 365 * 50)), // 50 years ago
//                                 lastDate: DateTime.now(),
//                                 onChanged: (value) {
//                                   setDialogState(() {
//                                     fromDate.text = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                                 width:
//                                     16), // FIXED: Increased width for better spacing
//                             Expanded(
//                               child: PopupDateField(
//                                 isRequired:
//                                     false, // To Date can be optional for current jobs
//                                 label: "To Date",
//                                 controller: toDate,
//                                 firstDate: DateTime.now()
//                                     .subtract(const Duration(days: 365 * 50)),
//                                 lastDate: DateTime.now().add(const Duration(
//                                     days:
//                                         365)), // Allow future dates for notice periods
//                                 onChanged: (value) {
//                                   setDialogState(() {
//                                     toDate.text = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),

//                         // Optional: Add current job checkbox
//                         // Row(
//                         //   children: [
//                         //     Checkbox(
//                         //       value: toDate.text.isEmpty,
//                         //       onChanged: (bool? value) {
//                         //         setDialogState(() {
//                         //           if (value == true) {
//                         //             toDate.text = '';
//                         //           }
//                         //         });
//                         //       },
//                         //     ),
//                         //     const SizedBox(width: 8),
//                         //     const CustomText(
//                         //       text: 'Currently working here',
//                         //       fontSize: 14,
//                         //     ),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 32),

//                   // Action buttons with enhanced styling
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: CustomText(
//                           text: 'Cancel',
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (dialogFormKey.currentState!.validate()) {
//                             final newRecord = WorkRecordModel(
//                               position: position.text,
//                               department: departments.text,
//                               fromDate: formatStringToDate(fromDate.text),
//                               toDate: toDate.text.isNotEmpty
//                                   ? formatStringToDate(toDate.text)
//                                   : null, // FIXED: Handle empty toDate
//                               organization: organisation.text,
//                               country: country.text,
//                             );
//                             setState(() {
//                               if (isEditing && editIndex != null) {
//                                 _records[editIndex] = newRecord;
//                               } else {
//                                 _records.add(newRecord);
//                               }
//                             });
//                             Navigator.pop(context);

//                             // Show success message - FIXED: Updated message
//                             CustomSnackBar.show(
//                                 context,
//                                 isEditing
//                                     ? 'Work record updated successfully!'
//                                     : 'Work record added successfully!');
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               isEditing ? Icons.update : Icons.add,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             CustomText(
//                               text: isEditing ? 'Update' : 'Add Record',
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(int index) {
//     final record = _records[index];
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.warning,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const CustomText(
//               text: 'Confirm Delete',
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomText(
//                 text: 'Are you sure you want to delete this Experience record?',
//                 fontSize: 16),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: record.position ?? '',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                   const SizedBox(height: 4),
//                   CustomText(
//                     text: record.department ?? '',
//                     color: Colors.grey[700],
//                     fontSize: 13,
//                   ),
//                   CustomText(
//                     text: '${record.organization}',
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                   CustomText(
//                     text: formatDatetoString(record.fromDate) ?? '',
//                     color: Colors.grey[700],
//                     fontSize: 13,
//                   ),
//                   CustomText(
//                     text: formatDatetoString(record.toDate) ?? '',
//                     color: Colors.grey[700],
//                     fontSize: 13,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             CustomText(
//               text: 'This action cannot be undone.',
//               color: Colors.red[600],
//               fontSize: 12,
//               fontStyle: FontStyle.italic,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             child: CustomText(
//               text: 'Cancel',
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _records.removeAt(index);
//               });
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content:
//                       CustomText(text: 'Academic record deleted successfully!'),
//                   backgroundColor: Colors.red,
//                   behavior: SnackBarBehavior.floating,
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.delete, size: 16),
//                 SizedBox(width: 6),
//                 CustomText(text: 'Delete'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
