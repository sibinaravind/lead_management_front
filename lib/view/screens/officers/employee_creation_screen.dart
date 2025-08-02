import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/permission_controller/access_permission_controller.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/officers_controller/officers_controller.dart';

class EmployeeCreationScreen extends StatefulWidget {
  final bool isEdit;
  final OfficerModel? officer;
  const EmployeeCreationScreen({super.key, required this.isEdit, this.officer});

  @override
  State<EmployeeCreationScreen> createState() => _EmployeeCreationScreenState();
}

class _EmployeeCreationScreenState extends State<EmployeeCreationScreen>
    with TickerProviderStateMixin {
  final OfficersController officersController = Get.find<OfficersController>();
  final AccessPermissionController accessPermissionController =
      Get.find<AccessPermissionController>();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String? _selectedSalutation = 'Mr';
  String? _selectedGender;
  Uint8List? imageBytes;
  List<String> salutationList = ['Mr', 'Mrs', 'Ms', 'Dr'];
  String? _phoneCode = '+91';
  String? _companyPhoneCode = '+91';
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
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    String name = widget.officer?.name ?? '';
    List<String> parts = name.trim().split(' ');
    if (parts.isNotEmpty && salutationList.contains(parts[0])) {
      prefix = parts[0];
      name = parts.sublist(1).join(' ');
    }
    String fullPhone = widget.officer?.phone ?? '';
    if (fullPhone.contains(' ')) {
      _phoneCode = fullPhone.split(' ').first;
      _phoneNumberController.text = fullPhone.split(' ').sublist(1).join(' ');
    } else {
      _phoneCode = '+91';
      _phoneNumberController.text = fullPhone;
    }
    String fullCompanyPhone = widget.officer?.companyPhoneNumber ?? '';
    if (fullCompanyPhone.contains(' ')) {
      _companyPhoneCode = fullCompanyPhone.split(' ').first;
      _companyPhoneNumberController.text =
          fullCompanyPhone.split(' ').sublist(1).join(' ');
    } else {
      _companyPhoneCode = '+91';
      _companyPhoneNumberController.text = fullCompanyPhone;
    }
    status = widget.officer?.status ?? 'ACTIVE';
    _selectedGender = widget.officer?.gender ?? '';
    officerNameController.text = name;
    _selectedSalutation = prefix;
    officerIdController.text = widget.officer?.officerId ?? '';
    _branchController.text = widget.officer?.branch.toString() ?? '';
    _statusController.text = widget.officer?.status ?? 'ACTIVE';
    designation =
        widget.officer?.designation?.map((e) => e.toString()).toList() ?? [];
    branch = widget.officer?.branch ?? [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    officerNameController.dispose();
    _codeController.dispose();
    officerIdController.dispose();
    _phoneNumberController.dispose();
    _companyPhoneNumberController.dispose();
    _branchController.dispose();
    _statusController.dispose();
    _designationController.dispose();
    _departmentController.dispose();
    _passwordController.dispose();
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
                constraints: BoxConstraints(
                  minWidth: 320,
                  maxWidth: 1600,
                  maxHeight: maxHeight * 0.95,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Section
                    _buildHeader(),
                    // Main Content Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          thumbVisibility: true,
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            padding: const EdgeInsets.all(24),
                                            child:
                                                _buildFormContent(setStateDlg),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      if (widget.isEdit) _buildSidePanel(),
                                    ],
                                  ),
                                ),
                                _buildActionButtons(),
                              ],
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

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                  text:
                      widget.isEdit ? 'Update Officer' : 'Officer Registration',
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
            icon:
                const Icon(Icons.close_rounded, color: Colors.white, size: 24),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(StateSetter setStateDlg) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        int columnsCount = 1;

        if (availableWidth > 1000) {
          columnsCount = 3;
        } else if (availableWidth > 600) {
          columnsCount = 2;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
                title: 'Basic Details', icon: Icons.person_outline_rounded),
            const SizedBox(height: 16),
            ResponsiveGrid(columns: columnsCount, children: [
              CustomDropdownField(
                label: 'Salutation',
                value: _selectedSalutation,
                items: salutationList,
                onChanged: (val) => setState(() => _selectedSalutation = val),
                isRequired: true,
              ),
              CustomTextFormField(
                label: 'Officer Name',
                controller: officerNameController,
                isRequired: true,
              ),
              CustomTextFormField(
                isRequired: true,
                readOnly: false,
                label: 'Officer Id',
                controller: officerIdController,
              ),
            ]),
            const SizedBox(height: 24),
            CustomGenderWidget(
              isRequired: true,
              selectedGender: _selectedGender,
              onGenderChanged: (value) =>
                  setState(() => _selectedGender = value),
            ),
            const SizedBox(height: 32),
            const SectionTitle(
                title: 'Contact Information',
                icon: Icons.contact_phone_rounded),
            const SizedBox(height: 16),
            ResponsiveGrid(columns: columnsCount, children: [
              CustomPhoneField(
                label: 'Phone Number',
                controller: _phoneNumberController,
                selectedCountry: _phoneCode,
                onCountryChanged: (val) => setState(() => _phoneCode = val),
                isRequired: true,
              ),
              CustomPhoneField(
                label: 'Company Phone',
                controller: _companyPhoneNumberController,
                selectedCountry: _companyPhoneCode,
                onCountryChanged: (val) =>
                    setState(() => _companyPhoneCode = val),
                isRequired: false,
              ),
            ]),
            const SizedBox(height: 32),
            const SectionTitle(
                title: 'Official Details', icon: Icons.location_on_rounded),
            const SizedBox(height: 16),
            ResponsiveGrid(columns: columnsCount, children: [
              Obx(() => CustomMultiSelectDropdownField(
                  isRequired: true,
                  label: "designation",
                  selectedItems: designation,
                  items: accessPermissionController.permissions
                      .map((e) => e.category ?? '')
                      .toList(),
                  onChanged: (values) {
                    setStateDlg(() {
                      designation = values;
                    });
                  })),
            ]),
            const SizedBox(height: 20),
            if (!widget.isEdit) ...[
              const SectionTitle(
                  title: 'Additional Details', icon: Icons.more_horiz_rounded),
              const SizedBox(height: 16),
              ResponsiveGrid(columns: columnsCount, children: [
                CustomTextFormField(
                  showPasswordToggle: true,
                  label: "Password",
                  controller: _passwordController,
                  isRequired: true,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (!RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$',
                    ).hasMatch(value)) {
                      return "Password must be at least 8 characters long, \ninclude upper & lowercase letters, a number, and a special character.";
                    }
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 32),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSidePanel() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.violetPrimaryColor.withOpacity(0.08),
            AppColors.blueSecondaryColor.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.violetPrimaryColor.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          CustomText(
            text: 'Profile Settings',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 24),
          EnhancedSwitchTile(
            label: 'Status',
            icon: Icons.account_box,
            value: status == 'ACTIVE' ? true : false,
            onChanged: (val) =>
                setState(() => status = val ? 'ACTIVE' : 'INACTIVE'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
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
              text: widget.isEdit ? 'Update Officer' : 'Save Officer',
              icon: Icons.save_rounded,
              isFilled: true,
              gradient: const LinearGradient(
                colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
              ),
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.isEdit
                      ? await updateOfficer(context)
                      : await createOfficer(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createOfficer(BuildContext context) async {
    OfficerModel officer = OfficerModel(
      officerId: officerIdController.text,
      name: '$_selectedSalutation ${officerNameController.text}',
      gender: _selectedGender.toString(),
      branch: ["AFFINIX"],
      phone: '$_phoneCode ${_phoneNumberController.text}',
      companyPhoneNumber: _companyPhoneNumberController.text.isEmpty
          ? null
          : '$_companyPhoneCode ${_companyPhoneNumberController.text}',
      status: _statusController.text,
      designation: designation,
      password: _passwordController.text,
    );

    final success = await officersController.createOfficer(officer);
    if (success) {
      Navigator.pop(context);
      CustomSnackBar.show(context, "Employee created successfully");
    } else {
      CustomToast.showToast(
        message: "Creation failed",
        context: context,
        backgroundColor: AppColors.redSecondaryColor,
      );
    }
  }

  Future<void> updateOfficer(BuildContext context) async {
    OfficerModel updatedData = OfficerModel(
      name: "$_selectedSalutation ${officerNameController.text}",
      gender: _selectedGender ?? '',
      phone: '$_phoneCode ${_phoneNumberController.text}',
      companyPhoneNumber: _companyPhoneNumberController.text.isEmpty
          ? null
          : '$_companyPhoneCode ${_companyPhoneNumberController.text}',
      status: status,
      designation: designation,
      id: widget.officer?.id,
      officerId: officerIdController.text,
    );

    final officerId = widget.officer?.id;

    if (officerId != null) {
      bool success =
          await officersController.updateOfficer(officerId, updatedData);
      if (success) {
        Navigator.pop(context);
        CustomSnackBar.show(context, "Employee updated successfully");
      } else {
        CustomToast.showToast(
          message: "Updation failed",
          context: context,
          backgroundColor: AppColors.redSecondaryColor,
        );
      }
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/permission_controller/access_permission_controller.dart';
// import 'package:overseas_front_end/model/officer/officer_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/custom_toast.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import '../../../controller/officers_controller/officers_controller.dart';

// class EmployeeCreationScreen extends StatefulWidget {
//   final bool isEdit;
//   final OfficerModel? officer;
//   const EmployeeCreationScreen({super.key, required this.isEdit, this.officer});

//   @override
//   State<EmployeeCreationScreen> createState() => _EmployeeCreationScreenState();
// }

// class _EmployeeCreationScreenState extends State<EmployeeCreationScreen>
//     with TickerProviderStateMixin {
//   final OfficersController officersController = Get.find<OfficersController>();
//   final AccessPermissionController accessPermissionController =
//       Get.find<AccessPermissionController>();
//   final _formKey = GlobalKey<FormState>();
//   final ScrollController _scrollController =
//       ScrollController(); // Added ScrollController

//   String? _selectedSalutation = 'Mr';
//   String? _selectedGender;
//   Uint8List? imageBytes;
//   List<String> salutationList = ['Mr', 'Mrs', 'Ms', 'Dr'];
//   String? _phoneCode = '+91';
//   String? _companyPhoneCode = '+91';
//   String prefix = '';
//   String name = '';

//   // Controllers
//   final TextEditingController officerNameController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   final TextEditingController officerIdController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _companyPhoneNumberController =
//       TextEditingController();
//   final TextEditingController _branchController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   List<String> designation = [];
//   List<String> branch = [];
//   List<String> department = [];
//   String status = 'ACTIVE';

//   @override
//   void initState() {
//     super.initState();
//     String name = widget.officer?.name ?? '';
//     List<String> parts = name.trim().split(' ');
//     if (parts.isNotEmpty && salutationList.contains(parts[0])) {
//       prefix = parts[0];
//       name = parts.sublist(1).join(' ');
//     }
//     String fullPhone = widget.officer?.phone ?? '';
//     if (fullPhone.contains(' ')) {
//       _phoneCode = fullPhone.split(' ').first;
//       _phoneNumberController.text = fullPhone.split(' ').sublist(1).join(' ');
//     } else {
//       _phoneCode = '+91';
//       _phoneNumberController.text = fullPhone;
//     }
//     String fullCompanyPhone = widget.officer?.companyPhoneNumber ?? '';
//     if (fullCompanyPhone.contains(' ')) {
//       _companyPhoneCode = fullCompanyPhone.split(' ').first;
//       _companyPhoneNumberController.text =
//           fullCompanyPhone.split(' ').sublist(1).join(' ');
//     } else {
//       _companyPhoneCode = '+91';
//       _companyPhoneNumberController.text = fullCompanyPhone;
//     }
//     _selectedGender = widget.officer?.gender ?? '';
//     officerNameController.text = name;
//     _selectedSalutation = prefix;
//     officerIdController.text = widget.officer?.officerId ?? '';
//     _branchController.text = widget.officer?.branch.toString() ?? '';
//     _statusController.text = widget.officer?.status ?? 'ACTIVE';
//     designation =
//         widget.officer?.designation?.map((e) => e.toString()).toList() ?? [];
//     branch = widget.officer?.branch ?? [];
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // Dispose the ScrollController
//     officerNameController.dispose();
//     _codeController.dispose();
//     officerIdController.dispose();
//     _phoneNumberController.dispose();
//     _companyPhoneNumberController.dispose();
//     _branchController.dispose();
//     _statusController.dispose();
//     _designationController.dispose();
//     _departmentController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//       builder: (context, setStateDlg) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: const EdgeInsets.all(8),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final maxWidth = constraints.maxWidth;
//             final maxHeight = constraints.maxHeight;

//             double dialogWidth = maxWidth;
//             if (maxWidth > 1400) {
//               dialogWidth = maxWidth * 0.72;
//             } else if (maxWidth > 1000) {
//               dialogWidth = maxWidth * 0.9;
//             } else if (maxWidth > 600) {
//               dialogWidth = maxWidth * 0.95;
//             }

//             return Center(
//               child: Container(
//                 width: dialogWidth,
//                 height: maxHeight * 0.95,
//                 constraints: const BoxConstraints(
//                   minWidth: 320,
//                   maxWidth: 1600,
//                   minHeight: 500,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.15),
//                       spreadRadius: 0,
//                       blurRadius: 40,
//                       offset: const Offset(0, 20),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Header section remains the same
//                     Container(
//                       height: 80,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 24, vertical: 16),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             AppColors.primaryColor,
//                             AppColors.primaryColor.withOpacity(0.9),
//                           ],
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
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
//                               Icons.person_add_alt_1_rounded,
//                               size: 22,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CustomText(
//                                   text: widget.isEdit
//                                       ? 'Update Officer'
//                                       : 'Officer Registration',
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 CustomText(
//                                   text: widget.isEdit
//                                       ? 'Update officers details'
//                                       : 'Register new officer with complete details',
//                                   fontSize: 13,
//                                   color: Colors.white70,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           IconButton(
//                             icon: const Icon(Icons.close_rounded,
//                                 color: Colors.white, size: 24),
//                             onPressed: () => Navigator.of(context).pop(),
//                             tooltip: 'Close',
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Main content section - fixed the Expanded issue here
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Form(
//                           key: _formKey,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Scrollbar(
//                                     controller: _scrollController,
//                                     thumbVisibility: true,
//                                     child: SingleChildScrollView(
//                                       controller: _scrollController,
//                                       padding: const EdgeInsets.all(24),
//                                       child: LayoutBuilder(
//                                         builder: (context, constraints) {
//                                           final availableWidth =
//                                               constraints.maxWidth;
//                                           int columnsCount = 1;

//                                           if (availableWidth > 1000) {
//                                             columnsCount = 3;
//                                           } else if (availableWidth > 600) {
//                                             columnsCount = 2;
//                                           }

//                                           return Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SectionTitle(
//                                                   title: 'Basic Details',
//                                                   icon: Icons
//                                                       .person_outline_rounded),
//                                               const SizedBox(height: 16),
//                                               ResponsiveGrid(
//                                                   columns: columnsCount,
//                                                   children: [
//                                                     CustomDropdownField(
//                                                       label: 'Salutation',
//                                                       value:
//                                                           _selectedSalutation,
//                                                       items: salutationList,
//                                                       onChanged: (val) =>
//                                                           setState(() =>
//                                                               _selectedSalutation =
//                                                                   val),
//                                                       isRequired: true,
//                                                     ),
//                                                     CustomTextFormField(
//                                                       label: 'Officer Name',
//                                                       controller:
//                                                           officerNameController,
//                                                       isRequired: true,
//                                                     ),
//                                                     CustomTextFormField(
//                                                       isRequired: true,
//                                                       readOnly: false,
//                                                       label: 'Officer Id',
//                                                       controller:
//                                                           officerIdController,
//                                                     ),
//                                                   ]),
//                                               const SizedBox(height: 24),
//                                               CustomGenderWidget(
//                                                 isRequired: true,
//                                                 selectedGender: _selectedGender,
//                                                 onGenderChanged: (value) =>
//                                                     setState(() =>
//                                                         _selectedGender =
//                                                             value),
//                                               ),
//                                               const SizedBox(height: 32),
//                                               const SectionTitle(
//                                                   title: 'Contact Information',
//                                                   icon: Icons
//                                                       .contact_phone_rounded),
//                                               const SizedBox(height: 16),
//                                               ResponsiveGrid(
//                                                   columns: columnsCount,
//                                                   children: [
//                                                     CustomPhoneField(
//                                                       label: 'Phone Number',
//                                                       controller:
//                                                           _phoneNumberController,
//                                                       selectedCountry:
//                                                           _phoneCode,
//                                                       onCountryChanged: (val) =>
//                                                           setState(() =>
//                                                               _phoneCode = val),
//                                                       isRequired: true,
//                                                     ),
//                                                     CustomPhoneField(
//                                                       label: 'Company Phone',
//                                                       controller:
//                                                           _companyPhoneNumberController,
//                                                       selectedCountry:
//                                                           _companyPhoneCode,
//                                                       onCountryChanged: (val) =>
//                                                           setState(() =>
//                                                               _companyPhoneCode =
//                                                                   val),
//                                                       isRequired: false,
//                                                     ),
//                                                   ]),
//                                               const SizedBox(height: 32),
//                                               const SectionTitle(
//                                                   title: 'Official Details',
//                                                   icon: Icons
//                                                       .location_on_rounded),
//                                               const SizedBox(height: 16),
//                                               ResponsiveGrid(
//                                                   columns: columnsCount,
//                                                   children: [
//                                                     Obx(() =>
//                                                         CustomMultiSelectDropdownField(
//                                                             isRequired: true,
//                                                             label:
//                                                                 "designation",
//                                                             selectedItems:
//                                                                 designation,
//                                                             items: accessPermissionController
//                                                                 .permissions
//                                                                 .map((e) =>
//                                                                     e.category ??
//                                                                     '')
//                                                                 .toList(),
//                                                             onChanged:
//                                                                 (values) {
//                                                               setStateDlg(() {
//                                                                 designation =
//                                                                     values;
//                                                               });
//                                                             })),
//                                                   ]),
//                                               const SizedBox(height: 20),
//                                               Visibility(
//                                                 visible: widget.isEdit
//                                                     ? false
//                                                     : true,
//                                                 child: const SectionTitle(
//                                                     title: 'Additional Details',
//                                                     icon: Icons
//                                                         .more_horiz_rounded),
//                                               ),
//                                               const SizedBox(height: 16),
//                                               Visibility(
//                                                 visible: widget.isEdit
//                                                     ? false
//                                                     : true,
//                                                 child: ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         showPasswordToggle:
//                                                             true,
//                                                         label: "Password",
//                                                         controller:
//                                                             _passwordController,
//                                                         isRequired: true,
//                                                         obscureText: true,
//                                                         validator: (value) {
//                                                           if (value == null ||
//                                                               value.isEmpty) {
//                                                             return "Password is required";
//                                                           }
//                                                           if (!RegExp(
//                                                             r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$',
//                                                           ).hasMatch(value)) {
//                                                             return "Password must be at least 8 characters long, \ninclude upper & lowercase letters, a number, and a special character.";
//                                                           }
//                                                           return null;
//                                                         },
//                                                       ),
//                                                     ]),
//                                               ),
//                                               const SizedBox(height: 32),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     const SizedBox(width: 16),
//                                     Expanded(
//                                       child: CustomActionButton(
//                                         text: 'Cancel',
//                                         icon: Icons.close_rounded,
//                                         textColor: Colors.grey,
//                                         onPressed: () => Navigator.pop(context),
//                                         borderColor: Colors.grey.shade300,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16),
//                                     Expanded(
//                                       flex: 2,
//                                       child: CustomActionButton(
//                                         text: widget.isEdit
//                                             ? 'Update Officer'
//                                             : 'Save Officer',
//                                         icon: Icons.save_rounded,
//                                         isFilled: true,
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color(0xFF7F00FF),
//                                             Color(0xFFE100FF)
//                                           ],
//                                         ),
//                                         onPressed: () async {
//                                           if (_formKey.currentState
//                                                   ?.validate() ??
//                                               false) {
//                                             widget.isEdit
//                                                 ? await updateOfficer(context)
//                                                 : await createOfficer(context);
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> createOfficer(BuildContext context) async {
//     OfficerModel officer = OfficerModel(
//         officerId: officerIdController.text,
//         name: '$_selectedSalutation ${officerNameController.text}',
//         gender: _selectedGender.toString(),
//         branch: ["AFFINIX"],
//         phone: '$_phoneCode ${_phoneNumberController.text}',
//         companyPhoneNumber: _companyPhoneNumberController.text.isEmpty
//             ? null
//             : '$_companyPhoneCode ${_companyPhoneNumberController.text}',
//         status: _statusController.text,
//         designation: designation,
//         password: _passwordController.text);
//     final success = await officersController.createOfficer(officer);
//     if (success) {
//       Navigator.pop(context);
//       CustomSnackBar.show(context, "Employee created successfully");
//     } else {
//       CustomToast.showToast(
//           message: "Creation failed",
//           context: context,
//           backgroundColor: AppColors.redSecondaryColor);
//     }
//   }

//   Future<void> updateOfficer(BuildContext context) async {
//     OfficerModel updatedData = OfficerModel(
//       name: "$_selectedSalutation ${officerNameController.text}",
//       gender: _selectedGender ?? '',
//       phone: '$_phoneCode ${_phoneNumberController.text}',
//       companyPhoneNumber: _companyPhoneNumberController.text.isEmpty
//           ? null
//           : '$_companyPhoneCode ${_companyPhoneNumberController.text}',
//       status: _statusController.text,
//       designation: designation,
//       id: widget.officer?.id,
//       officerId: officerIdController.text,
//     );

//     final officerId = widget.officer?.id;

//     if (officerId != null) {
//       bool success =
//           await officersController.updateOfficer(officerId, updatedData);
//       if (success) {
//         Navigator.pop(context);
//         CustomSnackBar.show(context, "Employee updated successfully");
//       } else {
//         CustomToast.showToast(
//             message: "Updation failed",
//             context: context,
//             backgroundColor: AppColors.redSecondaryColor);
//       }
//     }
//   }
// }
