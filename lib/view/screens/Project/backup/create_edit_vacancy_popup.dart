import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import 'package:overseas_front_end/model/project/client_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../controller/config/config_controller.dart';
import '../../../../model/project/vacancy_model.dart';
import '../../../widgets/custom_toast.dart';

class CreateEditVacancyPopup extends StatefulWidget {
  final bool isEditMode;
  final VacancyModel? vacancy;

  const CreateEditVacancyPopup({
    super.key,
    this.isEditMode = false,
    this.vacancy,
  });

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
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _organizationCategoryController =
      TextEditingController();
  final TextEditingController _lastDateToApplyController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _countryController = '';
  final TextEditingController _cityController = TextEditingController();

  List<String> qualification = [];
  List<Map<String, dynamic>> _selectedClients = [];
  String clients = '';
  String projectList = '';
  String projectId = '';
  late TabController _tabController;
  late final List<String> specializationDropdownItems;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _vacancyController = TextEditingController();
  // final TextEditingController _commissionController = TextEditingController();
  final TextEditingController _targetCvController = TextEditingController();
  final TextEditingController _commissionController = TextEditingController();
  final _configController = Get.find<ConfigController>();
  final _projectController = Get.find<ProjectController>();
  String specializedSelection = '';
  @override
  void initState() {
    _countryController = widget.isEditMode ? widget.vacancy?.country ?? "" : '';
    _cityController.text = widget.isEditMode ? widget.vacancy?.city ?? "" : '';
    projectList =
        widget.isEditMode ? widget.vacancy?.project?.projectName ?? '' : '';
    _organizationCategoryController.text = widget.isEditMode
        ? widget.vacancy?.project?.organizationCategory ?? ""
        : '';
    _jobTitleController.text =
        widget.isEditMode ? widget.vacancy?.jobTitle ?? "" : '';
    _jobVacancyController.text =
        widget.isEditMode ? widget.vacancy?.jobCategory ?? "" : '';
    qualification = widget.isEditMode
        ? widget.vacancy?.qualifications?.map((item) => item).toList() ?? []
        : [];
    _experienceController.text =
        widget.isEditMode ? widget.vacancy?.experience ?? '' : '';
    _salaryFromController.text =
        widget.isEditMode ? widget.vacancy?.salaryFrom.toString() ?? '' : '';
    _salaryToController.text =
        widget.isEditMode ? widget.vacancy?.salaryTo.toString() ?? '' : '';
    _lastDateToApplyController.text =
        widget.isEditMode ? widget.vacancy?.lastDateToApply ?? '' : '';
    _descriptionController.text =
        widget.isEditMode ? widget.vacancy?.description ?? '' : '';
    _countryController =
        widget.isEditMode ? widget.vacancy?.country ?? '' : _countryController;
    _cityController.text =
        widget.isEditMode ? widget.vacancy?.city ?? '' : _cityController.text;
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
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
                                                        title:
                                                            'Project Details',
                                                        icon: Icons
                                                            .info_outline_rounded,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      ResponsiveGrid(
                                                          columns: columnsCount,
                                                          children: [
                                                            if (!widget
                                                                .isEditMode)
                                                              CustomDropdownField(
                                                                isSplit: true,
                                                                label:
                                                                    "Project",
                                                                value:
                                                                    projectList,
                                                                items: (Get.find<ProjectController>().projects.where((project) =>
                                                                            project.projectName !=
                                                                                null &&
                                                                            project
                                                                                .projectName!.isNotEmpty) ??
                                                                        [])
                                                                    .whereType<
                                                                        String>()
                                                                    .toList(),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    projectList =
                                                                        value ??
                                                                            '';
                                                                    projectId =
                                                                        value?.split(',').last ??
                                                                            '';
                                                                  });
                                                                },
                                                              ),
                                                            if (widget
                                                                .isEditMode)
                                                              CustomText(
                                                                  text:
                                                                      projectList)
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
                                                          CustomDropdownField(
                                                            label:
                                                                'Job category',
                                                            value:
                                                                _jobVacancyController
                                                                    .text,
                                                            items: (_configController
                                                                        .configData
                                                                        .value
                                                                        .jobCategory ??
                                                                    [])
                                                                .map((e) => e
                                                                    .toString())
                                                                .toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _jobVacancyController
                                                                        .text =
                                                                    value ?? '';
                                                              });
                                                            },
                                                          ),
                                                          CustomMultiSelectDropdownField(
                                                            isRequired: true,
                                                            isSplit: false,
                                                            label:
                                                                "Qualification",
                                                            selectedItems:
                                                                qualification,
                                                            items: _configController
                                                                    .configData
                                                                    .value
                                                                    .programType
                                                                    ?.map((item) =>
                                                                        "${item.name}")
                                                                    .toList() ??
                                                                [],
                                                            onChanged:
                                                                (selectedList) {
                                                              setState(() {
                                                                qualification =
                                                                    selectedList;
                                                              });
                                                            },
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Experience',
                                                            controller:
                                                                _experienceController,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Skills',
                                                            controller:
                                                                _skillsController,
                                                          ),
                                                          CustomTextFormField(
                                                            label:
                                                                'Salary From',
                                                            controller:
                                                                _salaryFromController,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Salary To',
                                                            controller:
                                                                _salaryToController,
                                                          ),
                                                          CustomDateField(
                                                              isRequired: true,
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
                                                            isRequired: true,
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
                                                              items: _configController
                                                                      .configData
                                                                      .value
                                                                      .country
                                                                      ?.map((item) =>
                                                                          "${item.name}")
                                                                      .toList() ??
                                                                  [],
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

                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Selected Clients',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 8),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: _projectController
                                                    .clients.length,
                                                itemBuilder: (context, index) {
                                                  Map<String, dynamic> client =
                                                      _projectController
                                                          .clients[index]
                                                          .toJson();
                                                  return Card(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: ListTile(
                                                      title: GetBuilder<
                                                          ProjectController>(
                                                        builder:
                                                            (projectController) {
                                                          final clientData =
                                                              projectController
                                                                  .clients
                                                                  .firstWhere(
                                                            (c) =>
                                                                c.sId ==
                                                                client['_id'],
                                                            orElse: () =>
                                                                ClientModel(),
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
                                                          ...client['vacancies']
                                                              .entries
                                                              .map((e) => Text(
                                                                  '${e.key} - Vacancies: ${e.value['count'] ?? ""}, Target CV: ${e.value['target_cv'] ?? ""}')),
                                                        ],
                                                      ),
                                                      trailing: IconButton(
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
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
                                        if (_projectController.clients.isEmpty)
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
                                                        'No clients Present '),
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
                                            // final vacancyProvider =
                                            //     Provider.of<ProjectProvider>(
                                            //         context,
                                            //         listen: false);

                                            // final vacancyData = {
                                            //   "project_id": projectId.trim(),
                                            //   'status': 'ACTIVE',
                                            //   "job_title":
                                            //       _jobTitleController.text,
                                            //   "job_category":
                                            //       _jobVacancyController.text,
                                            //   "qualifications": qualification,
                                            //   "experience":
                                            //       _experienceController.text,
                                            //   "skills": _skillsController.text,
                                            //   "salary_from":
                                            //       _salaryFromController.text,
                                            //   "salary_to":
                                            //       _salaryToController.text,
                                            //   "lastdatetoapply":
                                            //       _lastDateToApplyController
                                            //           .text
                                            //           .trim(),
                                            //   "description":
                                            //       _descriptionController.text,
                                            //   "country": _countryController,
                                            //   "city": _cityController.text,
                                            //   "clients": _selectedClients
                                            //       .map((client) {
                                            //     return {
                                            //       "client_id":
                                            //           client['client_id'] ?? '',
                                            //       "commission":
                                            //           client['commission'] ?? 0,
                                            //       "vacancies":
                                            //           client['vacancies'] ?? {},
                                            //     };
                                            //   }).toList(),
                                            // };

                                            // bool vacancy = await vacancyProvider
                                            //     .createVacancy(
                                            //         context, vacancyData);

                                            // if (vacancy) {
                                            //   Navigator.pop(context);
                                            //   CustomToast.showToast(
                                            //       context: context,
                                            //       message:
                                            //           "Vacancy Created Successfully");
                                            // } else {
                                            //   CustomToast.showToast(
                                            //       context: context,
                                            //       message:
                                            //           'Failed to create vacancy');
                                            // }
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
      builder: (context) {
        // Filter out already selected clients
        final filteredClients = _projectController.clients
            .where((client) => !_selectedClients
                .any((selected) => selected['client_id'] == client.sId))
            .toList();
        // For search, we need a local list to mutate
        List<ClientModel> localFilteredClients = List.from(filteredClients);

        return StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                                    localFilteredClients =
                                        List.from(filteredClients);
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
                            localFilteredClients = List.from(filteredClients);
                          } else {
                            localFilteredClients = filteredClients
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
                          }
                        });
                      },
                    ),
                  ),
                  // Results Count
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        CustomText(
                          text:
                              '${localFilteredClients.length} clients available',
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  // Client List
                  Expanded(
                    child: localFilteredClients.isEmpty
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
                            itemCount: localFilteredClients.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final client = localFilteredClients[index];
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
                                      text: client.name?[0].toUpperCase() ?? '',
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
                                      onPressed: () {
                                        // _showClientDetailsDialog(
                                        //   client.toJson()
                                        // );
                                      },
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
    );

    void _showClientDetailsDialog(Map<String, dynamic> client) {
      _vacancyController.clear();
      // _commissionController.clear();
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
                                'target_cv':
                                    int.parse(_targetCvController.text),
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
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
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
                              // _addClientWithVacancies(
                              //   client['sId'] ?? client['_id'] ?? '',
                              //   double.parse(_commissionController.text),
                              //   vacanciesMap,
                              // );
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
}
