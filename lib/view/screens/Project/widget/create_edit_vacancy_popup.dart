// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/project/project_controller.dart';
// import 'package:overseas_front_end/model/project/client_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import '../../../../controller/config/config_controller.dart';
// import '../../../../model/project/vacancy_model.dart';
// import '../../../widgets/custom_toast.dart';

// class CreateEditVacancyPopup extends StatefulWidget {
//   final bool isEditMode;
//   final VacancyModel? vacancy;

//   const CreateEditVacancyPopup({
//     super.key,
//     this.isEditMode = false,
//     this.vacancy,
//   });

//   @override
//   State<CreateEditVacancyPopup> createState() =>
//       _ProjectClientManagementScreenState();
// }

// class _ProjectClientManagementScreenState extends State<CreateEditVacancyPopup>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _jobTitleController = TextEditingController();
//   final TextEditingController _jobVacancyController = TextEditingController();
//   final TextEditingController _experienceController = TextEditingController();
//   final TextEditingController _skillsController = TextEditingController();
//   final TextEditingController _salaryFromController = TextEditingController();
//   final TextEditingController _salaryToController = TextEditingController();
//   final TextEditingController _organizationNameController =
//       TextEditingController();
//   final TextEditingController _organizationCategoryController =
//       TextEditingController();
//   final TextEditingController _lastDateToApplyController =
//       TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   String _countryController = '';
//   final TextEditingController _cityController = TextEditingController();

//   List<String> qualification = [];
//   List<Map<String, dynamic>> _selectedClients = [];
//   String clients = '';
//   String projectList = '';
//   String projectId = '';
//   late TabController _tabController;
//   late List<String> specializationDropdownItems;
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _vacancyController = TextEditingController();
//   final TextEditingController _targetCvController = TextEditingController();
//   final TextEditingController _commissionController = TextEditingController();
//   final _configController = Get.find<ConfigController>();
//   final _projectController = Get.find<ProjectController>();
//   String specializedSelection = '';

