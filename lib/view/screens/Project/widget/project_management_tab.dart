import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/project/project_provider_controller.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';

class ProjectManagementTab extends StatefulWidget {
  final bool isEditMode;
  const ProjectManagementTab({super.key, required this.isEditMode});

  @override
  State<ProjectManagementTab> createState() => _ProjectManagementTabState();
}

class _ProjectManagementTabState extends State<ProjectManagementTab> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _selectedHospital;
  String? _selectedProfession;
  String? _selectedSpecialization;
  String? _selectedQualification;
  String? _selectedOrganizationType;
  String? _selectedVisaCategory;
  String? _selectedReligion;
  String? _selectedGender;
  String? _selectedPrometric;
  String? _selectedInterviewMode;
  String? _selectedOrganizationCategory;
  String? _selectedCountry;

  var _selectedHRD;
  var _selectedDataflow;

  // Text controllers
  final TextEditingController _yearsExpFromController = TextEditingController();
  final TextEditingController _yearsExpToController = TextEditingController();
  final TextEditingController _ageFromController = TextEditingController();
  final TextEditingController _ageToController = TextEditingController();
  final TextEditingController _salaryFromController = TextEditingController();
  final TextEditingController _salaryToController = TextEditingController();
  final TextEditingController _noOfVacancyController = TextEditingController();
  final TextEditingController _cvTargetController = TextEditingController();
  final TextEditingController _processingTimeController =
      TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _serviceChargeController =
      TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  List<String> remarks = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<String> selectedRemarks = [];

  var _organizationNameController = TextEditingController();

  var _interviewDateController = TextEditingController();

  var _locationController = TextEditingController();

  var _projectNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 0, top: 2, bottom: 5),
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final availableWidth = constraints.maxWidth;
                        int columnsCount = availableWidth > 1000 ? 3 : 2;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Project Basic Information
                            const SectionTitle(
                              title: 'Project Information',
                              icon: Icons.info_outline_rounded,
                            ),
                            const SizedBox(height: 16),
                            ResponsiveGrid(
                              columns: columnsCount,
                              children: [
                                CustomTextFormField(
                                  label: 'Project Name',
                                  controller: _projectNameController,
                                  isdate: false,
                                  readOnly: false,
                                  isRequired: true,
                                ),
                                CustomDropdownField(
                                  label: 'Organization Type',
                                  value: _selectedOrganizationType,
                                  items: const [
                                    'Government',
                                    'Private',
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedOrganizationType = val),
                                  isRequired: true,
                                ),
                                CustomDropdownField(
                                  label: 'Organization Category',
                                  value: _selectedOrganizationCategory,
                                  items: const [
                                    'Hospital',
                                    'Construction',
                                    'Construction',
                                    'Logistics',
                                  ],
                                  onChanged: (val) => setState(() =>
                                      _selectedOrganizationCategory = val),
                                  isRequired: true,
                                ),
                                CustomTextFormField(
                                  label: 'Organization Name',
                                  controller: _organizationNameController,
                                  isdate: false,
                                  readOnly: false,
                                ),
                                CustomDropdownField(
                                  label: 'Country',
                                  value: _selectedCountry,
                                  items: const [
                                    'UAE',
                                    'SAUDI ARABIA',
                                    'KUWAIT'
                                  ],
                                  onChanged: (val) =>
                                      setState(() => _selectedCountry = val),
                                  isRequired: true,
                                ),
                                CustomTextFormField(
                                  label: 'Location',
                                  controller: _locationController,
                                  isdate: false,
                                  readOnly: false,
                                ),
                                CustomDropdownField(
                                  label: 'Profession',
                                  value: _selectedProfession,
                                  items: const [
                                    'Nurse',
                                    'Doctor',
                                    'Technician'
                                  ],
                                  onChanged: (val) =>
                                      setState(() => _selectedProfession = val),
                                  isRequired: true,
                                ),
                                CustomDropdownField(
                                  label: 'Specialization',
                                  value: _selectedSpecialization,
                                  items: const [
                                    'Medical',
                                    'Administrative',
                                    'Support'
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedSpecialization = val),
                                ),
                                CustomDropdownField(
                                  label: 'Visa Category',
                                  value: _selectedVisaCategory,
                                  items: const [
                                    'Work Visa',
                                    'Permanent',
                                    'Temporary'
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedVisaCategory = val),
                                ),
                                CustomTextFormField(
                                  label: 'No. of Vacancies',
                                  controller: _noOfVacancyController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'CV Target',
                                  controller: _cvTargetController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomDropdownField(
                                  label: 'Interview Mode',
                                  value: _selectedInterviewMode,
                                  items: const [
                                    'Online',
                                    'Offline',
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedInterviewMode = val),
                                  isRequired: true,
                                ),
                                CustomTextFormField(
                                  label: 'Interview Date',
                                  controller: _interviewDateController,
                                  isdate: true,
                                  readOnly: true,
                                ),
                                CustomTextFormField(
                                  label: 'Processing Time (Days)',
                                  controller: _processingTimeController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Deadline',
                                  controller: _deadlineController,
                                  isdate: true,
                                  readOnly: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Requirements Section
                            const SectionTitle(
                              title: 'Requirements',
                              icon: Icons.assignment_outlined,
                            ),
                            const SizedBox(height: 16),
                            ResponsiveGrid(
                              columns: columnsCount,
                              children: [
                                CustomTextFormField(
                                  label: 'Salary (From)',
                                  controller: _salaryFromController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Salary (To)',
                                  controller: _salaryToController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Years Exp (From)',
                                  controller: _yearsExpFromController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Years Exp (To)',
                                  controller: _yearsExpToController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Age (From)',
                                  controller: _ageFromController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomTextFormField(
                                  label: 'Age (To)',
                                  controller: _ageToController,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomDropdownField(
                                  label: 'Qualification',
                                  value: _selectedQualification,
                                  items: const [
                                    'Degree',
                                    'Diploma',
                                    'Certificate'
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedQualification = val),
                                ),
                                CustomDropdownField(
                                  label: 'Gender',
                                  value: _selectedGender,
                                  items: const ['Any', 'Male', 'Female'],
                                  onChanged: (val) =>
                                      setState(() => _selectedGender = val),
                                ),

                                CustomDropdownField(
                                  label: 'Religion',
                                  value: _selectedQualification,
                                  items: const [
                                    'Muslim',
                                    'Christian',
                                    'Hindu',
                                  ],
                                  onChanged: (val) => setState(
                                      () => _selectedQualification = val),
                                ),
                                // CustomTextFormField(
                                //   label: 'Processing Time (Days)',
                                //   controller: _processingTimeController,
                                //   keyboardType: TextInputType.number,
                                // ),
                                CustomDropdownField(
                                  label: 'Prometric',
                                  value: _selectedPrometric,
                                  items: const ['Required', 'Not Required'],
                                  onChanged: (val) =>
                                      setState(() => _selectedPrometric = val),
                                ),
                                CustomDropdownField(
                                  label: 'HRD',
                                  value: _selectedHRD,
                                  items: const ['Required', 'Not Required'],
                                  onChanged: (val) =>
                                      setState(() => _selectedPrometric = val),
                                ),
                                CustomDropdownField(
                                  label: 'Dataflow',
                                  value: _selectedDataflow,
                                  items: const ['Required', 'Not Required'],
                                  onChanged: (val) =>
                                      setState(() => _selectedPrometric = val),
                                ),
                                // const SizedBox(height: 20),
                                CustomCheckDropdown<String>(
                                  label: 'Benefits',
                                  values: selectedRemarks ?? [],
                                  items: remarks,
                                  onChanged: (selected) => setState(
                                      () => selectedRemarks.addAll(selected)),
                                  isRequired: false,
                                ),
                                CustomTextFormField(
                                  label: 'Remarks',
                                  controller: _benefitsController,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Additional Information
                            // const SectionTitle(
                            //   title: 'Additional Information',
                            //   icon: Icons.note_add_outlined,
                            // ),
                            // const SizedBox(height: 16),
                            ResponsiveGrid(
                              columns: columnsCount,
                              children: [],
                            ),
                            const SizedBox(height: 20),
                            // CustomTextFormField(
                            //   label: 'Benefits',
                            //   controller: _benefitsController,
                            //   maxLines: 3,
                            // ),
                            const SizedBox(height: 32),

                            // Client Assignment Section
                            Consumer<ProjectProvider>(
                              builder: (context, value, child) => Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomActionButton(
                                          text: 'Cancel',
                                          icon: Icons.close_rounded,
                                          textColor: Colors.grey,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          borderColor: Colors.grey.shade300,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 2,
                                        child: CustomActionButton(
                                          text: widget.isEditMode
                                              ? 'Update Project'
                                              : 'Create Project',
                                          icon: Icons.save_rounded,
                                          isFilled: true,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF7F00FF),
                                              Color(0xFFE100FF)
                                            ],
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              value.addProject(
                                                  projectName:
                                                      _projectNameController
                                                          .text
                                                          .trim(),
                                                  organizationType:
                                                      _selectedOrganizationType ??
                                                          '',
                                                  organizationCategory:
                                                      _selectedOrganizationCategory ??
                                                          '',
                                                  organizationName:
                                                      _organizationNameController
                                                          .text
                                                          .trim(),
                                                  city: _locationController.text
                                                      .trim(),
                                                  country:
                                                      _selectedCountry ?? '');
                                              // Save project logic
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Status Sidebar
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
