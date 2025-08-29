import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import '../../../../model/project/project_model.dart';
import '../../../widgets/widgets.dart';

class AddEditProject extends StatefulWidget {
  final ProjectModel? project;

  final bool isEditMode;
  const AddEditProject({super.key, required this.isEditMode, this.project});

  @override
  State<AddEditProject> createState() => _AddEditProjectState();
}

class _AddEditProjectState extends State<AddEditProject> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOrganizationType;
  String? _selectedOrganizationCategory;
  String? _selectedCountry;
  String? _selectedStatus;

  List<String> selectedRemarks = [];
  final _locationController = TextEditingController();
  final _projectNameController = TextEditingController();
  final projectController = Get.find<ProjectController>();

  @override
  void initState() {
    _selectedOrganizationType = widget.project?.organizationType ?? '';
    _selectedOrganizationCategory = widget.project?.organizationCategory ?? '';
    _selectedCountry = widget.project?.country ?? '';
    _locationController.text = widget.project?.city ?? '';
    _projectNameController.text = widget.project?.projectName ?? '';
    _selectedStatus = widget.project?.status ?? '';
    // _selectedStatus=widget.project?.status??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            // final maxHeight = constraints.maxHeight;
            double dialogWidth = maxWidth;
            if (maxWidth > 1400) {
              dialogWidth = maxWidth * 0.72;
            } else if (maxWidth > 1000) {
              dialogWidth = maxWidth * 0.9;
            } else if (maxWidth > 600) {
              dialogWidth = maxWidth * 0.95;
            }

            return Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 0, top: 2, bottom: 5),
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
                                          onChanged: (val) => setState(() =>
                                              _selectedOrganizationType = val),
                                          isRequired: true,
                                        ),
                                        CustomDropdownField(
                                          label: 'Organization Category',
                                          value: _selectedOrganizationCategory,
                                          items: const [
                                            'HOSPITAL',
                                            'CONSTRUCTION',
                                            'LOGISTICS'
                                          ],
                                          onChanged: (val) => setState(() =>
                                              _selectedOrganizationCategory =
                                                  val),
                                          isRequired: true,
                                        ),
                                        if (widget.isEditMode)
                                          CustomDropdownField(
                                            label: 'Status',
                                            value: _selectedStatus,
                                            items: ['ACTIVE', 'INACTIVE'],
                                            onChanged: (val) => setState(
                                                () => _selectedStatus = val),
                                            isRequired: true,
                                          ),
                                        CustomDropdownField(
                                          items: (Get.find<ConfigController>()
                                                      .configData
                                                      .value
                                                      .country ??
                                                  [])
                                              .map((country) => country.name)
                                              .whereType<String>()
                                              .toList(),
                                          label: 'Country',
                                          isRequired: true,
                                          value: _selectedCountry,
                                          onChanged: (value) {
                                            _selectedCountry = value ?? '';
                                          },
                                        ),
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
                                    Padding(
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
                                                    showLoaderDialog(context);
                                                    await projectController
                                                        .editProject(
                                                      project: ProjectModel(
                                                        sId:
                                                            widget.project?.sId,
                                                        status:
                                                            _selectedStatus ??
                                                                'ACTIVE',
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
                                                        city:
                                                            _locationController
                                                                .text
                                                                .trim(),
                                                        country:
                                                            _selectedCountry
                                                                ?.trim(),
                                                      ),
                                                      context: context,
                                                      projectId:
                                                          widget.project?.sId ??
                                                              '',
                                                    );
                                                    Navigator.pop(context);
                                                  } else {
                                                    showLoaderDialog(context);
                                                    await projectController
                                                        .createProject(
                                                      context: context,
                                                      project: ProjectModel(
                                                        status: 'ACTIVE',
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
                                                        city:
                                                            _locationController
                                                                .text
                                                                .trim(),
                                                        country:
                                                            _selectedCountry
                                                                ?.trim(),
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
