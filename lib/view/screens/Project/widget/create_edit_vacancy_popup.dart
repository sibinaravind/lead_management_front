import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/screens/Project/widget/vacancy_client.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../controller/project/project_provider_controller.dart';
import '../../../../controller/project/vacancy_controller.dart';
import '../../../../model/app_configs/config_list_model.dart';
import '../../../widgets/custom_multi_selection_dropdown_field.dart';
import '../../../widgets/custom_toast.dart';

class CreateEditVacancyPopup extends StatefulWidget {
  final bool isEditMode;
  const CreateEditVacancyPopup({super.key, this.isEditMode = false});

  @override
  State<CreateEditVacancyPopup> createState() =>
      _ProjectClientManagementScreenState();
}

class _ProjectClientManagementScreenState extends State<CreateEditVacancyPopup>
    with SingleTickerProviderStateMixin {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobVacancyController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _salaryFromController = TextEditingController();
  final TextEditingController _salaryToController = TextEditingController();
  final TextEditingController _lastDateToApplyController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _countryController = '';
  final TextEditingController _cityController = TextEditingController();
  TextEditingController _commissionController = TextEditingController();
  List<String> qualification = [];
  String clients = '';
  String projectList = '';
  String projectId = '';
  late final dropdownItems;
  late final countryDropdownItems;
  late TabController _tabController;
  bool _isActive = true;
  bool _isInit = true;
  late final List<String> specializationDropdownItems;
  List<Map<String, dynamic>> _selectedClients = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _vacancyController = TextEditingController();
  // final TextEditingController _commissionController = TextEditingController();
  final TextEditingController _targetCvController = TextEditingController();
  String specializedSelection = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<ProjectProvider>(context, listen: false).fetchClients(context,);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final configListModel = Provider.of<ConfigProvider?>(context);
      final qualificationList =
          configListModel?.configModelList?.qualification ?? [];
      dropdownItems =
          qualificationList.map((item) => "${item.name},${item.id}").toList();

      final countryList = configListModel?.configModelList?.country ?? [];
      countryDropdownItems =
          countryList.map((item) => item.name ?? '').toList();
      final specializationList =
          configListModel?.configModelList?.specialized ?? [];
      specializationDropdownItems =
          specializationList.map((item) => item.name ?? '').toList();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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

          double dialogWidth = maxWidth > 1400
              ? maxWidth * 0.8
              : maxWidth > 1000
                  ? maxWidth * 0.9
                  : maxWidth;

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.9,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1600,
                minHeight: 600,
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
                                    ? 'Edit Vacancy '
                                    : 'Create Vacancy',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              const CustomText(
                                text: 'Manage Vacancy details',
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
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: LayoutBuilder(builder: (context, constraints) {
                  //           final availableWidth = constraints.maxWidth;
                  //           int columnsCount = availableWidth > 1000 ? 3 : 2;
                  //           return ProjectDetails(columnsCount: columnsCount, jobTitleController: _jobTitleController, jobVacancyController: _jobVacancyController, experienceController: _experienceController, skillsController: _skillsController, salaryFromController: _salaryFromController, salaryToController: _salaryToController, lastDateToApplyController: _lastDateToApplyController, descriptionController: _descriptionController, countryController: _countryController, cityController: _cityController);
                  //         }),
                  //       ),
                  //       // Side Panel
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: SizedBox(
                                  height: 44,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: _tabController.index ==
                                                      0
                                                  ? LinearGradient(
                                                      colors: [
                                                        AppColors.primaryColor,
                                                        AppColors.primaryColor
                                                            .withOpacity(0.7),
                                                      ],
                                                    )
                                                  : null,
                                              color: _tabController.index == 0
                                                  ? null
                                                  : Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton.icon(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                shadowColor: Colors.transparent,
                                              ),
                                              icon: Icon(
                                                Icons.work_outline,
                                                size: 20,
                                                color: _tabController.index == 0
                                                    ? AppColors.textWhiteColour
                                                    : AppColors.primaryColor,
                                              ),
                                              label: Text(
                                                'Vacancy Details',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: _tabController.index ==
                                                          0
                                                      ? AppColors
                                                          .textWhiteColour
                                                      : AppColors.primaryColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _tabController.index = 0;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: _tabController.index ==
                                                      1
                                                  ? LinearGradient(
                                                      colors: [
                                                        AppColors.primaryColor,
                                                        AppColors.primaryColor
                                                            .withOpacity(0.7),
                                                      ],
                                                    )
                                                  : null,
                                              color: _tabController.index == 1
                                                  ? null
                                                  : Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton.icon(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                shadowColor: Colors.transparent,
                                              ),
                                              icon: Icon(
                                                Icons.work_outline,
                                                size: 20,
                                                color: _tabController.index == 1
                                                    ? AppColors.textWhiteColour
                                                    : AppColors.primaryColor,
                                              ),
                                              label: Text(
                                                'Client',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: _tabController.index ==
                                                          1
                                                      ? AppColors
                                                          .textWhiteColour
                                                      : AppColors.primaryColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _tabController.index = 1;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: LayoutBuilder(builder:
                                                (context, constraints) {
                                              final availableWidth =
                                                  constraints.maxWidth;
                                              int columnsCount =
                                                  availableWidth > 1000 ? 3 : 2;
                                              return SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      const SectionTitle(
                                                        title: 'Job Details',
                                                        icon: Icons
                                                            .info_outline_rounded,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      ResponsiveGrid(
                                                          columns: columnsCount,
                                                          children: [
                                                            Consumer<
                                                                ProjectProvider>(
                                                              builder: (context,
                                                                  provider,
                                                                  child) {
                                                                return CustomDropdownField(
                                                                  isSplit: true,
                                                                  label:
                                                                      "Project",
                                                                  value:
                                                                      projectList,
                                                                  items: (provider
                                                                      .projects
                                                                      .where((project) =>
                                                                          project.projectName !=
                                                                              null &&
                                                                          project
                                                                              .projectName!
                                                                              .isNotEmpty)
                                                                      .map((project) =>
                                                                          '${project.projectName},${project.sId}' ??
                                                                          '')
                                                                      .toList()),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      projectList =
                                                                          value ??
                                                                              '';
                                                                      projectId =
                                                                          value?.split(',').last ??
                                                                              '';
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                          height: 16),
                                                      const SectionTitle(
                                                        title: 'Job Details',
                                                        icon: Icons
                                                            .info_outline_rounded,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          // Consumer<ProjectProvider>(
                                                          //   builder: (context, provider, child) {
                                                          //     return DropdownButtonFormField<String>(
                                                          //       decoration: const InputDecoration(labelText: 'Project'),
                                                          //       value: projectId.isNotEmpty ? projectId : null,
                                                          //       items: provider.projects
                                                          //           .where((project) => project.projectName != null && project.projectName!.isNotEmpty)
                                                          //           .map((project) => DropdownMenuItem(
                                                          //         value: project.sId,
                                                          //         child: Text(project.projectName!),
                                                          //       ))
                                                          //           .toList(),
                                                          //       onChanged: (value) {
                                                          //         setState(() {
                                                          //           projectId = value ?? '';
                                                          //         });
                                                          //       },
                                                          //     );
                                                          //   },
                                                          // ),

                                                          CustomTextFormField(
                                                            label: 'Job Title',
                                                            controller:
                                                                _jobTitleController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: true,
                                                          ),
                                                          CustomTextFormField(
                                                            label:
                                                                'Job category',
                                                            controller:
                                                                _jobVacancyController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: true,
                                                          ),
                                                          // CustomMultiSelectDropdownField(label: "Qualification", selectedItems: qualification, items: dropdownItems, onChanged: (value){}),

                                                          CustomMultiSelectDropdownField(
                                                            label:
                                                                "Qualification",
                                                            selectedItems:
                                                                qualification,
                                                            items:
                                                                dropdownItems, // From mapped items
                                                            onChanged:
                                                                (selectedIds) {
                                                              setState(() {
                                                                qualification = dropdownItems
                                                                    .where((item) =>
                                                                        selectedIds
                                                                            .contains(item.split(",")[1]))
                                                                    .toList();
                                                              });
                                                            },
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Experience',
                                                            controller:
                                                                _experienceController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: false,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Skills',
                                                            controller:
                                                                _skillsController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: false,
                                                          ),
                                                          CustomTextFormField(
                                                            label:
                                                                'Salary From',
                                                            controller:
                                                                _salaryFromController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: false,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Salary To',
                                                            controller:
                                                                _salaryToController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: false,
                                                          ),
                                                          // CustomTextFormField(
                                                          //   label: 'Skills',
                                                          //   controller:_skillsController,
                                                          //   isdate: false,
                                                          //   readOnly: false,
                                                          //   isRequired: false,
                                                          // ),
                                                          CustomDateField(
                                                              label:
                                                                  "Last Date To Apply",
                                                              controller:
                                                                  _lastDateToApplyController),
                                                          CustomTextFormField(
                                                            label:
                                                                'Description',
                                                            controller:
                                                                _descriptionController,
                                                            isdate: false,
                                                            readOnly: false,
                                                            isRequired: false,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      const SectionTitle(
                                                        title:
                                                            'Country Details',
                                                        icon: Icons
                                                            .info_outline_rounded,
                                                      ),
                                                      ResponsiveGrid(
                                                          columns: columnsCount,
                                                          children: [
                                                            CustomDropdownField(
                                                              label: "Country",
                                                              value:
                                                                  _countryController, // Example: "123"
                                                              items:
                                                                  countryDropdownItems,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _countryController =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                            CustomTextFormField(
                                                                label: "City",
                                                                controller:
                                                                    _cityController),
                                                            const SizedBox(
                                                                height: 16),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                          // Side Panel
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        // Header
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: const BoxDecoration(
                                            gradient:
                                                AppColors.buttonGraidentColour,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.people,
                                                  color: Colors.white),
                                              const SizedBox(width: 8),
                                              const CustomText(
                                                text: 'Client Management',
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const Spacer(),
                                              ElevatedButton.icon(
                                                onPressed: _showAddClientDialog,
                                                icon: const Icon(Icons.add),
                                                label: const CustomText(
                                                    text: 'Add Client'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor:
                                                      Colors.blue.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Display selected clients
                                        if (_selectedClients.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Selected Clients',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(height: 8),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      _selectedClients.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final client =
                                                        _selectedClients[index];
                                                    return Card(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      child: ListTile(
                                                        title: Consumer<
                                                            ProjectProvider>(
                                                          builder: (context,
                                                              projectProvider,
                                                              child) {
                                                            final clientData =
                                                                projectProvider
                                                                    .clients
                                                                    .firstWhere(
                                                              (c) =>
                                                                  c.sId ==
                                                                  client[
                                                                      'client_id'],
                                                            );

                                                            return Text(
                                                                'Client Name: ${clientData.name ?? ""}');
                                                          },
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Commission: ${client['commission']?.toString() ?? ""}'),
                                                            const SizedBox(
                                                                height: 4),
                                                            ...client[
                                                                    'vacancies']
                                                                .entries
                                                                .map((e) => Text(
                                                                    '${e.key} - Vacancies: ${e.value['count'] ?? ""}, Target CV: ${e.value['target_cv'] ?? ""}')),
                                                          ],
                                                        ),
                                                        trailing: IconButton(
                                                          icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                          onPressed: () {
                                                            setState(() {
                                                              _selectedClients
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (_selectedClients.isEmpty)
                                          const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.people_outline,
                                                    size: 64,
                                                    color: Colors.grey),
                                                SizedBox(height: 16),
                                                CustomText(
                                                    text:
                                                        'No clients assigned'),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )

                                    // ClientManagementTabVacancy(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomActionButton(
                                        text: 'Cancel',
                                        icon: Icons.close_rounded,
                                        textColor: Colors.grey,
                                        onPressed: () => Navigator.pop(context),
                                        borderColor: Colors.grey.shade300,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 2,
                                      child: CustomActionButton(
                                        text: widget.isEditMode
                                            ? 'Update Vacancy'
                                            : 'Create Vacancy',
                                        icon: Icons.save_rounded,
                                        isFilled: true,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF7F00FF),
                                            Color(0xFFE100FF)
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (_selectedClients.isEmpty) {
                                            return CustomSnackBar.show(
                                                context, "No Client Selected");
                                          } else {
                                            final vacancyProvider =
                                                Provider.of<ProjectProvider>(
                                                    context,
                                                    listen: false);

                                            final vacancyData = {
                                              "project_id": projectId.trim(),
                                              "job_title":
                                                  _jobTitleController.text,
                                              "job_category":
                                                  _jobVacancyController.text,
                                              "qualifications": qualification,
                                              "experience":
                                                  _experienceController.text,
                                              "skills": _skillsController.text,
                                              "salary_from":
                                                  _salaryFromController.text,
                                              "salary_to":
                                                  _salaryToController.text,
                                              "lastdatetoapply":
                                                  _lastDateToApplyController
                                                      .text,
                                              "description":
                                                  _descriptionController.text,
                                              "country": _countryController,
                                              "city": _cityController.text,
                                              "clients": _selectedClients
                                                  .map((client) {
                                                return {
                                                  "client_id":
                                                      client['client_id'] ?? '',
                                                  "commission":
                                                      client['commission'] ?? 0,
                                                  "vacancies":
                                                      client['vacancies'] ?? {},
                                                };
                                              }).toList(),
                                            };

                                            await vacancyProvider
                                                .createVacancy(context,vacancyData);

                                            if (vacancyProvider.responseId !=
                                                null) {
                                              Navigator.pop(context);
                                              print(
                                                  'Vacancy Created Successfully: ${vacancyProvider.responseId}');
                                            } else {
                                              print('Failed to create vacancy');
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                        //                       BorderRadius.circular(10),
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
                        //                 _isActive ? 'Active' : 'Inactive',
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
                        //                       BorderRadius.circular(10),
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

  void _showAddClientDialog() {
    _searchController.clear();

    showDialog(
      context: context,
      builder: (context) => Consumer<ProjectProvider>(
        builder: (context, value, child) {
          value.filteredClients = value.clients
              .where((client) => !_selectedClients
                  .any((selected) => selected['client_id'] == client.sId))
              .toList();
          return StatefulBuilder(
            builder: (context, setDialogState) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: AppColors.buttonGraidentColour,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_add,
                              color: Colors.white, size: 24),
                          const SizedBox(width: 12),
                          const CustomText(
                            text: 'Add Clients to Project',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // Search Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade50,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search clients by name or email...',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setDialogState(() {
                                      value.filteredClients = value.clients;
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (query) {
                          setDialogState(() {
                            if (query.isEmpty) {
                              value.filteredClients = value.clients;
                            }
                            value.filteredClients = value.clients
                                .where((client) =>
                                    (client.name
                                            ?.toLowerCase()
                                            .contains(query.toLowerCase()) ??
                                        false) ||
                                    (client.email
                                            ?.toLowerCase()
                                            .contains(query.toLowerCase()) ??
                                        false))
                                .toList();
                          });
                        },
                      ),
                    ),
                    // Results Count
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          CustomText(
                            text:
                                '${value.filteredClients.length} clients available',
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    // Client List
                    Expanded(
                      child: value.filteredClients.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomText(
                                    text: _searchController.text.isEmpty
                                        ? 'No clients available'
                                        : 'No clients found matching "${_searchController.text}"',
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: value.filteredClients.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final client = value.filteredClients[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue.shade100,
                                      child: CustomText(
                                        text:
                                            client.name?[0].toUpperCase() ?? '',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    title: CustomText(
                                      text: client.name ?? '',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    subtitle: CustomText(
                                      text: client.email ?? '',
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        gradient: AppColors.greenGradient,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ElevatedButton.icon(
                                        onPressed: () =>
                                            _showClientDetailsDialog(
                                                client.toJson()),
                                        icon: const Icon(Icons.add, size: 18),
                                        label: const CustomText(
                                          text: 'Add',
                                          color: Colors.white,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          shadowColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showClientDetailsDialog(Map<String, dynamic> client) {
    _vacancyController.clear();
    _commissionController.clear();
    _targetCvController.clear();
    specializedSelection = '';
    List<Map<String, dynamic>> addedSpecializations = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with client info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.orangeSecondaryColor,
                        child: CustomText(
                          text: client['name'][0].toUpperCase(),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: client['name'],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: client['email'],
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Commission
                  CustomTextFormField(
                    controller: _commissionController,
                    label: 'Commission',
                    isRequired: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                  // Specialization Inputs
                  CustomDropdownField(
                    label: 'Specialized',
                    value: specializedSelection,
                    items: specializationDropdownItems,
                    onChanged: (value) {
                      setDialogState(() {
                        specializedSelection = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _vacancyController,
                    label: 'Number of Vacancies',
                    isRequired: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _targetCvController,
                    label: 'Target CV',
                    isRequired: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomActionButton(
                    text: 'Add Specialization',
                    icon: Icons.add,
                    onPressed: () {
                      if (specializedSelection.isNotEmpty &&
                          _vacancyController.text.isNotEmpty &&
                          _targetCvController.text.isNotEmpty) {
                        bool alreadyAdded = addedSpecializations.any((spec) =>
                            spec['name'].toString().toLowerCase() ==
                            specializedSelection.toLowerCase());
                        if (!alreadyAdded) {
                          setDialogState(() {
                            addedSpecializations.add({
                              'name': specializedSelection,
                              'count': int.parse(_vacancyController.text),
                              'target_cv': int.parse(_targetCvController.text),
                            });
                            specializedSelection = '';
                            _vacancyController.clear();
                            _targetCvController.clear();
                          });
                        } else {
                          CustomToast.showToast(
                            context: context,
                            message: "Already Added",
                            backgroundColor: AppColors
                                .greenSecondaryColor, // Example using your color
                          );
                        }
                      }
                    },
                    isFilled: true,
                    gradient: AppColors.orangeGradient,
                  ),
                  const SizedBox(height: 16),
                  // Show Added Specializations List
                  if (addedSpecializations.isNotEmpty)
                    Column(
                      children: [
                        const Divider(),
                        ...addedSpecializations.map((spec) => ListTile(
                              title: Text(spec['name']),
                              subtitle: Text(
                                  'Vacancies: ${spec['count']}, Target CV: ${spec['target_cv']}'),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setDialogState(() {
                                    addedSpecializations.remove(spec);
                                  });
                                },
                              ),
                            )),
                        const Divider(),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomActionButton(
                          text: 'Cancel',
                          icon: Icons.close,
                          onPressed: () => Navigator.pop(context),
                          isFilled: false,
                          textColor: Colors.blue.shade600,
                          borderColor: Colors.blue.shade100,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomActionButton(
                          text: 'Add Client',
                          icon: Icons.check,
                          onPressed: () {
                            if (addedSpecializations.isEmpty) {
                              CustomToast.showToast(
                                  context: context,
                                  message:
                                      'Please add at least one specialization');
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text(
                              //           'Please add at least one specialization')),
                              // );
                              return;
                            }
                            final Map<String, dynamic> vacanciesMap = {
                              for (var spec in addedSpecializations)
                                spec['name']: {
                                  'count': spec['count'],
                                  'target_cv': spec['target_cv'],
                                }
                            };
                            _addClientWithVacancies(
                              client['sId'] ?? client['_id'] ?? '',
                              double.parse(_commissionController.text),
                              vacanciesMap,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context); // Close both dialogs
                          },
                          isFilled: true,
                          gradient: AppColors.orangeGradient,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addClientWithVacancies(
      String clientId, double commission, Map<String, dynamic> vacancies) {
    setState(() {
      _selectedClients.add({
        'client_id': clientId,
        'commission': commission,
        'vacancies': vacancies.isNotEmpty ? vacancies : {},
      });
    });
  }

  List<Map<String, dynamic>> getClients() {
    return _selectedClients.map((client) {
      return {
        'client_id': client['client_id'],
        'commission': client['commission'],
        'vacancies': client['vacancies'],
      };
    }).toList();
  }

  void _editClient(
      String clientId, double commission, Map<String, dynamic> vacancies) {
    setState(() {
      final index =
          _selectedClients.indexWhere((c) => c['client_id'] == clientId);
      if (index != -1) {
        _selectedClients[index] = {
          'client_id': clientId,
          'commission': commission,
          'vacancies': vacancies,
        };
      }
    });
  }
}
