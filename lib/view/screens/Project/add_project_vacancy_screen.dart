import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import 'widget/client_mangement_tab.dart';
import 'widget/project_management_tab.dart';

class ProjectClientManagementScreen extends StatefulWidget {
  final bool isEditMode;
  final List<ProjectModel>? projectList;
  const ProjectClientManagementScreen({super.key, required this.isEditMode , this.projectList});

  @override
  State<ProjectClientManagementScreen> createState() =>
      _ProjectClientManagementScreenState();
}

class _ProjectClientManagementScreenState
    extends State<ProjectClientManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          // double dialogWidth = maxWidth > 900
          //     ? maxWidth * 0.8
          //     : maxWidth > 900
          //         ? maxWidth * 0.8
          //         : maxWidth;
          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.6;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.7;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.8;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
              constraints: const BoxConstraints(
                // minWidth: 320,
                // maxWidth: 900,
                // minHeight: 600,
                minWidth: 320,
                maxWidth: 800,
                minHeight: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.85),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.business_center_outlined,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: widget.isEditMode
                                    ? 'Edit Project '
                                    : 'Add Project',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text:widget.isEditMode?'Manage projects Edit':'Manage projects  Creation' ,
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 26),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Expanded(
                            child:ProjectManagementTab(
                                isEditMode: widget.isEditMode,)
                          ),
                        ),
                        // Side Panel
                        // if (maxWidth > 800)
                        //   Container(
                        //     width: 280,
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //         colors: [
                        //           AppColors.violetPrimaryColor
                        //               .withOpacity(0.08),
                        //           AppColors.blueSecondaryColor
                        //               .withOpacity(0.04),
                        //         ],
                        //       ),
                        //       borderRadius: BorderRadius.circular(16),
                        //       border: Border.all(
                        //           color: AppColors.violetPrimaryColor
                        //               .withOpacity(0.15)),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         const SizedBox(height: 24),
                        //         Container(
                        //           padding: const EdgeInsets.all(16),
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(12),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.grey.withOpacity(0.1),
                        //                 spreadRadius: 1,
                        //                 blurRadius: 5,
                        //                 offset: const Offset(0, 2),
                        //               ),
                        //             ],
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Container(
                        //                     padding: const EdgeInsets.all(8),
                        //                     decoration: BoxDecoration(
                        //                       color: AppColors
                        //                           .violetPrimaryColor
                        //                           .withOpacity(0.1),
                        //                       borderRadius:
                        //                           BorderRadius.circular(10),
                        //                     ),
                        //                     child: Icon(
                        //                         Icons.toggle_on_outlined,
                        //                         size: 20,
                        //                         color: AppColors
                        //                             .violetPrimaryColor),
                        //                   ),
                        //                   const SizedBox(width: 12),
                        //                   const CustomText(
                        //                     text: 'Project Status',
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 17,
                        //                     color: AppColors.primaryColor,
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 16),
                        //               EnhancedSwitchTile(
                        //                 label:
                        //                     _isActive ? 'Active' : 'Inactive',
                        //                 icon: Icons.power_settings_new_rounded,
                        //                 value: _isActive,
                        //                 onChanged: (val) =>
                        //                     setState(() => _isActive = val),
                        //               ),
                        //               const SizedBox(height: 16),
                        //               const Divider(),
                        //               const SizedBox(height: 16),
                        //               Row(
                        //                 children: [
                        //                   Container(
                        //                     padding: const EdgeInsets.all(8),
                        //                     decoration: BoxDecoration(
                        //                       color: AppColors
                        //                           .violetPrimaryColor
                        //                           .withOpacity(0.1),
                        //                       borderRadius:
                        //                           BorderRadius.circular(10),
                        //                     ),
                        //                     child: Icon(
                        //                         Icons.calendar_today_outlined,
                        //                         size: 20,
                        //                         color: AppColors
                        //                             .violetPrimaryColor),
                        //                   ),
                        //                   const SizedBox(width: 12),
                        //                   const CustomText(
                        //                     text: 'Created Date',
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 17,
                        //                     color: AppColors.primaryColor,
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 16),
                        //               Text(
                        //                 DateTime.now()
                        //                     .toString()
                        //                     .substring(0, 10),
                        //                 style: const TextStyle(fontSize: 14),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Project Management Tab

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class AddProjectVacancyScreen extends StatefulWidget {
//   final bool isEditMode;
//   const AddProjectVacancyScreen({super.key, this.isEditMode = false});

//   @override
//   State<AddProjectVacancyScreen> createState() =>
//       _AddProjectVacancyScreenState();
// }

// class _AddProjectVacancyScreenState extends State<AddProjectVacancyScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   bool _isActive = true;
//   late TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();

//   // Dropdown values
//   String? _selectedHospital;
//   String? _selectedJobPosition;
//   String? _selectedJobField;
//   String? _selectedQualification;
//   String? _selectedOrganizationType;
//   String? _selectedVisaCategory;
//   String? _selectedReligion;
//   String? _selectedGender;
//   String? _selectedPrometric;
//   String? _selectedInterviewMode;

//   // Text controllers
//   final TextEditingController _yearsExpFromController = TextEditingController();
//   final TextEditingController _yearsExpToController = TextEditingController();
//   final TextEditingController _interviewDateController =
//       TextEditingController();
//   final TextEditingController _companyLocationController =
//       TextEditingController();
//   final TextEditingController _contractController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
//   final TextEditingController _ageFromController = TextEditingController();
//   final TextEditingController _ageToController = TextEditingController();
//   final TextEditingController _salaryFromController = TextEditingController();
//   final TextEditingController _salaryToController = TextEditingController();
//   final TextEditingController _noOfVacancyController = TextEditingController();
//   final TextEditingController _cvTargetController = TextEditingController();
//   final TextEditingController _processingTimeController =
//       TextEditingController();
//   final TextEditingController _deadlineController = TextEditingController();
//   final TextEditingController _serviceChargeController =
//       TextEditingController();
//   final TextEditingController _benefitsController = TextEditingController();

//   // Client data
//   List<Map<String, dynamic>> _clients = [];
//   List<Map<String, dynamic>> _filteredClients = [];
//   final TextEditingController _newClientController = TextEditingController();
//   final TextEditingController _newClientCommissionController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _filteredClients = _clients;
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _yearsExpFromController.dispose();
//     _yearsExpToController.dispose();
//     _interviewDateController.dispose();
//     _companyLocationController.dispose();
//     _contractController.dispose();
//     _departmentController.dispose();
//     _ageFromController.dispose();
//     _ageToController.dispose();
//     _salaryFromController.dispose();
//     _salaryToController.dispose();
//     _noOfVacancyController.dispose();
//     _cvTargetController.dispose();
//     _processingTimeController.dispose();
//     _deadlineController.dispose();
//     _serviceChargeController.dispose();
//     _benefitsController.dispose();
//     _newClientController.dispose();
//     _newClientCommissionController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _addNewClient() {
//     if (_newClientController.text.isNotEmpty) {
//       setState(() {
//         _clients.add({
//           'id': _clients.length + 1,
//           'name': _newClientController.text,
//           'isSelected': true,
//           'commission': _newClientCommissionController.text,
//           'vacancies': 0,
//           'status': 'Active',
//           'email': ''
//         });
//         _filteredClients = _clients;
//         _newClientController.clear();
//         _newClientCommissionController.clear();
//       });
//     }
//   }

//   void _toggleClientSelection(int index) {
//     setState(() {
//       _clients[index]['isSelected'] = !_clients[index]['isSelected'];
//     });
//   }

//   void _updateClientCommission(int index, String value) {
//     setState(() {
//       _clients[index]['commission'] = value;
//     });
//   }

//   void _filterClients(String query) {
//     setState(() {
//       _filteredClients = _clients
//           .where((client) =>
//               client['name'].toLowerCase().contains(query.toLowerCase()) ||
//               client['email'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   Widget _buildProjectDetailsTab() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth;
//         int columnsCount = availableWidth > 1000
//             ? 3
//             : availableWidth > 600
//                 ? 2
//                 : 1;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Project Basic Information
//               const SectionTitle(
//                 title: 'Project Information',
//                 icon: Icons.info_outline_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Hospital',
//                     value: _selectedHospital,
//                     items: const ['Hospital A', 'Hospital B', 'Hospital C'],
//                     onChanged: (val) => setState(() => _selectedHospital = val),
//                     isRequired: true,
//                   ),
//                   CustomDropdownField(
//                     label: 'Job Position',
//                     value: _selectedJobPosition,
//                     items: const ['Nurse', 'Doctor', 'Technician'],
//                     onChanged: (val) =>
//                         setState(() => _selectedJobPosition = val),
//                     isRequired: true,
//                   ),
//                   CustomDropdownField(
//                     label: 'Job Field',
//                     value: _selectedJobField,
//                     items: const ['Medical', 'Administrative', 'Support'],
//                     onChanged: (val) => setState(() => _selectedJobField = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Qualification',
//                     value: _selectedQualification,
//                     items: const ['Degree', 'Diploma', 'Certificate'],
//                     onChanged: (val) =>
//                         setState(() => _selectedQualification = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Organization Type',
//                     value: _selectedOrganizationType,
//                     items: const ['Government', 'Private', 'NGO'],
//                     onChanged: (val) =>
//                         setState(() => _selectedOrganizationType = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Visa Category',
//                     value: _selectedVisaCategory,
//                     items: const ['Work Visa', 'Permanent', 'Temporary'],
//                     onChanged: (val) =>
//                         setState(() => _selectedVisaCategory = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Experience and Age Requirements
//               const SectionTitle(
//                 title: 'Requirements',
//                 icon: Icons.assignment_outlined,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Years Exp (From)',
//                     controller: _yearsExpFromController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Years Exp (To)',
//                     controller: _yearsExpToController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Age (From)',
//                     controller: _ageFromController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Age (To)',
//                     controller: _ageToController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Salary (From)',
//                     controller: _salaryFromController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Salary (To)',
//                     controller: _salaryToController,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // Additional Information
//               const SectionTitle(
//                 title: 'Additional Information',
//                 icon: Icons.note_add_outlined,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'No. of Vacancies',
//                     controller: _noOfVacancyController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'CV Target',
//                     controller: _cvTargetController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Processing Time (Days)',
//                     controller: _processingTimeController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Deadline',
//                     controller: _deadlineController,
//                     isdate: true,
//                     readOnly: true,
//                   ),
//                   CustomTextFormField(
//                     label: 'Service Charge',
//                     controller: _serviceChargeController,
//                   ),
//                   CustomDropdownField(
//                     label: 'Religion',
//                     value: _selectedReligion,
//                     items: const [
//                       'Any',
//                       'Christian',
//                       'Muslim',
//                       'Hindu',
//                       'Other'
//                     ],
//                     onChanged: (val) => setState(() => _selectedReligion = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Gender',
//                     value: _selectedGender,
//                     items: const ['Any', 'Male', 'Female'],
//                     onChanged: (val) => setState(() => _selectedGender = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Prometric',
//                     value: _selectedPrometric,
//                     items: const ['Required', 'Not Required'],
//                     onChanged: (val) =>
//                         setState(() => _selectedPrometric = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Interview Mode',
//                     value: _selectedInterviewMode,
//                     items: const ['Online', 'In-Person', 'Both'],
//                     onChanged: (val) =>
//                         setState(() => _selectedInterviewMode = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               CustomTextFormField(
//                 label: 'Benefits',
//                 controller: _benefitsController,
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCustomerListTab() {
//     return Column(
//       children: [
//         // Search and Add Client
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                       labelText: 'Search clients...',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       )),
//                   onChanged: _filterClients,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => _buildAddClientDialog(),
//                   );
//                 },
//                 icon: const Icon(Icons.person_add),
//                 label: const Text('Add Client'),
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Client List
//         Expanded(
//           child: Scrollbar(
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _filteredClients.length,
//               separatorBuilder: (context, index) => const Divider(height: 1),
//               itemBuilder: (context, index) {
//                 final client = _filteredClients[index];
//                 return ListTile(
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.person_outline),
//                   ),
//                   title: Text(
//                     client['name'],
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(client['email']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             '${client['vacancies']} vacancies',
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '${client['commission']}% commission',
//                             style: TextStyle(
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 16),
//                       Checkbox(
//                         value: client['isSelected'],
//                         onChanged: (value) => _toggleClientSelection(_clients
//                             .indexWhere((c) => c['id'] == client['id'])),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     // Show client details or edit dialog
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddClientDialog() {
//     return AlertDialog(
//       title: const Text('Add New Client'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: _newClientController,
//             decoration: const InputDecoration(
//               labelText: 'Client Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextFormField(
//             controller: _newClientCommissionController,
//             decoration: const InputDecoration(
//               labelText: 'Commission %',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             _addNewClient();
//             Navigator.pop(context);
//           },
//           child: const Text('Add Client'),
//         ),
//       ],
//     );
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

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.8;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           }

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
//                     spreadRadius: 0,
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
//                             Icons.work_outline,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: widget.isEditMode
//                                     ? 'Edit Project'
//                                     : 'Add New Project',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               const CustomText(
//                                 text:
//                                     'Manage project details and client assignments',
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