//   // Form key for validation
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     _initializeFields();
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   void _initializeFields() {
//     if (widget.isEditMode && widget.vacancy != null) {
//       projectId = widget.vacancy?.project?.sId ?? '';
//       _countryController = widget.vacancy?.country ?? "";
//       _cityController.text = widget.vacancy?.city ?? "";
//       projectList = widget.vacancy?.project?.projectName ?? '';
//       _organizationCategoryController.text =
//           widget.vacancy?.project?.organizationCategory ?? "";
//       _jobTitleController.text = widget.vacancy?.jobTitle ?? "";
//       _jobVacancyController.text = widget.vacancy?.jobCategory ?? "";
//       qualification =
//           widget.vacancy?.qualifications?.map((item) => item).toList() ?? [];
//       _experienceController.text = widget.vacancy?.experience ?? '';
//       _salaryFromController.text = widget.vacancy?.salaryFrom.toString() ?? '';
//       _salaryToController.text = widget.vacancy?.salaryTo.toString() ?? '';
//       _lastDateToApplyController.text = widget.vacancy?.lastDateToApply ?? '';
//       _descriptionController.text = widget.vacancy?.description ?? "";

//       // Initialize clients if in edit mode
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _jobTitleController.dispose();
//     _jobVacancyController.dispose();
//     _experienceController.dispose();
//     _skillsController.dispose();
//     _salaryFromController.dispose();
//     _salaryToController.dispose();
//     _organizationNameController.dispose();
//     _organizationCategoryController.dispose();
//     _lastDateToApplyController.dispose();
//     _descriptionController.dispose();
//     _cityController.dispose();
//     _searchController.dispose();
//     _vacancyController.dispose();
//     _targetCvController.dispose();
//     _commissionController.dispose();
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

//           double dialogWidth = maxWidth > 1400
//               ? maxWidth * 0.8
//               : maxWidth > 1000
//                   ? maxWidth * 0.9
//                   : maxWidth;

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.9,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1600,
//                 minHeight: 600,
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
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Header
//                     Container(
//                       height: 80,
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             AppColors.primaryColor,
//                             AppColors.primaryColor.withOpacity(0.85),
//                           ],
//                         ),
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.business_center_outlined,
//                               size: 22,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                   text: widget.isEditMode
//                                       ? 'Edit Vacancy'
//                                       : 'Create Vacancy',
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 const CustomText(
//                                   text: 'Manage Vacancy details',
//                                   fontSize: 13,
//                                   color: Colors.white70,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.close_rounded,
//                                 color: Colors.white, size: 26),
//                             onPressed: () => Navigator.of(context).pop(),
//                             tooltip: 'Close',
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 8),
//                                   child: SizedBox(
//                                     height: 44,
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 16),
//                                             child: DecoratedBox(
//                                               decoration: BoxDecoration(
//                                                 gradient: _tabController
//                                                             .index ==
//                                                         0
//                                                     ? LinearGradient(
//                                                         colors: [
//                                                           AppColors
//                                                               .primaryColor,
//                                                           AppColors.primaryColor
//                                                               .withOpacity(0.7),
//                                                         ],
//                                                       )
//                                                     : null,
//                                                 color: _tabController.index == 0
//                                                     ? null
//                                                     : Colors.grey.shade100,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: TextButton.icon(
//                                                 style: TextButton.styleFrom(
//                                                   backgroundColor:
//                                                       Colors.transparent,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12),
//                                                   ),
//                                                   shadowColor:
//                                                       Colors.transparent,
//                                                 ),
//                                                 icon: Icon(
//                                                   Icons.work_outline,
//                                                   size: 20,
//                                                   color: _tabController.index ==
//                                                           0
//                                                       ? AppColors
//                                                           .textWhiteColour
//                                                       : AppColors.primaryColor,
//                                                 ),
//                                                 label: Text(
//                                                   'Vacancy Details',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                     color:
//                                                         _tabController.index ==
//                                                                 0
//                                                             ? AppColors
//                                                                 .textWhiteColour
//                                                             : AppColors
//                                                                 .primaryColor,
//                                                   ),
//                                                 ),
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     _tabController.index = 0;
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         if (!widget.isEditMode)
//                                           Expanded(
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 16),
//                                               child: DecoratedBox(
//                                                 decoration: BoxDecoration(
//                                                   gradient:
//                                                       _tabController.index == 1
//                                                           ? LinearGradient(
//                                                               colors: [
//                                                                 AppColors
//                                                                     .primaryColor,
//                                                                 AppColors
//                                                                     .primaryColor
//                                                                     .withOpacity(
//                                                                         0.7),
//                                                               ],
//                                                             )
//                                                           : null,
//                                                   color: _tabController.index ==
//                                                           1
//                                                       ? null
//                                                       : Colors.grey.shade100,
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: TextButton.icon(
//                                                   style: TextButton.styleFrom(
//                                                     backgroundColor:
//                                                         Colors.transparent,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               12),
//                                                     ),
//                                                     shadowColor:
//                                                         Colors.transparent,
//                                                   ),
//                                                   icon: Icon(
//                                                     Icons.people_outline,
//                                                     size: 20,
//                                                     color:
//                                                         _tabController.index ==
//                                                                 1
//                                                             ? AppColors
//                                                                 .textWhiteColour
//                                                             : AppColors
//                                                                 .primaryColor,
//                                                   ),
//                                                   label: Text(
//                                                     'Client',
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 16,
//                                                       color: _tabController
//                                                                   .index ==
//                                                               1
//                                                           ? AppColors
//                                                               .textWhiteColour
//                                                           : AppColors
//                                                               .primaryColor,
//                                                     ),
//                                                   ),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       _tabController.index = 1;
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: TabBarView(
//                                     controller: _tabController,
//                                     children: [
//                                       // Vacancy Details Tab
//                                       _buildVacancyDetailsTab(context),

//                                       _buildClientManagementTab(),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     children: [
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         child: CustomActionButton(
//                                           text: 'Cancel',
//                                           icon: Icons.close_rounded,
//                                           textColor: Colors.grey,
//                                           onPressed: () =>
//                                               Navigator.pop(context),
//                                           borderColor: Colors.grey.shade300,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         flex: 2,
//                                         child: CustomActionButton(
//                                           text: widget.isEditMode
//                                               ? 'Update Vacancy'
//                                               : 'Create Vacancy',
//                                           icon: Icons.save_rounded,
//                                           isFilled: true,
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Color(0xFF7F00FF),
//                                               Color(0xFFE100FF)
//                                             ],
//                                           ),
//                                           onPressed: _validateAndSubmit,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildVacancyDetailsTab(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth;
//         int columnsCount = availableWidth > 1000 ? 3 : 2;
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SectionTitle(
//                   title: 'Project Details',
//                   icon: Icons.info_outline_rounded,
//                 ),
//                 const SizedBox(height: 16),
//                 ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     if (!widget.isEditMode)
//                       CustomDropdownField(
//                         isSplit: true,
//                         label: "Project",
//                         value: projectList,
//                         items: (_projectController.projects
//                                 .where((project) =>
//                                     project.projectName != null &&
//                                     project.projectName!.isNotEmpty)
//                                 .map((project) =>
//                                     '${project.projectName}, ${project.sId}')
//                                 .toList() ??
//                             []),
//                         isRequired: true,
//                         onChanged: (value) {
//                           setState(() {
//                             projectList = value ?? '';
//                             projectId = value?.split(',').last ?? '';
//                           });
//                         },
//                       ),
//                     if (widget.isEditMode)
//                       CustomText(
//                         text: projectList,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       )
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const SectionTitle(
//                   title: 'Job Details',
//                   icon: Icons.info_outline_rounded,
//                 ),
//                 const SizedBox(height: 16),
//                 ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     CustomDropdownField(
//                       label: 'Job category',
//                       value: _jobVacancyController.text.trim(),
//                       items: _configController.configData.value.jobCategory
//                               ?.map((item) => item.name.toString().trim())
//                               .toList() ??
//                           [],
//                       isRequired: true,
//                       onChanged: (value) {
//                         setState(() {
//                           _jobVacancyController.text = value ?? '';
//                         });
//                       },
//                     ),
//                     CustomMultiSelectDropdownField(
//                       isRequired: true,
//                       isSplit: false,
//                       label: "Qualification",
//                       selectedItems: qualification,
//                       items: _configController.configData.value.program
//                               ?.map((item) => "${item.name}")
//                               .toList() ??
//                           [],
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select at least one qualification';
//                         }
//                         return null;
//                       },
//                       onChanged: (selectedList) {
//                         setState(() {
//                           qualification = selectedList;
//                         });
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Experience',
//                       controller: _experienceController,
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return null;
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Please enter a valid number';
//                         }
//                         if (double.parse(value) < 0 ||
//                             double.parse(value) > 70) {
//                           return 'Experience must be valid';
//                         }
//                         return null;
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Skills',
//                       controller: _skillsController,
//                     ),
//                     CustomTextFormField(
//                       label: 'Salary From',
//                       controller: _salaryFromController,
//                       keyboardType: TextInputType.number,
//                     ),
//                     CustomTextFormField(
//                       label: 'Salary To',
//                       controller: _salaryToController,
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return null;
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Please enter a valid number';
//                         }
//                         if (_salaryFromController.text.isNotEmpty &&
//                             double.parse(value) <
//                                 double.parse(_salaryFromController.text)) {
//                           return 'Salary to must be greater than salary from';
//                         }
//                         return null;
//                       },
//                     ),
//                     CustomDateField(
//                       isRequired: true,
//                       label: "Last Date To Apply",
//                       initialDate: DateTime.now(),
//                       controller: _lastDateToApplyController,
//                     ),
//                     CustomTextFormField(
//                       label: 'Description',
//                       controller: _descriptionController,
//                       maxLines: 1,
//                       validator: (value) {
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const SectionTitle(
//                   title: 'Country Details',
//                   icon: Icons.info_outline_rounded,
//                 ),
//                 const SizedBox(height: 5),
//                 ResponsiveGrid(
//                   alignment: WrapAlignment.spaceEvenly,
//                   columns: columnsCount,
//                   children: [
//                     CustomDropdownField(
//                       label: "Country",
//                       value: _countryController,
//                       items: _configController.configData.value.country
//                               ?.map((item) => "${item.name}")
//                               .toList() ??
//                           [],
//                       isRequired: true,
//                       onChanged: (value) {
//                         setState(() {
//                           _countryController = value!;
//                         });
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: "City",
//                       controller: _cityController,
//                       validator: (value) {
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildClientManagementTab() {
//     return Column(
//       children: [
//         // Header
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             gradient: AppColors.buttonGraidentColour,
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.people, color: Colors.white),
//               const SizedBox(width: 8),
//               const CustomText(
//                 text: 'Client Management',
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               const Spacer(),
//               ElevatedButton.icon(
//                 onPressed: _showAddClientDialog,
//                 icon: const Icon(Icons.add),
//                 label: const CustomText(text: 'Add Client'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue.shade600,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Selected Clients',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 8),
//               if (_selectedClients.isNotEmpty)
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: _selectedClients.length,
//                   itemBuilder: (context, index) {
//                     final client = _selectedClients[index];
//                     return Card(
//                       margin: const EdgeInsets.only(bottom: 8),
//                       child: ListTile(
//                         title: GetBuilder<ProjectController>(
//                           builder: (projectController) {
//                             final clientData =
//                                 projectController.clients.firstWhere(
//                               (c) => c.sId == client['client_id'],
//                               orElse: () => ClientModel(),
//                             );
//                             return Text(
//                                 'Client Name: ${clientData.name ?? ""}');
//                           },
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                                 'Commission: ${client['commission']?.toString() ?? ""}%'),
//                             const SizedBox(height: 4),
//                             ...(client['vacancies'] as Map<String, dynamic>)
//                                 .entries
//                                 .map(
//                                   (e) => Text(
//                                       '${e.key} - Vacancies: ${e.value['count'] ?? ""}, Target CV: ${e.value['target_cv'] ?? ""}'),
//                                 ),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () => _editClient(index),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 setState(() {
//                                   _selectedClients.removeAt(index);
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               if (_selectedClients.isEmpty)
//                 const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.people_outline, size: 64, color: Colors.grey),
//                       SizedBox(height: 16),
//                       CustomText(text: 'No clients added yet'),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _validateAndSubmit() async {
//     // First validate the form
//     if (_tabController.index != 0) {
//       setState(() {
//         _tabController.index = 0;
//       });
//       // Wait for the tab to switch and widgets to rebuild
//       await Future.delayed(const Duration(milliseconds: 100));
//     }

//     if (!_formKey.currentState!.validate()) {
//       CustomToast.showToast(
//           context: context, message: "Please fill all required fields");
//       return;
//     }
//     // Then check if clients are selected
//     if (_selectedClients.isEmpty && !widget.isEditMode) {
//       CustomToast.showToast(
//           context: context, message: "Please add at least one client");
//       return;
//     }

//     // Prepare vacancy data
//     final vacancyData = {
//       "project_id": projectId.trim(),
//       'status': 'ACTIVE',
//       "job_title": _jobTitleController.text.trim(),
//       "job_category": _jobVacancyController.text.trim(),
//       "qualifications": qualification,
//       "experience": _experienceController.text.trim(),
//       "skills": _skillsController.text.trim(),
//       "salary_from": _salaryFromController.text.trim(),
//       "salary_to": _salaryToController.text.trim(),
//       "lastdatetoapply": _lastDateToApplyController.text.trim(),
//       "description": _descriptionController.text.trim(),
//       "country": _countryController,
//       "city": _cityController.text.trim(),
//       if (!widget.isEditMode)
//         "clients": _selectedClients.map((client) {
//           return {
//             "client_id": client['client_id'] ?? '',
//             "commission": client['commission'] ?? 0,
//             "vacancies": client['vacancies'] ?? {},
//           };
//         }).toList(),
//     };

//     try {
//       bool success;
//       showLoaderDialog(context);
//       if (widget.isEditMode) {
//         success = await _projectController.editVacancy(
//             context: context,
//             vacancyId: widget.vacancy?.id ?? '',
//             vacancy: vacancyData);
//       } else {
//         success = await _projectController.createVacancy(
//             context: context, vacancy: vacancyData);
//       }
//       Navigator.pop(context);

//       if (success) {
//         Navigator.pop(context);
//         CustomToast.showToast(
//           context: context,
//           message: widget.isEditMode
//               ? "Vacancy updated successfully"
//               : "Vacancy created successfully",
//         );
//       } else {
//         CustomToast.showToast(
//           context: context,
//           message: widget.isEditMode
//               ? "Failed to update vacancy"
//               : "Failed to create vacancy",
//           backgroundColor: Colors.red,
//         );
//       }
//     } catch (e) {
//       CustomToast.showToast(
//         context: context,
//         message: "An error occurred: ${e.toString()}",
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   void _showAddClientDialog() {
//     _searchController.clear();
//     specializationDropdownItems = _configController.configData.value.specialized
//             ?.where((item) =>
//                 item.category?.trim() == _jobVacancyController.text.trim())
//             .map((item) => item.name.toString())
//             .toList() ??
//         [];

//     showDialog(
//       context: context,
//       builder: (context) {
//         // Filter out already selected clients
//         final filteredClients = _projectController.clients
//             .where((client) => !_selectedClients
//                 .any((selected) => selected['client_id'] == client.sId))
//             .toList();

//         // For search, we need a local list to mutate
//         List<ClientModel> localFilteredClients = List.from(filteredClients);

//         return StatefulBuilder(
//           builder: (context, setDialogState) => Dialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.7,
//               height: MediaQuery.of(context).size.height * 0.8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       gradient: AppColors.buttonGraidentColour,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.person_add,
//                             color: Colors.white, size: 24),
//                         const SizedBox(width: 12),
//                         const CustomText(
//                           text: 'Add Clients to Project',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: const Icon(Icons.close, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Search Section
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     color: Colors.grey.shade50,
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: 'Search clients by name or email...',
//                         prefixIcon:
//                             const Icon(Icons.search, color: Colors.grey),
//                         suffixIcon: _searchController.text.isNotEmpty
//                             ? IconButton(
//                                 icon: const Icon(Icons.clear),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   setDialogState(() {
//                                     localFilteredClients =
//                                         List.from(filteredClients);
//                                   });
//                                 },
//                               )
//                             : null,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       onChanged: (query) {
//                         setDialogState(() {
//                           if (query.isEmpty) {
//                             localFilteredClients = List.from(filteredClients);
//                           } else {
//                             localFilteredClients = filteredClients
//                                 .where((client) =>
//                                     (client.name
//                                             ?.toLowerCase()
//                                             .contains(query.toLowerCase()) ??
//                                         false) ||
//                                     (client.email
//                                             ?.toLowerCase()
//                                             .contains(query.toLowerCase()) ??
//                                         false))
//                                 .toList();
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                   // Results Count
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Row(
//                       children: [
//                         Icon(Icons.info_outline,
//                             size: 16, color: Colors.grey.shade600),
//                         const SizedBox(width: 8),
//                         CustomText(
//                           text:
//                               '${localFilteredClients.length} clients available',
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Client List
//                   Expanded(
//                     child: localFilteredClients.isEmpty
//                         ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.search_off,
//                                   size: 64,
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 const SizedBox(height: 16),
//                                 CustomText(
//                                   text: _searchController.text.isEmpty
//                                       ? 'No clients available'
//                                       : 'No clients found matching "${_searchController.text}"',
//                                   fontSize: 16,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ListView.separated(
//                             padding: const EdgeInsets.all(16),
//                             itemCount: localFilteredClients.length,
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(height: 8),
//                             itemBuilder: (context, index) {
//                               final client = localFilteredClients[index];
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       spreadRadius: 1,
//                                       blurRadius: 4,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ListTile(
//                                   contentPadding: const EdgeInsets.all(16),
//                                   leading: CircleAvatar(
//                                     backgroundColor: Colors.blue.shade100,
//                                     child: CustomText(
//                                       text: client.name?[0].toUpperCase() ?? '',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.blue.shade700,
//                                     ),
//                                   ),
//                                   title: CustomText(
//                                     text: client.name ?? '',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                   subtitle: CustomText(
//                                     text: client.email ?? '',
//                                     color: Colors.grey.shade600,
//                                     fontSize: 14,
//                                   ),
//                                   trailing: Container(
//                                     decoration: BoxDecoration(
//                                       gradient: AppColors.greenGradient,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: ElevatedButton.icon(
//                                       onPressed: () {
//                                         _showClientDetailsDialog(
//                                           client,
//                                           setDialogState,
//                                           isEditing: false,
//                                         );
//                                       },
//                                       icon: const Icon(Icons.add, size: 18),
//                                       label: const CustomText(
//                                         text: 'Add',
//                                         color: Colors.white,
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.transparent,
//                                         foregroundColor: Colors.white,
//                                         shadowColor: Colors.transparent,
//                                         elevation: 0,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _editClient(int index) {
//     final clientData = _selectedClients[index];
//     final clientId = clientData['client_id'];

//     // Find the client model
//     final client = _projectController.clients.firstWhere(
//       (c) => c.sId == clientId,
//       orElse: () => ClientModel(),
//     );

//     _showClientDetailsDialog(
//       client,
//       (fn) => setState(fn),
//       isEditing: true,
//       clientData: clientData,
//       index: index,
//     );
//   }

//   void _showClientDetailsDialog(
//     ClientModel client,
//     Function(void Function()) setDialogState, {
//     bool isEditing = false,
//     Map<String, dynamic>? clientData,
//     int? index,
//   }) {
//     _vacancyController.clear();
//     _targetCvController.clear();
//     _commissionController.clear();
//     specializedSelection = '';
//     List<Map<String, dynamic>> addedSpecializations = [];

//     // If editing, pre-fill the data
//     if (isEditing && clientData != null) {
//       _commissionController.text = clientData['commission'].toString();

//       // Add existing specializations
//       final vacancies = clientData['vacancies'] as Map<String, dynamic>;
//       vacancies.forEach((key, value) {
//         addedSpecializations.add({
//           'name': key,
//           'count': value['count'],
//           'target_cv': value['target_cv'],
//         });
//       });
//     }

//     specializationDropdownItems = _configController.configData.value.specialized
//             ?.where((item) =>
//                 item.category?.trim() == _jobVacancyController.text.trim())
//             .map((item) => item.name.toString())
//             .toList() ??
//         [];

//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Container(
//             width: 450,
//             padding: const EdgeInsets.all(24),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Header with client info
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundColor: AppColors.orangeSecondaryColor,
//                         child: CustomText(
//                           text: client.name?[0].toUpperCase() ?? '',
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: client.name ?? '',
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             CustomText(
//                               text: client.email ?? '',
//                               fontSize: 14,
//                               color: Colors.grey.shade600,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   // Commission
//                   CustomTextFormField(
//                     controller: _commissionController,
//                     label: 'Commission (%)',
//                     isRequired: true,
//                     keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true, signed: false),
//                     inputFormatters: [
//                       // Allow only numbers and decimal point
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'^\d*\.?\d{0,2}')),
//                     ],
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter commission';
//                       }
//                       if (double.tryParse(value) == null) {
//                         return 'Please enter a valid number';
//                       }
//                       if (double.parse(value) < 0 ||
//                           double.parse(value) > 100) {
//                         return 'Commission must be between 0-100';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   // Specialization Inputs
//                   CustomDropdownField(
//                     label: 'Specialized',
//                     value: specializedSelection,
//                     items: specializationDropdownItems,
//                     onChanged: (value) {
//                       setState(() {
//                         specializedSelection = value ?? '';
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _vacancyController,
//                     label: 'Number of Vacancies',
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return null;
//                       }
//                       final intValue = int.tryParse(value.trim());
//                       if (intValue == null) {
//                         return 'Please enter a valid number';
//                       }
//                       if (intValue <= 0) {
//                         return 'Number must be greater than 0';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _targetCvController,
//                     label: 'Target CV',
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return null;
//                       }
//                       if (int.tryParse(value) == null) {
//                         return 'Please enter a valid number';
//                       }
//                       if (int.parse(value) <= 0) {
//                         return 'Must be greater than 0';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   CustomActionButton(
//                     text: 'Add Specialization',
//                     icon: Icons.add,
//                     onPressed: () {
//                       if (specializedSelection.isEmpty) {
//                         CustomToast.showToast(
//                           context: context,
//                           message: "Please select specialization",
//                           backgroundColor: Colors.red,
//                         );
//                         return;
//                       }
//                       if (_vacancyController.text.isEmpty) {
//                         CustomToast.showToast(
//                           context: context,
//                           message: "Please enter number of vacancies",
//                           backgroundColor: Colors.red,
//                         );
//                         return;
//                       }
//                       if (_targetCvController.text.isEmpty) {
//                         CustomToast.showToast(
//                           context: context,
//                           message: "Please enter target CV",
//                           backgroundColor: Colors.red,
//                         );
//                         return;
//                       }
//                       if (int.parse(_targetCvController.text) <
//                           int.parse(_vacancyController.text)) {
//                         CustomToast.showToast(
//                           context: context,
//                           message:
//                               "Target CV must be greater than or equal to number of vacancies",
//                           backgroundColor: Colors.red,
//                         );
//                         return;
//                       }
//                       bool alreadyAdded = addedSpecializations.any((spec) =>
//                           spec['name'].toString().toLowerCase() ==
//                           specializedSelection.toLowerCase());
//                       if (alreadyAdded) {
//                         addedSpecializations.removeWhere((s) =>
//                             s['name'].toString().toLowerCase() ==
//                             specializedSelection.toLowerCase());
//                       }
//                       // if (!alreadyAdded) {
//                       setState(() {
//                         addedSpecializations.add({
//                           'name': specializedSelection,
//                           'count': int.parse(_vacancyController.text),
//                           'target_cv': int.parse(_targetCvController.text),
//                         });
//                         specializedSelection = '';
//                         _vacancyController.clear();
//                         _targetCvController.clear();
//                       });
//                       // }
//                       // else {
//                       //   CustomToast.showToast(
//                       //     context: context,
//                       //     message: "Specialization already added",
//                       //     backgroundColor: AppColors.greenSecondaryColor,
//                       //   );
//                       // }
//                     },
//                     isFilled: true,
//                     gradient: AppColors.orangeGradient,
//                   ),
//                   const SizedBox(height: 16),
//                   // Show Added Specializations List
//                   if (addedSpecializations.isNotEmpty)
//                     Column(
//                       children: [
//                         const Divider(),
//                         ...addedSpecializations.map((spec) => ListTile(
//                               title: Text(spec['name']),
//                               subtitle: Text(
//                                   'Vacancies: ${spec['count']}, Target CV: ${spec['target_cv']}'),
//                               trailing: ConstrainedBox(
//                                 constraints: BoxConstraints(
//                                   maxWidth:
//                                       MediaQuery.of(context).size.width * 0.3,
//                                   minHeight: 50,
//                                 ),
//                                 child: Flexible(
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             specializedSelection = spec['name'];
//                                             _vacancyController.text =
//                                                 spec['count'].toString();
//                                             _targetCvController.text =
//                                                 spec['target_cv'].toString();
//                                             // addedSpecializations.removeWhere(
//                                             //     (s) => s['name'] == spec['name']);
//                                           });
//                                         },
//                                         icon: const Icon(Icons.edit,
//                                             color: Colors.blue),
//                                       ),
//                                       IconButton(
//                                         icon: const Icon(Icons.delete,
//                                             color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             addedSpecializations.remove(spec);
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )),
//                         const Divider(),
//                       ],
//                     ),
//                   const SizedBox(height: 16),
//                   // Action Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomActionButton(
//                           text: 'Cancel',
//                           icon: Icons.close,
//                           onPressed: () => Navigator.pop(context),
//                           isFilled: false,
//                           textColor: Colors.blue.shade600,
//                           borderColor: Colors.blue.shade100,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: CustomActionButton(
//                           text: isEditing ? 'Update Client' : 'Add Client',
//                           icon: Icons.check,
//                           onPressed: () {
//                             if (addedSpecializations.isEmpty) {
//                               CustomToast.showToast(
//                                 context: context,
//                                 message:
//                                     'Please add at least one specialization',
//                                 backgroundColor: Colors.red,
//                               );
//                               return;
//                             }

//                             if (_commissionController.text.isEmpty) {
//                               CustomToast.showToast(
//                                 context: context,
//                                 message: 'Please enter commission',
//                                 backgroundColor: Colors.red,
//                               );
//                               return;
//                             }

//                             final Map<String, dynamic> vacanciesMap = {
//                               for (var spec in addedSpecializations)
//                                 spec['name']: {
//                                   'count': spec['count'],
//                                   'target_cv': spec['target_cv'],
//                                 }
//                             };

//                             if (isEditing && index != null) {
//                               // Update existing client
//                               // setState(() {
//                               //   _selectedClients[index] = {
//                               //     'client_id': client.sId ?? '',
//                               //     'commission':
//                               //         double.parse(_commissionController.text),
//                               //     'vacancies': vacanciesMap,
//                               //   };
//                               // });
//                               _editClientWithVacancies(
//                                 client.sId ?? '',
//                                 double.parse(_commissionController.text),
//                                 vacanciesMap,
//                                 index,
//                               );
//                             } else {
//                               // Add new client
//                               _addClientWithVacancies(
//                                 client.sId ?? '',
//                                 double.parse(_commissionController.text),
//                                 vacanciesMap,
//                               );
//                             }

//                             Navigator.pop(context); // Close details dialog
//                             if (!isEditing) {
//                               Navigator.pop(
//                                   context); // Close client selection dialog
//                             }
//                           },
//                           isFilled: true,
//                           gradient: AppColors.orangeGradient,
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

//   void _addClientWithVacancies(
//       String clientId, double commission, Map<String, dynamic> vacancies) {
//     setState(() {
//       _selectedClients.add({
//         'client_id': clientId,
//         'commission': commission,
//         'vacancies': vacancies.isNotEmpty ? vacancies : {},
//       });
//     });
//   }

//   void _editClientWithVacancies(String clientId, double commission,
//       Map<String, dynamic> vacancies, int index) {
//     setState(() {
//       _selectedClients[index] = {
//         'client_id': clientId,
//         'commission': commission,
//         'vacancies': vacancies.isNotEmpty ? vacancies : {},
//       };
//     });
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:overseas_front_end/controller/project/project_controller.dart';
// // import 'package:overseas_front_end/model/project/client_model.dart';
// // import 'package:overseas_front_end/utils/style/colors/colors.dart';
// // import 'package:overseas_front_end/view/widgets/widgets.dart';
// // import '../../../../controller/config/config_controller.dart';
// // import '../../../../model/project/vacancy_model.dart';
// // import '../../../widgets/custom_toast.dart';

// // class CreateEditVacancyPopup extends StatefulWidget {
// //   final bool isEditMode;
// //   final VacancyModel? vacancy;

// //   const CreateEditVacancyPopup({
// //     super.key,
// //     this.isEditMode = false,
// //     this.vacancy,
// //   });

// //   @override
// //   State<CreateEditVacancyPopup> createState() =>
// //       _ProjectClientManagementScreenState();
// // }

// // class _ProjectClientManagementScreenState extends State<CreateEditVacancyPopup>
// //     with SingleTickerProviderStateMixin {
// //   final TextEditingController _jobTitleController = TextEditingController();
// //   final TextEditingController _jobVacancyController = TextEditingController();
// //   final TextEditingController _experienceController = TextEditingController();
// //   final TextEditingController _skillsController = TextEditingController();
// //   final TextEditingController _salaryFromController = TextEditingController();
// //   final TextEditingController _salaryToController = TextEditingController();
// //   final TextEditingController _organizationNameController =
// //       TextEditingController();
// //   final TextEditingController _organizationCategoryController =
// //       TextEditingController();
// //   final TextEditingController _lastDateToApplyController =
// //       TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   String _countryController = '';
// //   final TextEditingController _cityController = TextEditingController();

// //   List<String> qualification = [];
// //   List<Map<String, dynamic>> _selectedClients = [];
// //   String clients = '';
// //   String projectList = '';
// //   String projectId = '';
// //   late TabController _tabController;
// //   late List<String> specializationDropdownItems;
// //   final TextEditingController _searchController = TextEditingController();
// //   final TextEditingController _vacancyController = TextEditingController();
// //   final TextEditingController _targetCvController = TextEditingController();
// //   final TextEditingController _commissionController = TextEditingController();
// //   final _configController = Get.find<ConfigController>();
// //   final _projectController = Get.find<ProjectController>();
// //   String specializedSelection = '';

// //   // Form key for validation
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// //   @override
// //   void initState() {
// //     _initializeFields();
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //   }

// //   void _initializeFields() {
// //     if (widget.isEditMode && widget.vacancy != null) {
// //       projectId = widget.vacancy?.project?.sId ?? '';
// //       _countryController = widget.vacancy?.country ?? "";
// //       _cityController.text = widget.vacancy?.city ?? "";
// //       projectList = widget.vacancy?.project?.projectName ?? '';
// //       _organizationCategoryController.text =
// //           widget.vacancy?.project?.organizationCategory ?? "";
// //       _jobTitleController.text = widget.vacancy?.jobTitle ?? "";
// //       _jobVacancyController.text = widget.vacancy?.jobCategory ?? "";
// //       qualification =
// //           widget.vacancy?.qualifications?.map((item) => item).toList() ?? [];
// //       _experienceController.text = widget.vacancy?.experience ?? '';
// //       _salaryFromController.text = widget.vacancy?.salaryFrom.toString() ?? '';
// //       _salaryToController.text = widget.vacancy?.salaryTo.toString() ?? '';
// //       _lastDateToApplyController.text = widget.vacancy?.lastDateToApply ?? '';
// //       _descriptionController.text = widget.vacancy?.description ?? "";
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     _jobTitleController.dispose();
// //     _jobVacancyController.dispose();
// //     _experienceController.dispose();
// //     _skillsController.dispose();
// //     _salaryFromController.dispose();
// //     _salaryToController.dispose();
// //     _organizationNameController.dispose();
// //     _organizationCategoryController.dispose();
// //     _lastDateToApplyController.dispose();
// //     _descriptionController.dispose();
// //     _cityController.dispose();
// //     _searchController.dispose();
// //     _vacancyController.dispose();
// //     _targetCvController.dispose();
// //     _commissionController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       backgroundColor: Colors.transparent,
// //       insetPadding: const EdgeInsets.all(16),
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final maxWidth = constraints.maxWidth;
// //           final maxHeight = constraints.maxHeight;

// //           double dialogWidth = maxWidth > 1400
// //               ? maxWidth * 0.8
// //               : maxWidth > 1000
// //                   ? maxWidth * 0.9
// //                   : maxWidth;

// //           return Center(
// //             child: Container(
// //               width: dialogWidth,
// //               height: maxHeight * 0.9,
// //               constraints: const BoxConstraints(
// //                 minWidth: 320,
// //                 maxWidth: 1600,
// //                 minHeight: 600,
// //               ),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: AppColors.primaryColor.withOpacity(0.15),
// //                     blurRadius: 40,
// //                     offset: const Offset(0, 20),
// //                   ),
// //                 ],
// //               ),
// //               child: Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   children: [
// //                     // Header
// //                     Container(
// //                       height: 80,
// //                       padding: const EdgeInsets.symmetric(horizontal: 24),
// //                       decoration: BoxDecoration(
// //                         gradient: LinearGradient(
// //                           colors: [
// //                             AppColors.primaryColor,
// //                             AppColors.primaryColor.withOpacity(0.85),
// //                           ],
// //                         ),
// //                         borderRadius: const BorderRadius.vertical(
// //                           top: Radius.circular(20),
// //                         ),
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           Container(
// //                             padding: const EdgeInsets.all(10),
// //                             decoration: BoxDecoration(
// //                               color: Colors.white.withOpacity(0.15),
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                             child: const Icon(
// //                               Icons.business_center_outlined,
// //                               size: 22,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 16),
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 CustomText(
// //                                   text: widget.isEditMode
// //                                       ? 'Edit Vacancy'
// //                                       : 'Create Vacancy',
// //                                   fontSize: 20,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Colors.white,
// //                                 ),
// //                                 const CustomText(
// //                                   text: 'Manage Vacancy details',
// //                                   fontSize: 13,
// //                                   color: Colors.white70,
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           IconButton(
// //                             icon: const Icon(Icons.close_rounded,
// //                                 color: Colors.white, size: 26),
// //                             onPressed: () => Navigator.of(context).pop(),
// //                             tooltip: 'Close',
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Row(
// //                         children: [
// //                           Expanded(
// //                             child: Column(
// //                               children: [
// //                                 Padding(
// //                                   padding: const EdgeInsets.symmetric(
// //                                       horizontal: 16, vertical: 8),
// //                                   child: SizedBox(
// //                                     height: 44,
// //                                     child: Row(
// //                                       children: [
// //                                         Expanded(
// //                                           child: Padding(
// //                                             padding: const EdgeInsets.symmetric(
// //                                                 horizontal: 16),
// //                                             child: DecoratedBox(
// //                                               decoration: BoxDecoration(
// //                                                 gradient: _tabController
// //                                                             .index ==
// //                                                         0
// //                                                     ? LinearGradient(
// //                                                         colors: [
// //                                                           AppColors
// //                                                               .primaryColor,
// //                                                           AppColors.primaryColor
// //                                                               .withOpacity(0.7),
// //                                                         ],
// //                                                       )
// //                                                     : null,
// //                                                 color: _tabController.index == 0
// //                                                     ? null
// //                                                     : Colors.grey.shade100,
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(12),
// //                                               ),
// //                                               child: TextButton.icon(
// //                                                 style: TextButton.styleFrom(
// //                                                   backgroundColor:
// //                                                       Colors.transparent,
// //                                                   shape: RoundedRectangleBorder(
// //                                                     borderRadius:
// //                                                         BorderRadius.circular(
// //                                                             12),
// //                                                   ),
// //                                                   shadowColor:
// //                                                       Colors.transparent,
// //                                                 ),
// //                                                 icon: Icon(
// //                                                   Icons.work_outline,
// //                                                   size: 20,
// //                                                   color: _tabController.index ==
// //                                                           0
// //                                                       ? AppColors
// //                                                           .textWhiteColour
// //                                                       : AppColors.primaryColor,
// //                                                 ),
// //                                                 label: Text(
// //                                                   'Vacancy Details',
// //                                                   style: TextStyle(
// //                                                     fontWeight: FontWeight.bold,
// //                                                     fontSize: 16,
// //                                                     color:
// //                                                         _tabController.index ==
// //                                                                 0
// //                                                             ? AppColors
// //                                                                 .textWhiteColour
// //                                                             : AppColors
// //                                                                 .primaryColor,
// //                                                   ),
// //                                                 ),
// //                                                 onPressed: () {
// //                                                   setState(() {
// //                                                     _tabController.index = 0;
// //                                                   });
// //                                                 },
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         if (!widget.isEditMode)
// //                                           Expanded(
// //                                             child: Padding(
// //                                               padding:
// //                                                   const EdgeInsets.symmetric(
// //                                                       horizontal: 16),
// //                                               child: DecoratedBox(
// //                                                 decoration: BoxDecoration(
// //                                                   gradient:
// //                                                       _tabController.index == 1
// //                                                           ? LinearGradient(
// //                                                               colors: [
// //                                                                 AppColors
// //                                                                     .primaryColor,
// //                                                                 AppColors
// //                                                                     .primaryColor
// //                                                                     .withOpacity(
// //                                                                         0.7),
// //                                                               ],
// //                                                             )
// //                                                           : null,
// //                                                   color: _tabController.index ==
// //                                                           1
// //                                                       ? null
// //                                                       : Colors.grey.shade100,
// //                                                   borderRadius:
// //                                                       BorderRadius.circular(12),
// //                                                 ),
// //                                                 child: TextButton.icon(
// //                                                   style: TextButton.styleFrom(
// //                                                     backgroundColor:
// //                                                         Colors.transparent,
// //                                                     shape:
// //                                                         RoundedRectangleBorder(
// //                                                       borderRadius:
// //                                                           BorderRadius.circular(
// //                                                               12),
// //                                                     ),
// //                                                     shadowColor:
// //                                                         Colors.transparent,
// //                                                   ),
// //                                                   icon: Icon(
// //                                                     Icons.people_outline,
// //                                                     size: 20,
// //                                                     color:
// //                                                         _tabController.index ==
// //                                                                 1
// //                                                             ? AppColors
// //                                                                 .textWhiteColour
// //                                                             : AppColors
// //                                                                 .primaryColor,
// //                                                   ),
// //                                                   label: Text(
// //                                                     'Client',
// //                                                     style: TextStyle(
// //                                                       fontWeight:
// //                                                           FontWeight.bold,
// //                                                       fontSize: 16,
// //                                                       color: _tabController
// //                                                                   .index ==
// //                                                               1
// //                                                           ? AppColors
// //                                                               .textWhiteColour
// //                                                           : AppColors
// //                                                               .primaryColor,
// //                                                     ),
// //                                                   ),
// //                                                   onPressed: () {
// //                                                     setState(() {
// //                                                       _tabController.index = 1;
// //                                                     });
// //                                                   },
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: TabBarView(
// //                                     controller: _tabController,
// //                                     children: [
// //                                       // Vacancy Details Tab
// //                                       _buildVacancyDetailsTab(context),

// //                                       _buildClientManagementTab(),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: const EdgeInsets.all(8.0),
// //                                   child: Row(
// //                                     children: [
// //                                       const SizedBox(width: 16),
// //                                       Expanded(
// //                                         child: CustomActionButton(
// //                                           text: 'Cancel',
// //                                           icon: Icons.close_rounded,
// //                                           textColor: Colors.grey,
// //                                           onPressed: () =>
// //                                               Navigator.pop(context),
// //                                           borderColor: Colors.grey.shade300,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(width: 16),
// //                                       Expanded(
// //                                         flex: 2,
// //                                         child: CustomActionButton(
// //                                           text: widget.isEditMode
// //                                               ? 'Update Vacancy'
// //                                               : 'Create Vacancy',
// //                                           icon: Icons.save_rounded,
// //                                           isFilled: true,
// //                                           gradient: const LinearGradient(
// //                                             colors: [
// //                                               Color(0xFF7F00FF),
// //                                               Color(0xFFE100FF)
// //                                             ],
// //                                           ),
// //                                           onPressed: _validateAndSubmit,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildVacancyDetailsTab(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final availableWidth = constraints.maxWidth;
// //         int columnsCount = availableWidth > 1000 ? 3 : 2;
// //         return SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SectionTitle(
// //                   title: 'Project Details',
// //                   icon: Icons.info_outline_rounded,
// //                 ),
// //                 const SizedBox(height: 16),
// //                 ResponsiveGrid(
// //                   columns: columnsCount,
// //                   children: [
// //                     if (!widget.isEditMode)
// //                       CustomDropdownField(
// //                         isSplit: true,
// //                         label: "Project",
// //                         value: projectList,
// //                         items: (_projectController.projects
// //                                 .where((project) =>
// //                                     project.projectName != null &&
// //                                     project.projectName!.isNotEmpty)
// //                                 .map((project) =>
// //                                     '${project.projectName}, ${project.sId}')
// //                                 .toList() ??
// //                             []),
// //                         isRequired: true,
// //                         onChanged: (value) {
// //                           setState(() {
// //                             projectList = value ?? '';
// //                             projectId = value?.split(',').last ?? '';
// //                           });
// //                         },
// //                       ),
// //                     if (widget.isEditMode)
// //                       CustomText(
// //                         text: projectList,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       )
// //                   ],
// //                 ),
// //                 const SizedBox(height: 16),
// //                 const SectionTitle(
// //                   title: 'Job Details',
// //                   icon: Icons.info_outline_rounded,
// //                 ),
// //                 const SizedBox(height: 16),
// //                 ResponsiveGrid(
// //                   columns: columnsCount,
// //                   children: [
// //                     // CustomTextFormField(
// //                     //   label: 'Job Title',
// //                     //   controller: _jobTitleController,
// //                     //   validator: (value) {
// //                     //     if (value == null || value.isEmpty) {
// //                     //       return 'Please enter job title';
// //                     //     }
// //                     //     return null;
// //                     //   },
// //                     // ),
// //                     CustomDropdownField(
// //                       label: 'Job category',
// //                       value: _jobVacancyController.text.trim(),
// //                       items: _configController.configData.value.jobCategory
// //                               ?.map((item) => item.name.toString().trim())
// //                               .toList() ??
// //                           [],
// //                       isRequired: true,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           _jobVacancyController.text = value ?? '';
// //                         });
// //                       },
// //                     ),

// //                     CustomMultiSelectDropdownField(
// //                       isRequired: true,
// //                       isSplit: false,
// //                       label: "Qualification",
// //                       selectedItems: qualification,
// //                       items: _configController.configData.value.program
// //                               ?.map((item) => "${item.name}")
// //                               .toList() ??
// //                           [],
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please select at least one qualification';
// //                         }
// //                         return null;
// //                       },
// //                       onChanged: (selectedList) {
// //                         setState(() {
// //                           qualification = selectedList;
// //                         });
// //                       },
// //                     ),
// //                     CustomTextFormField(
// //                       label: 'Experience',
// //                       controller: _experienceController,
// //                       keyboardType: TextInputType.number,
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return null;
// //                         }
// //                         if (double.tryParse(value) == null) {
// //                           return 'Please enter a valid number';
// //                         }
// //                         if (double.parse(value) < 0 ||
// //                             double.parse(value) > 70) {
// //                           return 'Experience must be valid';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     CustomTextFormField(
// //                       label: 'Skills',
// //                       controller: _skillsController,
// //                     ),
// //                     CustomTextFormField(
// //                       label: 'Salary From',
// //                       controller: _salaryFromController,
// //                       keyboardType: TextInputType.number,
// //                     ),
// //                     CustomTextFormField(
// //                       label: 'Salary To',
// //                       controller: _salaryToController,
// //                       keyboardType: TextInputType.number,
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return null;
// //                         }
// //                         if (double.tryParse(value) == null) {
// //                           return 'Please enter a valid number';
// //                         }
// //                         if (_salaryFromController.text.isNotEmpty &&
// //                             double.parse(value) <
// //                                 double.parse(_salaryFromController.text)) {
// //                           return 'Salary to must be greater than salary from';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     CustomDateField(
// //                       isRequired: true,
// //                       label: "Last Date To Apply",
// //                       initialDate: DateTime.now(),
// //                       controller: _lastDateToApplyController,
// //                     ),
// //                     CustomTextFormField(
// //                       label: 'Description',
// //                       controller: _descriptionController,
// //                       maxLines: 1,
// //                       validator: (value) {
// //                         // if (value == null || value.isEmpty) {
// //                         //   return 'Please enter description';
// //                         // }
// //                         // if (value.length < 5) {
// //                         //   return 'Description should be valid';
// //                         // }
// //                         return null;
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 16),
// //                 const SectionTitle(
// //                   title: 'Country Details',
// //                   icon: Icons.info_outline_rounded,
// //                 ),
// //                 const SizedBox(height: 5),
// //                 ResponsiveGrid(
// //                   alignment: WrapAlignment.spaceEvenly,
// //                   columns: columnsCount,
// //                   children: [
// //                     CustomDropdownField(
// //                       label: "Country",
// //                       value: _countryController,
// //                       items: _configController.configData.value.country
// //                               ?.map((item) => "${item.name}")
// //                               .toList() ??
// //                           [],
// //                       isRequired: true,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           _countryController = value!;
// //                         });
// //                       },
// //                     ),
// //                     CustomTextFormField(
// //                       label: "City",
// //                       controller: _cityController,
// //                       validator: (value) {
// //                         return null;
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildClientManagementTab() {
// //     return Column(
// //       children: [
// //         // Header
// //         Container(
// //           padding: const EdgeInsets.all(16),
// //           decoration: const BoxDecoration(
// //             gradient: AppColors.buttonGraidentColour,
// //           ),
// //           child: Row(
// //             children: [
// //               const Icon(Icons.people, color: Colors.white),
// //               const SizedBox(width: 8),
// //               const CustomText(
// //                 text: 'Client Management',
// //                 color: Colors.white,
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               const Spacer(),
// //               ElevatedButton.icon(
// //                 onPressed: _showAddClientDialog,
// //                 icon: const Icon(Icons.add),
// //                 label: const CustomText(text: 'Add Client'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.blue.shade600,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),

// //         Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 'Selected Clients',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //               ),
// //               const SizedBox(height: 8),
// //               if (_selectedClients.isNotEmpty)
// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   itemCount: _selectedClients.length,
// //                   itemBuilder: (context, index) {
// //                     final client = _selectedClients[index];
// //                     return Card(
// //                       margin: const EdgeInsets.only(bottom: 8),
// //                       child: ListTile(
// //                         title: GetBuilder<ProjectController>(
// //                           builder: (projectController) {
// //                             final clientData =
// //                                 projectController.clients.firstWhere(
// //                               (c) => c.sId == client['client_id'],
// //                               orElse: () => ClientModel(),
// //                             );
// //                             return Text(
// //                                 'Client Name: ${clientData.name ?? ""}');
// //                           },
// //                         ),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                                 'Commission: ${client['commission']?.toString() ?? ""}'),
// //                             const SizedBox(height: 4),
// //                             ...client['vacancies'].entries.map(
// //                                   (e) => Text(
// //                                       '${e.key} - Vacancies: ${e.value['count'] ?? ""}, Target CV: ${e.value['target_cv'] ?? ""}'),
// //                                 ),
// //                           ],
// //                         ),
// //                         trailing: IconButton(
// //                           icon: const Icon(Icons.delete, color: Colors.red),
// //                           onPressed: () {
// //                             setState(() {
// //                               _selectedClients.removeAt(index);
// //                             });
// //                           },
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               if (_selectedClients.isEmpty)
// //                 const Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(Icons.people_outline, size: 64, color: Colors.grey),
// //                       SizedBox(height: 16),
// //                       CustomText(text: 'No clients added yet'),
// //                     ],
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _validateAndSubmit() async {
// //     // First validate the form
// //     if (_tabController.index != 0) {
// //       setState(() {
// //         _tabController.index = 0;
// //       });
// //       // Wait for the tab to switch and widgets to rebuild
// //       await Future.delayed(const Duration(milliseconds: 100));
// //     }

// //     if (!_formKey.currentState!.validate()) {
// //       CustomToast.showToast(
// //           context: context, message: "Please fill all required fields");
// //       return;
// //     }
// //     // Then check if clients are selected
// //     if (_selectedClients.isEmpty && !widget.isEditMode) {
// //       CustomToast.showToast(
// //           context: context, message: "Please add at least one client");
// //       return;
// //     }

// //     // Prepare vacancy data
// //     final vacancyData = {
// //       "project_id": projectId.trim(),
// //       'status': 'ACTIVE',
// //       "job_title": _jobTitleController.text.trim(),
// //       "job_category": _jobVacancyController.text.trim(),
// //       "qualifications": qualification,
// //       "experience": _experienceController.text.trim(),
// //       "skills": _skillsController.text.trim(),
// //       "salary_from": _salaryFromController.text.trim(),
// //       "salary_to": _salaryToController.text.trim(),
// //       "lastdatetoapply": _lastDateToApplyController.text.trim(),
// //       "description": _descriptionController.text.trim(),
// //       "country": _countryController,
// //       "city": _cityController.text.trim(),
// //       if (!widget.isEditMode)
// //         "clients": _selectedClients.map((client) {
// //           return {
// //             "client_id": client['client_id'] ?? '',
// //             "commission": client['commission'] ?? 0,
// //             "vacancies": client['vacancies'] ?? {},
// //           };
// //         }).toList(),
// //     };

// //     try {
// //       bool success;
// //       showLoaderDialog(context);
// //       if (widget.isEditMode) {
// //         success = await _projectController.editVacancy(
// //             context: context,
// //             vacancyId: widget.vacancy?.id ?? '',
// //             vacancy: vacancyData);
// //       } else {
// //         success = await _projectController.createVacancy(
// //             context: context, vacancy: vacancyData);
// //       }
// //       Navigator.pop(context);

// //       if (success) {
// //         Navigator.pop(context);
// //         CustomToast.showToast(
// //           context: context,
// //           message: widget.isEditMode
// //               ? "Vacancy updated successfully"
// //               : "Vacancy created successfully",
// //         );
// //       } else {
// //         CustomToast.showToast(
// //           context: context,
// //           message: widget.isEditMode
// //               ? "Failed to update vacancy"
// //               : "Failed to create vacancy",
// //           backgroundColor: Colors.red,
// //         );
// //       }
// //     } catch (e) {
// //       CustomToast.showToast(
// //         context: context,
// //         message: "An error occurred: ${e.toString()}",
// //         backgroundColor: Colors.red,
// //       );
// //     }
// //   }

// //   void _showAddClientDialog() {
// //     _searchController.clear();
// //     // specializationDropdownItems = _configController.configData.value.specialized
// //     //         ?.where(
// //     //             (item) => item.category == _jobVacancyController.text.trim())
// //     //         .map((item) => item.name.toString())
// //     //         .toList() ??
// //     //     [];

// //     specializationDropdownItems = _configController.configData.value.specialized
// //             ?.where((item) =>
// //                 item.category?.trim() == _jobVacancyController.text.trim())
// //             .map((item) => item.name.toString())
// //             .toList() ??
// //         [];

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         // Filter out already selected clients
// //         final filteredClients = _projectController.clients
// //             .where((client) => !_selectedClients
// //                 .any((selected) => selected['client_id'] == client.sId))
// //             .toList();

// //         // For search, we need a local list to mutate
// //         List<ClientModel> localFilteredClients = List.from(filteredClients);

// //         return StatefulBuilder(
// //           builder: (context, setDialogState) => Dialog(
// //             shape:
// //                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //             child: Container(
// //               width: MediaQuery.of(context).size.width * 0.7,
// //               height: MediaQuery.of(context).size.height * 0.8,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(16),
// //                 color: Colors.white,
// //               ),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(20),
// //                     decoration: const BoxDecoration(
// //                       gradient: AppColors.buttonGraidentColour,
// //                       borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(16),
// //                         topRight: Radius.circular(16),
// //                       ),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         const Icon(Icons.person_add,
// //                             color: Colors.white, size: 24),
// //                         const SizedBox(width: 12),
// //                         const CustomText(
// //                           text: 'Add Clients to Project',
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white,
// //                         ),
// //                         const Spacer(),
// //                         IconButton(
// //                           onPressed: () => Navigator.pop(context),
// //                           icon: const Icon(Icons.close, color: Colors.white),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   // Search Section
// //                   Container(
// //                     padding: const EdgeInsets.all(16),
// //                     color: Colors.grey.shade50,
// //                     child: TextField(
// //                       controller: _searchController,
// //                       decoration: InputDecoration(
// //                         hintText: 'Search clients by name or email...',
// //                         prefixIcon:
// //                             const Icon(Icons.search, color: Colors.grey),
// //                         suffixIcon: _searchController.text.isNotEmpty
// //                             ? IconButton(
// //                                 icon: const Icon(Icons.clear),
// //                                 onPressed: () {
// //                                   _searchController.clear();
// //                                   setDialogState(() {
// //                                     localFilteredClients =
// //                                         List.from(filteredClients);
// //                                   });
// //                                 },
// //                               )
// //                             : null,
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                           borderSide: BorderSide.none,
// //                         ),
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         contentPadding: const EdgeInsets.symmetric(
// //                             horizontal: 16, vertical: 12),
// //                       ),
// //                       onChanged: (query) {
// //                         setDialogState(() {
// //                           if (query.isEmpty) {
// //                             localFilteredClients = List.from(filteredClients);
// //                           } else {
// //                             localFilteredClients = filteredClients
// //                                 .where((client) =>
// //                                     (client.name
// //                                             ?.toLowerCase()
// //                                             .contains(query.toLowerCase()) ??
// //                                         false) ||
// //                                     (client.email
// //                                             ?.toLowerCase()
// //                                             .contains(query.toLowerCase()) ??
// //                                         false))
// //                                 .toList();
// //                           }
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                   // Results Count
// //                   Container(
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.info_outline,
// //                             size: 16, color: Colors.grey.shade600),
// //                         const SizedBox(width: 8),
// //                         CustomText(
// //                           text:
// //                               '${localFilteredClients.length} clients available',
// //                           color: Colors.grey.shade600,
// //                           fontSize: 14,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   // Client List
// //                   Expanded(
// //                     child: localFilteredClients.isEmpty
// //                         ? Center(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 Icon(
// //                                   Icons.search_off,
// //                                   size: 64,
// //                                   color: Colors.grey.shade400,
// //                                 ),
// //                                 const SizedBox(height: 16),
// //                                 CustomText(
// //                                   text: _searchController.text.isEmpty
// //                                       ? 'No clients available'
// //                                       : 'No clients found matching "${_searchController.text}"',
// //                                   fontSize: 16,
// //                                   color: Colors.grey.shade600,
// //                                 ),
// //                               ],
// //                             ),
// //                           )
// //                         : ListView.separated(
// //                             padding: const EdgeInsets.all(16),
// //                             itemCount: localFilteredClients.length,
// //                             separatorBuilder: (context, index) =>
// //                                 const SizedBox(height: 8),
// //                             itemBuilder: (context, index) {
// //                               final client = localFilteredClients[index];
// //                               return Container(
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   border:
// //                                       Border.all(color: Colors.grey.shade200),
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Colors.grey.withOpacity(0.1),
// //                                       spreadRadius: 1,
// //                                       blurRadius: 4,
// //                                       offset: const Offset(0, 2),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 child: ListTile(
// //                                   contentPadding: const EdgeInsets.all(16),
// //                                   leading: CircleAvatar(
// //                                     backgroundColor: Colors.blue.shade100,
// //                                     child: CustomText(
// //                                       text: client.name?[0].toUpperCase() ?? '',
// //                                       fontWeight: FontWeight.bold,
// //                                       color: Colors.blue.shade700,
// //                                     ),
// //                                   ),
// //                                   title: CustomText(
// //                                     text: client.name ?? '',
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 16,
// //                                   ),
// //                                   subtitle: CustomText(
// //                                     text: client.email ?? '',
// //                                     color: Colors.grey.shade600,
// //                                     fontSize: 14,
// //                                   ),
// //                                   trailing: Container(
// //                                     decoration: BoxDecoration(
// //                                       gradient: AppColors.greenGradient,
// //                                       borderRadius: BorderRadius.circular(8),
// //                                     ),
// //                                     child: ElevatedButton.icon(
// //                                       onPressed: () {
// //                                         _showClientDetailsDialog(
// //                                           client,
// //                                           setDialogState,
// //                                         );
// //                                       },
// //                                       icon: const Icon(Icons.add, size: 18),
// //                                       label: const CustomText(
// //                                         text: 'Add',
// //                                         color: Colors.white,
// //                                       ),
// //                                       style: ElevatedButton.styleFrom(
// //                                         backgroundColor: Colors.transparent,
// //                                         foregroundColor: Colors.white,
// //                                         shadowColor: Colors.transparent,
// //                                         elevation: 0,
// //                                         shape: RoundedRectangleBorder(
// //                                           borderRadius:
// //                                               BorderRadius.circular(8),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showClientDetailsDialog(
// //     ClientModel client,
// //     Function(void Function()) setDialogState,
// //   ) {
// //     _vacancyController.clear();
// //     _targetCvController.clear();
// //     _commissionController.clear();
// //     specializedSelection = '';
// //     List<Map<String, dynamic>> addedSpecializations = [];

// //     showDialog(
// //       context: context,
// //       builder: (context) => StatefulBuilder(
// //         builder: (context, setState) => Dialog(
// //           shape:
// //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //           child: Container(
// //             width: 450,
// //             padding: const EdgeInsets.all(24),
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   // Header with client info
// //                   Row(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 25,
// //                         backgroundColor: AppColors.orangeSecondaryColor,
// //                         child: CustomText(
// //                           text: client.name?[0].toUpperCase() ?? '',
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white,
// //                           fontSize: 18,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             CustomText(
// //                               text: client.name ?? '',
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                             CustomText(
// //                               text: client.email ?? '',
// //                               fontSize: 14,
// //                               color: Colors.grey.shade600,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 24),
// //                   // Commission
// //                   CustomTextFormField(
// //                     controller: _commissionController,
// //                     label: 'Commission (%)',
// //                     isRequired: true,
// //                     keyboardType: const TextInputType.numberWithOptions(
// //                         decimal: true, signed: false),
// //                     inputFormatters: [
// //                       // Allow only numbers and decimal point
// //                       FilteringTextInputFormatter.allow(
// //                           RegExp(r'^\d*\.?\d{0,2}')),
// //                     ],
// //                     validator: (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter commission';
// //                       }
// //                       if (double.tryParse(value) == null) {
// //                         return 'Please enter a valid number';
// //                       }
// //                       if (double.parse(value) < 0 ||
// //                           double.parse(value) > 100) {
// //                         return 'Commission must be between 0-100';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   const SizedBox(height: 16),
// //                   // Specialization Inputs
// //                   CustomDropdownField(
// //                     label: 'Specialized',
// //                     value: specializedSelection,
// //                     items: specializationDropdownItems,
// //                     isRequired: true,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         specializedSelection = value ?? '';
// //                       });
// //                     },
// //                   ),
// //                   const SizedBox(height: 16),
// //                   CustomTextFormField(
// //                     controller: _vacancyController,
// //                     label: 'Number of Vacancies',
// //                     isRequired: true,
// //                     keyboardType: TextInputType.number,
// //                     validator: (value) {
// //                       if (value == null || value.trim().isEmpty) {
// //                         return null;
// //                       }
// //                       final intValue = int.tryParse(value.trim());
// //                       if (intValue == null) {
// //                         return 'Please enter a valid number';
// //                       }
// //                       if (intValue <= 0) {
// //                         return 'Number must be greater than 0';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   const SizedBox(height: 16),
// //                   CustomTextFormField(
// //                     controller: _targetCvController,
// //                     label: 'Target CV',
// //                     isRequired: true,
// //                     keyboardType: TextInputType.number,
// //                     validator: (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter target CV';
// //                       }
// //                       if (int.tryParse(value) == null) {
// //                         return 'Please enter a valid number';
// //                       }
// //                       if (int.parse(value) <= 0) {
// //                         return 'Must be greater than 0';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   const SizedBox(height: 16),
// //                   CustomActionButton(
// //                     text: 'Add Specialization',
// //                     icon: Icons.add,
// //                     onPressed: () {
// //                       if (specializedSelection.isEmpty) {
// //                         CustomToast.showToast(
// //                           context: context,
// //                           message: "Please select specialization",
// //                           backgroundColor: Colors.red,
// //                         );
// //                         return;
// //                       }
// //                       if (_vacancyController.text.isEmpty) {
// //                         CustomToast.showToast(
// //                           context: context,
// //                           message: "Please enter number of vacancies",
// //                           backgroundColor: Colors.red,
// //                         );
// //                         return;
// //                       }
// //                       if (_targetCvController.text.isEmpty) {
// //                         CustomToast.showToast(
// //                           context: context,
// //                           message: "Please enter target CV",
// //                           backgroundColor: Colors.red,
// //                         );
// //                         return;
// //                       }
// //                       if (int.parse(_targetCvController.text) <
// //                           int.parse(_vacancyController.text)) {
// //                         CustomToast.showToast(
// //                           context: context,
// //                           message:
// //                               "Target CV must be greater than or equal to number of vacancies",
// //                           backgroundColor: Colors.red,
// //                         );
// //                         return;
// //                       }
// //                       bool alreadyAdded = addedSpecializations.any((spec) =>
// //                           spec['name'].toString().toLowerCase() ==
// //                           specializedSelection.toLowerCase());
// //                       if (!alreadyAdded) {
// //                         setState(() {
// //                           addedSpecializations.add({
// //                             'name': specializedSelection,
// //                             'count': int.parse(_vacancyController.text),
// //                             'target_cv': int.parse(_targetCvController.text),
// //                           });
// //                           specializedSelection = '';
// //                           _vacancyController.clear();
// //                           _targetCvController.clear();
// //                         });
// //                       } else {
// //                         CustomToast.showToast(
// //                           context: context,
// //                           message: "Specialization already added",
// //                           backgroundColor: AppColors.greenSecondaryColor,
// //                         );
// //                       }
// //                     },
// //                     isFilled: true,
// //                     gradient: AppColors.orangeGradient,
// //                   ),
// //                   const SizedBox(height: 16),
// //                   // Show Added Specializations List
// //                   if (addedSpecializations.isNotEmpty)
// //                     Column(
// //                       children: [
// //                         const Divider(),
// //                         ...addedSpecializations.map((spec) => ListTile(
// //                               title: Text(spec['name']),
// //                               subtitle: Text(
// //                                   'Vacancies: ${spec['count']}, Target CV: ${spec['target_cv']}'),
// //                               trailing: IconButton(
// //                                 icon:
// //                                     const Icon(Icons.delete, color: Colors.red),
// //                                 onPressed: () {
// //                                   setState(() {
// //                                     addedSpecializations.remove(spec);
// //                                   });
// //                                 },
// //                               ),
// //                             )),
// //                         const Divider(),
// //                       ],
// //                     ),
// //                   const SizedBox(height: 16),
// //                   // Action Buttons
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: CustomActionButton(
// //                           text: 'Cancel',
// //                           icon: Icons.close,
// //                           onPressed: () => Navigator.pop(context),
// //                           isFilled: false,
// //                           textColor: Colors.blue.shade600,
// //                           borderColor: Colors.blue.shade100,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       Expanded(
// //                         child: CustomActionButton(
// //                           text: 'Add Client',
// //                           icon: Icons.check,
// //                           onPressed: () {
// //                             if (addedSpecializations.isEmpty) {
// //                               CustomToast.showToast(
// //                                 context: context,
// //                                 message:
// //                                     'Please add at least one specialization',
// //                                 backgroundColor: Colors.red,
// //                               );
// //                               return;
// //                             }

// //                             if (_commissionController.text.isEmpty) {
// //                               CustomToast.showToast(
// //                                 context: context,
// //                                 message: 'Please enter commission',
// //                                 backgroundColor: Colors.red,
// //                               );
// //                               return;
// //                             }

// //                             final Map<String, dynamic> vacanciesMap = {
// //                               for (var spec in addedSpecializations)
// //                                 spec['name']: {
// //                                   'count': spec['count'],
// //                                   'target_cv': spec['target_cv'],
// //                                 }
// //                             };

// //                             _addClientWithVacancies(
// //                               client.sId ?? '',
// //                               double.parse(_commissionController.text),
// //                               vacanciesMap,
// //                             );

// //                             Navigator.pop(context); // Close details dialog
// //                             Navigator.pop(
// //                                 context); // Close client selection dialog
// //                           },
// //                           isFilled: true,
// //                           gradient: AppColors.orangeGradient,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _addClientWithVacancies(
// //       String clientId, double commission, Map<String, dynamic> vacancies) {
// //     setState(() {
// //       _selectedClients.add({
// //         'client_id': clientId,
// //         'commission': commission,
// //         'vacancies': vacancies.isNotEmpty ? vacancies : {},
// //       });
// //     });
// //   }
// // }
