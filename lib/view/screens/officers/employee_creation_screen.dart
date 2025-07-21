import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overseas_front_end/controller/permission_controller/access_permission_controller.dart';
import 'package:overseas_front_end/model/models.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_multi_selection_dropdown_field.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../controller/config_provider.dart';
import '../../../controller/officers_controller/officers_controller.dart';
import '../../../model/team_lead/team_lead_model.dart';
import '../employee/employee_permission_screen.dart';

class EmployeeCreationScreen extends StatefulWidget {
  final bool isEdit;
  final TeamLeadModel? officer;
  const EmployeeCreationScreen({super.key, required this.isEdit, this.officer});

  @override
  State<EmployeeCreationScreen> createState() => _EmployeeCreationScreenState();
}

class _EmployeeCreationScreenState extends State<EmployeeCreationScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  List<dynamic>? _selectedBranch;
  String? _selectedSalutation = "Mr";
  String? _selectedGender;
  Uint8List? imageBytes;
  List<String> salutationList = ['Mr', 'Mrs', 'Ms', 'Dr'];

  String? _mobileTeleCode = '91';
  String? _whatsmobileTeleCode = '91';
  String prefix = '';
  String name = '';

  // Controllers
  final TextEditingController officerNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController officerIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _companyPhoneNumberController =
      TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> designation = [];
  List<String> branch = [];
  List<String> department = [];

  String status = 'ACTIVE';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider =
          Provider.of<AccessPermissionProvider>(context, listen: false);
      await provider.fetchAccessPermissions(
        context,
      );
    });
    String name = widget.officer?.name ?? '';
    List<String> parts = name.trim().split(' ');

    if (parts.isNotEmpty && salutationList.contains(parts[0])) {
      prefix = parts[0];
      name = parts.sublist(1).join(' ');
    }
    _selectedGender = widget.officer?.gender ?? '';
    officerNameController.text = name ?? '';
    _selectedSalutation = prefix ?? '';
    officerIdController.text = widget.officer?.officerId ?? '';
    _phoneNumberController.text = widget.officer?.phone ?? '';
    _companyPhoneNumberController.text =
        widget.officer?.companyPhoneNumber ?? '';
    _branchController.text = widget.officer?.branch.toString() ?? '';
    // _statusController.text=widget.officer?.status??'';
    _statusController.text = widget.officer?.status ?? 'ACTIVE';
    _designationController.text = widget.officer?.designation.toString() ?? '';
    // _departmentController.text = widget.officer?.department.toString() ?? '';
    branch = widget.officer?.branch ?? [];
    super.initState();
  }

  // void splitNameWithPrefix(String fullName) {
  //
  //   List<String> parts = fullName.trim().split(' ');
  //
  //   if (parts.isNotEmpty && salutationList.contains(parts[0])) {
  //     prefix = parts[0];
  //     name = parts.sublist(1).join(' ');
  //   }
  //
  // }

  @override
  void dispose() {
    officerNameController.dispose();
    _codeController.dispose();
    officerIdController.dispose();
    _phoneNumberController.dispose();
    _companyPhoneNumberController.dispose();
    _branchController.dispose();
    _statusController.dispose();
    _designationController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDlg) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            double dialogWidth = maxWidth;
            if (maxWidth > 1400) {
              dialogWidth = maxWidth * 0.72;
            } else if (maxWidth > 1000) {
              dialogWidth = maxWidth * 0.9;
            } else if (maxWidth > 600) {
              dialogWidth = maxWidth * 0.95;
            }

            return Center(
              child: Container(
                width: dialogWidth,
                height: maxHeight * 0.95,
                constraints: const BoxConstraints(
                  minWidth: 320,
                  maxWidth: 1600,
                  minHeight: 500,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.9),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
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
                              Icons.person_add_alt_1_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: widget.isEdit
                                      ? 'Update Officer'
                                      : 'Officer Registration',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: widget.isEdit
                                      ? 'Update officers details'
                                      : 'Register new officer with complete details',
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white, size: 24),
                            onPressed: () => Navigator.of(context).pop(),
                            tooltip: 'Close',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(24),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final availableWidth =
                                                constraints.maxWidth;
                                            int columnsCount = 1;

                                            if (availableWidth > 1000) {
                                              columnsCount = 3;
                                            } else if (availableWidth > 600) {
                                              columnsCount = 2;
                                            }

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SectionTitle(
                                                    title: 'Basic Details',
                                                    icon: Icons
                                                        .person_outline_rounded),
                                                const SizedBox(height: 16),
                                                ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomDropdownField(
                                                        label: 'Salutation',
                                                        value:
                                                            _selectedSalutation,
                                                        items: salutationList,
                                                        onChanged: (val) =>
                                                            setState(() =>
                                                                _selectedSalutation =
                                                                    val),
                                                        isRequired: true,
                                                      ),
                                                      CustomTextFormField(
                                                        label: 'Officer Name',
                                                        controller:
                                                            officerNameController,
                                                        isRequired: true,
                                                      ),
                                                      CustomTextFormField(
                                                        readOnly: false,
                                                        label: 'Officer Id',
                                                        controller:
                                                            officerIdController,
                                                      ),
                                                    ]),
                                                const SizedBox(height: 24),
                                                CustomGenderWidget(
                                                  isRequired: true,
                                                  selectedGender:
                                                      _selectedGender,
                                                  onGenderChanged: (value) =>
                                                      setState(() =>
                                                          _selectedGender =
                                                              value),
                                                ),
                                                const SizedBox(height: 32),
                                                const SectionTitle(
                                                    title:
                                                        'Contact Information',
                                                    icon: Icons
                                                        .contact_phone_rounded),
                                                const SizedBox(height: 16),
                                                ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomPhoneField(
                                                        label: 'Phone Number',
                                                        controller:
                                                            _phoneNumberController,
                                                        selectedCountry:
                                                            _mobileTeleCode,
                                                        onCountryChanged: (val) =>
                                                            setState(() =>
                                                                _mobileTeleCode =
                                                                    val),
                                                        isRequired: false,
                                                      ),
                                                      CustomPhoneField(
                                                        label: 'Company Phone',
                                                        controller:
                                                            _companyPhoneNumberController,
                                                        selectedCountry:
                                                            _whatsmobileTeleCode,
                                                        onCountryChanged: (val) =>
                                                            setState(() =>
                                                                _whatsmobileTeleCode =
                                                                    val),
                                                        isRequired: false,
                                                      ),
                                                    ]),
                                                const SizedBox(height: 32),
                                                const SectionTitle(
                                                    title: 'Official Details',
                                                    icon: Icons
                                                        .location_on_rounded),
                                                const SizedBox(height: 16),
                                                ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      // CustomDropdownField(
                                                      //     label: "ACTIVE",
                                                      //     value: status,
                                                      //     items: ['ACTIVE'],
                                                      //     onChanged: (value) {
                                                      //       status =
                                                      //           value ?? '';
                                                      //     }),
                                                      CustomTextFormField(
                                                          label: "Status",
                                                          controller:
                                                              _statusController),

                                                      Consumer<
                                                              AccessPermissionProvider>(
                                                          builder: (context,
                                                              value, child) {
                                                        return CustomMultiSelectDropdownField(
                                                            label:
                                                                "designation",
                                                            selectedItems:
                                                                designation,
                                                            items: value
                                                                .permissions
                                                                .map((e) =>
                                                                    e.category ??
                                                                    '')
                                                                .toList(),
                                                            onChanged:
                                                                (values) {
                                                              setStateDlg(() {
                                                                designation =
                                                                    values;
                                                              });
                                                            });
                                                      }),

                                                      // Consumer2<ConfigProvider,
                                                      //     AccessPermissionProvider>(
                                                      //   builder:
                                                      //       (BuildContext context,
                                                      //           value,
                                                      //           value2,
                                                      //           Widget? child) {
                                                      //     return CustomCheckDropdown<
                                                      //         String>(
                                                      //       label: "Designation",
                                                      //       items: value2
                                                      //               .accessPermission
                                                      //               ?.toJson()
                                                      //               .keys
                                                      //               .where(
                                                      //                 (element) =>
                                                      //                     !element
                                                      //                         .contains("_id"),
                                                      //               )
                                                      //               .toList() ??
                                                      //           [],
                                                      //       onChanged: (values) {
                                                      //         var code = value
                                                      //             .configModelList
                                                      //             ?.designation
                                                      //             ?.where((e) =>
                                                      //                 values.contains(
                                                      //                     e.name))
                                                      //             .map((e) =>
                                                      //                 int.parse(
                                                      //                     e.code ??
                                                      //                         '0'))
                                                      //             .toList();
                                                      //         designation =
                                                      //             code ?? [];
                                                      //         //     value ??
                                                      //         //         '';
                                                      //       },
                                                      //       values: [],
                                                      //     );
                                                      //   },
                                                      // ),
                                                      Consumer<ConfigProvider>(
                                                        builder: (BuildContext
                                                                context,
                                                            value,
                                                            Widget? child) {
                                                          return CustomCheckDropdown<
                                                              String>(
                                                            label: "Branch",
                                                            items: value
                                                                    .configModelList
                                                                    ?.branch
                                                                    ?.map((e) =>
                                                                        (e.name ??
                                                                            "") ??
                                                                        (''))
                                                                    .toList() ??
                                                                [],
                                                            onChanged: (value) {
                                                              branch = value;
                                                            },
                                                            values: branch,
                                                          );
                                                        },
                                                      ),
                                                    ]),
                                                const SizedBox(height: 20),
                                                Visibility(
                                                  visible: widget.isEdit
                                                      ? false
                                                      : true,
                                                  child: const SectionTitle(
                                                      title:
                                                          'Additional Details',
                                                      icon: Icons
                                                          .more_horiz_rounded),
                                                ),
                                                const SizedBox(height: 16),
                                                Visibility(
                                                  visible: widget.isEdit
                                                      ? false
                                                      : true,
                                                  child: ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        CustomTextFormField(
                                                          label: 'Password',
                                                          controller:
                                                              _passwordController,
                                                          isRequired: true,
                                                        ),
                                                      ]),
                                                ),
                                                const SizedBox(height: 32),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
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
                                          text: widget.isEdit
                                              ? 'Update Officer'
                                              : 'Save Officer',
                                          icon: Icons.save_rounded,
                                          isFilled: true,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF7F00FF),
                                              Color(0xFFE100FF)
                                            ],
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              // showLoaderDialog(context);
                                              widget.isEdit
                                                  ? updateOfficer()
                                                  : createOfficer();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  createOfficer() async {
    final officer = {
      "officer_id": officerIdController.text,
      "name": '$_selectedSalutation ${officerNameController.text}',
      "gender": _selectedGender.toString(),
      "phone": _phoneNumberController.text,
      "company_phone_number": _companyPhoneNumberController.text,
      "status": _statusController.text,
      "designation": designation,
      "department": department,

      ///not required

      ///-------------not added - static ----------
      "branch": branch,
      "password": _passwordController.text
    };

    final provider =
        Provider.of<OfficersControllerProvider>(context, listen: false);
    final success = await provider.createOfficer(context, officer);

    if (success) {
      Navigator.pop(context);
      CustomSnackBar.show(context, "Employee created successfully");
    } else {
      CustomSnackBar.show(context, "Creation failed",
          backgroundColor: AppColors.redSecondaryColor);
    }
  }

  updateOfficer() async {
    final updatedData = {
      "name": "$_selectedSalutation ${officerNameController.text}",
      "gender": _selectedGender ?? '',
      "phone": _phoneNumberController.text,
      "company_phone_number": _companyPhoneNumberController.text,
      "status": _statusController.text,
      "designation": designation,
      "department": department,

      /// not required
      "branch": branch,
      "_id": widget.officer?.sId,
      "officer_id": officerIdController.text,
      // "password": _passwordController.text,
    };

    final officerId = widget.officer?.sId; // or officerIdController.text

    if (officerId != null) {
      bool success = await OfficersControllerProvider()
          .updateOfficer(context, officerId, updatedData);

      if (success) {
        Navigator.pop(context);
        CustomSnackBar.show(context, "Employee updated successfully");
      } else {
        CustomSnackBar.show(context, "Creation failed",
            backgroundColor: AppColors.redSecondaryColor);
      }
    }
  }
}