//                   // Tab Bar
//                   Container(
//                     height: 60,
//                     color: Colors.grey.shade50,
//                     child: TabBar(
//                       controller: _tabController,
//                       labelColor: AppColors.primaryColor,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: AppColors.primaryColor,
//                       tabs: const [
//                         Tab(
//                           icon: Icon(Icons.description_outlined),
//                           text: 'Project Details',
//                         ),
//                         Tab(
//                           icon: Icon(Icons.people_outline),
//                           text: 'Customer List',
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Tab Content
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         // Project Details Tab
//                         _buildProjectDetailsTab(),

//                         // Customer List Tab
//                         _buildCustomerListTab(),
//                       ],
//                     ),
//                   ),

//                   // Footer with Action Buttons
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade50,
//                       border: Border(
//                         top: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: CustomActionButton(
//                             text: 'Reset',
//                             icon: Icons.refresh_rounded,
//                             onPressed: () {
//                               _formKey.currentState?.reset();
//                               setState(() {
//                                 _isActive = true;
//                                 _clients.forEach((client) {
//                                   client['isSelected'] = false;
//                                   client['commission'] = '';
//                                 });
//                               });
//                             },
//                             borderColor: Colors.grey.shade300,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: CustomActionButton(
//                             text: 'Cancel',
//                             icon: Icons.close_rounded,
//                             textColor: Colors.grey,
//                             onPressed: () => Navigator.pop(context),
//                             borderColor: Colors.grey.shade300,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           flex: 2,
//                           child: CustomActionButton(
//                             text: widget.isEditMode
//                                 ? 'Update Project'
//                                 : 'Create Project',
//                             icon: Icons.save_rounded,
//                             isFilled: true,
//                             gradient: const LinearGradient(
//                               colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 // Save project logic
//                                 Navigator.pop(context);
//                               }
//                             },
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

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class AddProjectVacancyScreen extends StatefulWidget {
//   final bool isEditMode;
//   const AddProjectVacancyScreen({super.key, this.isEditMode = false});

//   @override
//   State<AddProjectVacancyScreen> createState() =>
//       _AddProjectVacancyScreenState();
// }

// class _AddProjectVacancyScreenState extends State<AddProjectVacancyScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isActive = true;

//   // Dropdown values
//   String? _selectedHospital;
//   String? _selectedJobPosition;
//   String? _selectedJobField;
//   String? _selectedQualification;
//   String? _selectedOrganizationType;
//   String? _selectedVisaCategory;
//   String? _selectedReligion;
//   String? _selectedGender;
//   String? _selectedPrometric;
//   String? _selectedInterviewMode;

//   // Text controllers
//   final TextEditingController _yearsExpFromController = TextEditingController();
//   final TextEditingController _yearsExpToController = TextEditingController();
//   final TextEditingController _interviewDateController =
//       TextEditingController();
//   final TextEditingController _companyLocationController =
//       TextEditingController();
//   final TextEditingController _contractController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
//   final TextEditingController _ageFromController = TextEditingController();
//   final TextEditingController _ageToController = TextEditingController();
//   final TextEditingController _salaryFromController = TextEditingController();
//   final TextEditingController _salaryToController = TextEditingController();
//   final TextEditingController _noOfVacancyController = TextEditingController();
//   final TextEditingController _cvTargetController = TextEditingController();
//   final TextEditingController _processingTimeController =
//       TextEditingController();
//   final TextEditingController _deadlineController = TextEditingController();
//   final TextEditingController _serviceChargeController =
//       TextEditingController();
//   final TextEditingController _benefitsController = TextEditingController();

//   // Client selection
//   List<Map<String, dynamic>> _clients = [];
//   final TextEditingController _newClientController = TextEditingController();
//   final TextEditingController _newClientCommissionController =
//       TextEditingController();

//   @override
//   void dispose() {
//     _yearsExpFromController.dispose();
//     _yearsExpToController.dispose();
//     _interviewDateController.dispose();
//     _companyLocationController.dispose();
//     _contractController.dispose();
//     _departmentController.dispose();
//     _ageFromController.dispose();
//     _ageToController.dispose();
//     _salaryFromController.dispose();
//     _salaryToController.dispose();
//     _noOfVacancyController.dispose();
//     _cvTargetController.dispose();
//     _processingTimeController.dispose();
//     _deadlineController.dispose();
//     _serviceChargeController.dispose();
//     _benefitsController.dispose();
//     _newClientController.dispose();
//     _newClientCommissionController.dispose();
//     super.dispose();
//   }

//   void _addNewClient() {
//     if (_newClientController.text.isNotEmpty) {
//       setState(() {
//         _clients.add({
//           'id': _clients.length + 1,
//           'name': _newClientController.text,
//           'isSelected': true,
//           'commission': _newClientCommissionController.text
//         });
//         _newClientController.clear();
//         _newClientCommissionController.clear();
//       });
//     }
//   }

//   void _toggleClientSelection(int index) {
//     setState(() {
//       _clients[index]['isSelected'] = !_clients[index]['isSelected'];
//     });
//   }

//   void _updateClientCommission(int index, String value) {
//     setState(() {
//       _clients[index]['commission'] = value;
//     });
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

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.8;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           }

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
//                     spreadRadius: 0,
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
//                             Icons.work_outline,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: widget.isEditMode
//                                     ? 'Edit Project'
//                                     : 'Add New Project',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               const CustomText(
//                                 text:
//                                     'Manage project details and client assignments',
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
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Scrollbar(
//                                         thumbVisibility: true,
//                                         child: SingleChildScrollView(
//                                           padding: const EdgeInsets.all(24),
//                                           child: LayoutBuilder(
//                                             builder: (context, constraints) {
//                                               final availableWidth =
//                                                   constraints.maxWidth;
//                                               int columnsCount =
//                                                   availableWidth > 1000
//                                                       ? 3
//                                                       : availableWidth > 600
//                                                           ? 2
//                                                           : 1;

//                                               return Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   // Project Basic Information
//                                                   const SectionTitle(
//                                                     title:
//                                                         'Project Information',
//                                                     icon: Icons
//                                                         .info_outline_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomDropdownField(
//                                                         label: 'Hospital',
//                                                         value:
//                                                             _selectedHospital,
//                                                         items: const [
//                                                           'Hospital A',
//                                                           'Hospital B',
//                                                           'Hospital C'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedHospital =
//                                                                     val),
//                                                         isRequired: true,
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Job Position',
//                                                         value:
//                                                             _selectedJobPosition,
//                                                         items: const [
//                                                           'Nurse',
//                                                           'Doctor',
//                                                           'Technician'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedJobPosition =
//                                                                     val),
//                                                         isRequired: true,
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Job Field',
//                                                         value:
//                                                             _selectedJobField,
//                                                         items: const [
//                                                           'Medical',
//                                                           'Administrative',
//                                                           'Support'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedJobField =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Qualification',
//                                                         value:
//                                                             _selectedQualification,
//                                                         items: const [
//                                                           'Degree',
//                                                           'Diploma',
//                                                           'Certificate'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedQualification =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label:
//                                                             'Organization Type',
//                                                         value:
//                                                             _selectedOrganizationType,
//                                                         items: const [
//                                                           'Government',
//                                                           'Private',
//                                                           'NGO'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedOrganizationType =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Visa Category',
//                                                         value:
//                                                             _selectedVisaCategory,
//                                                         items: const [
//                                                           'Work Visa',
//                                                           'Permanent',
//                                                           'Temporary'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedVisaCategory =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),

//                                                   // Experience and Age Requirements
//                                                   const SectionTitle(
//                                                     title: 'Requirements',
//                                                     icon: Icons
//                                                         .assignment_outlined,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Years Exp (From)',
//                                                         controller:
//                                                             _yearsExpFromController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Years Exp (To)',
//                                                         controller:
//                                                             _yearsExpToController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Age (From)',
//                                                         controller:
//                                                             _ageFromController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Age (To)',
//                                                         controller:
//                                                             _ageToController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Salary (From)',
//                                                         controller:
//                                                             _salaryFromController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Salary (To)',
//                                                         controller:
//                                                             _salaryToController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 32),

//                                                   // Additional Information
//                                                   const SectionTitle(
//                                                     title:
//                                                         'Additional Information',
//                                                     icon:
//                                                         Icons.note_add_outlined,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'No. of Vacancies',
//                                                         controller:
//                                                             _noOfVacancyController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'CV Target',
//                                                         controller:
//                                                             _cvTargetController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Processing Time (Days)',
//                                                         controller:
//                                                             _processingTimeController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Deadline',
//                                                         controller:
//                                                             _deadlineController,
//                                                         isdate: true,
//                                                         readOnly: true,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Service Charge',
//                                                         controller:
//                                                             _serviceChargeController,
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Religion',
//                                                         value:
//                                                             _selectedReligion,
//                                                         items: const [
//                                                           'Any',
//                                                           'Christian',
//                                                           'Muslim',
//                                                           'Hindu',
//                                                           'Other'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedReligion =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomDropdownField(
//                                                         label: 'Gender',
//                                                         value: _selectedGender,
//                                                         items: const [
//                                                           'Any',
//                                                           'Male',
//                                                           'Female'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedGender =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Prometric',
//                                                         value:
//                                                             _selectedPrometric,
//                                                         items: const [
//                                                           'Required',
//                                                           'Not Required'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedPrometric =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Interview Mode',
//                                                         value:
//                                                             _selectedInterviewMode,
//                                                         items: const [
//                                                           'Online',
//                                                           'In-Person',
//                                                           'Both'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedInterviewMode =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   CustomTextFormField(
//                                                     label: 'Benefits',
//                                                     controller:
//                                                         _benefitsController,
//                                                     maxLines: 3,
//                                                   ),
//                                                   const SizedBox(height: 32),

//                                                   // Client Assignment Section
//                                                   const SectionTitle(
//                                                     title: 'Client Assignment',
//                                                     icon: Icons.people_outline,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   _buildClientList(),
//                                                   const SizedBox(height: 16),
//                                                   _buildAddClientForm(),
//                                                   const SizedBox(height: 32),
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // Action Buttons
//                                     Padding(
//                                       padding: const EdgeInsets.all(16),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: CustomActionButton(
//                                               text: 'Reset',
//                                               icon: Icons.refresh_rounded,
//                                               onPressed: () {
//                                                 _formKey.currentState?.reset();
//                                                 setState(() {
//                                                   _isActive = true;
//                                                   _clients.forEach((client) {
//                                                     client['isSelected'] =
//                                                         false;
//                                                     client['commission'] = '';
//                                                   });
//                                                 });
//                                               },
//                                               borderColor: Colors.grey.shade300,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: CustomActionButton(
//                                               text: 'Cancel',
//                                               icon: Icons.close_rounded,
//                                               textColor: Colors.grey,
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               borderColor: Colors.grey.shade300,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             flex: 2,
//                                             child: CustomActionButton(
//                                               text: widget.isEditMode
//                                                   ? 'Update Project'
//                                                   : 'Create Project',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: () {
//                                                 if (_formKey.currentState!
//                                                     .validate()) {
//                                                   // Save project logic
//                                                   Navigator.pop(context);
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // Status Sidebar
//                             const SizedBox(width: 24),
//                             Container(
//                               width: 280,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     AppColors.violetPrimaryColor
//                                         .withOpacity(0.08),
//                                     AppColors.blueSecondaryColor
//                                         .withOpacity(0.04),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(16),
//                                 border: Border.all(
//                                     color: AppColors.violetPrimaryColor
//                                         .withOpacity(0.15)),
//                               ),
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 24),
//                                   Container(
//                                     padding: const EdgeInsets.all(16),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.1),
//                                           spreadRadius: 1,
//                                           blurRadius: 5,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(8),
//                                               decoration: BoxDecoration(
//                                                 color: AppColors
//                                                     .violetPrimaryColor
//                                                     .withOpacity(0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: const Icon(
//                                                   Icons.toggle_on_outlined,
//                                                   size: 20,
//                                                   color: AppColors
//                                                       .violetPrimaryColor),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             const CustomText(
//                                               text: 'Project Status',
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 17,
//                                               color: AppColors.primaryColor,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 16),
//                                         EnhancedSwitchTile(
//                                           label:
//                                               _isActive ? 'Active' : 'Inactive',
//                                           icon:
//                                               Icons.power_settings_new_rounded,
//                                           value: _isActive,
//                                           onChanged: (val) =>
//                                               setState(() => _isActive = val),
//                                         ),
//                                         const SizedBox(height: 16),
//                                         const Divider(),
//                                         const SizedBox(height: 16),
//                                         Row(
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(8),
//                                               decoration: BoxDecoration(
//                                                 color: AppColors
//                                                     .violetPrimaryColor
//                                                     .withOpacity(0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: const Icon(
//                                                   Icons.calendar_today_outlined,
//                                                   size: 20,
//                                                   color: AppColors
//                                                       .violetPrimaryColor),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             const CustomText(
//                                               text: 'Created Date',
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 17,
//                                               color: AppColors.primaryColor,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 16),
//                                         Text(
//                                           DateTime.now()
//                                               .toString()
//                                               .substring(0, 10),
//                                           style: const TextStyle(fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
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

//   Widget _buildClientList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Select Clients for this Project:',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//         const SizedBox(height: 8),
//         ..._clients.map((client) => _buildClientListItem(client)).toList(),
//       ],
//     );
//   }

//   Widget _buildClientListItem(Map<String, dynamic> client) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Checkbox(
//             value: client['isSelected'] as bool,
//             onChanged: (value) =>
//                 _toggleClientSelection(_clients.indexOf(client)),
//           ),
//           Expanded(
//             child: Text(client['name']),
//           ),
//           if (client['isSelected'])
//             SizedBox(
//               width: 100,
//               child: TextFormField(
//                 initialValue: client['commission'],
//                 decoration: const InputDecoration(
//                   labelText: 'Commission %',
//                   isDense: true,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) =>
//                     _updateClientCommission(_clients.indexOf(client), value),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddClientForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Add New Client:',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _newClientController,
//                 decoration: const InputDecoration(
//                   labelText: 'Client Name',
//                   isDense: true,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             SizedBox(
//               width: 100,
//               child: TextFormField(
//                 controller: _newClientCommissionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Commission %',
//                   isDense: true,
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             const SizedBox(width: 16),
//             ElevatedButton(
//               onPressed: _addNewClient,
//               child: const Text('Add'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
