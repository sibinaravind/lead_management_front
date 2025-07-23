import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/project/project_provider_controller.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

import '../../../../controller/config/config_provider.dart';
import '../../../../model/project/project_model.dart';
import '../../../../model/project/vacancy_model.dart';
import '../../../widgets/widgets.dart';

class AddNewProjectTab extends StatefulWidget {
  final ProjectModel? project;

  final bool isEditMode;
  const AddNewProjectTab(
      {super.key, required this.isEditMode, this.project});

  @override
  State<AddNewProjectTab> createState() => _AddNewProjectTabState();
}

class _AddNewProjectTabState extends State<AddNewProjectTab> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOrganizationType;
  String? _selectedOrganizationCategory;
  String? _selectedCountry;
  String? _selectedStatus;

  List<String> selectedRemarks = [];

  final _organizationNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _projectNameController = TextEditingController();

  @override
  void initState() {
    _selectedOrganizationType = widget.project?.organizationType ?? '';
    _selectedOrganizationCategory = widget.project?.organizationCategory ?? '';
    _selectedCountry = widget.project?.country ?? '';
    _organizationNameController.text = widget.project?.organizationName ?? '';
    _locationController.text = widget.project?.city ?? '';
    _projectNameController.text = widget.project?.projectName ?? '';
    _selectedStatus = widget.project?.status ?? '';
    // _selectedStatus=widget.project?.status??'';
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
                        int columnsCount = availableWidth > 500 ? 2 : 1;

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
                                    'GOV',
                                    'PRIVATE',
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
                                    'Logistics',
                                  ],
                                  onChanged: (val) => setState(() =>
                                      _selectedOrganizationCategory = val),
                                  isRequired: true,
                                ),
                                CustomTextFormField(
                                  isRequired: true,
                                  label: 'Organization Name',
                                  controller: _organizationNameController,
                                  isdate: false,
                                  readOnly: false,
                                ),
                                Consumer<ConfigProvider>(
                                    builder: (context, configProvider, child) {
                                      return CustomDropdownField(
                                        label: 'Status',
                                        value: _selectedStatus,
                                        items: ['ACTIVE', 'INACTIVE'],
                                        onChanged: (val) =>
                                            setState(() => _selectedStatus = val),
                                        isRequired: true,
                                      );
                                    }),
                                Consumer<ConfigProvider>(
                                    builder: (context, configProvider, child) {
                                  return CustomDropdownField(
                                    label: 'Country',
                                    value: _selectedCountry,
                                    items: configProvider
                                            .configModelList?.country
                                            ?.map((e) => e.name ?? '')
                                            .toList() ??
                                        [],
                                    onChanged: (val) =>
                                        setState(() => _selectedCountry = val),
                                    isRequired: true,
                                  );
                                }),
                                CustomTextFormField(
                                  label: 'City',
                                  controller: _locationController,
                                  isdate: false,
                                  readOnly: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

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
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {

                                              if (widget.isEditMode) {
                                                final editProject = await value.editProject(
                                                    status:_selectedStatus??'ACTIVE',
                                                    context,
                                                    projectId:
                                                        widget.project?.sId ??
                                                            '',
                                                    projectName:
                                                        _projectNameController.text
                                                                .trim() ??
                                                            '',
                                                    organizationType:
                                                        _selectedOrganizationType ??
                                                            '',
                                                    organizationCategory:
                                                        _selectedOrganizationCategory ??
                                                            '',
                                                    organizationName:
                                                        _organizationNameController
                                                                .text
                                                                .trim() ??
                                                            '',
                                                    city: _locationController
                                                            .text
                                                            .trim() ??
                                                        '',
                                                    country: _selectedCountry
                                                            ?.trim() ??
                                                        '');
                                                if (editProject) {
                                                  Navigator.pop(context);
                                                  CustomToast.showToast(context: context, message: 'Project Updated Successfully');

                                                } else {
                                                  CustomToast.showToast(context: context,
                                                    message:   "Project Update Failed");
                                                }
                                              } else {
                                                final addProject = await value.addProject(
                                                  status: _selectedStatus??'ACTIVE',
                                                    context,
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
                                                    city: _locationController
                                                        .text
                                                        .trim(),
                                                    country:
                                                        _selectedCountry ?? '');
                                                if (addProject) {
                                                  Navigator.pop(context);
                                                  CustomToast.showToast(context: context,
                                                     message:  'Project Created Successfully');
                                                } else {
                                                  CustomToast.showToast(context: context,
                                                    message:   "Project Creation Failed");
                                                }
                                              }
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
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
