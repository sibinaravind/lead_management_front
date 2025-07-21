import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/model/models.dart';
import 'package:overseas_front_end/res/constants/enum_class.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../controller/lead/lead_provider.dart';

class CallRecordPopup extends StatefulWidget {
  const CallRecordPopup({super.key, required this.clientId});

  final String clientId;

  @override
  State<CallRecordPopup> createState() => _CallRecordPopupState();
}

class _CallRecordPopupState extends State<CallRecordPopup>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  List<dynamic>? _selectedBranch;
  String? _selectedCallType;
  String? _selectedCallStatus;
  String? _selectedLeadStatus;
  List<dynamic>? _selectedDesignation;
  String? _selectedNationality = 'India';
  String? _selectedMaritalStatus;
  String? _selectedGender;
  Uint8List? imageBytes;
  final int minutes = 0;
  final int seconds = 0;

  // Phone/Tele codes
  String? _mobileTeleCode = '91';
  String? _whatsmobileTeleCode = '91';
  String? _alterselectedTeleCode = '91';
  String? _emerselectedTeleCode = '91';

  // Controllers
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _callDurationController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _whatsmobileController = TextEditingController();
  final TextEditingController _alternatePhoneController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _emergencycontactPersonNumberController =
      TextEditingController();
  final TextEditingController _emergencycontactPersonRelationshipController =
      TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  var _nextScheduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _joiningDateController.text = DateTime.now().toString().substring(0, 10);
  }

  @override
  void dispose() {
    _joiningDateController.dispose();
    _codeController.dispose();
    _callDurationController.dispose();
    _feedbackController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    _whatsmobileController.dispose();
    _emailController.dispose();
    _emergencyContactController.dispose();
    _emergencycontactPersonNumberController.dispose();
    _emergencycontactPersonRelationshipController.dispose();
    _address.dispose();
    _city.dispose();
    _state.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Call Followup',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: 'Register followup details',
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .68,
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
                                                  ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        CustomDropdownField(
                                                          label: 'Call Type',
                                                          value:
                                                              _selectedCallType,
                                                          items: CallType.values
                                                              .map(
                                                                  (e) => e.name)
                                                              .toList(), // enum to string
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _selectedCallType =
                                                                      val),
                                                          isRequired: true,
                                                        ),
                                                        CustomDropdownField(
                                                          label: 'Call Status',
                                                          value:
                                                              _selectedCallStatus,
                                                          items: CallStatus
                                                              .values
                                                              .map(
                                                                  (e) => e.name)
                                                              .toList(), // enum to string
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _selectedCallStatus =
                                                                      val),

                                                          isRequired: true,
                                                        ),
                                                        CustomDropdownField(
                                                          label: 'Lead Status',
                                                          value:
                                                              _selectedLeadStatus,
                                                          items: LeadStatus
                                                              .values
                                                              .map(
                                                                  (e) => e.name)
                                                              .toList(), // enum to string
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _selectedLeadStatus =
                                                                      val),

                                                          isRequired: true,
                                                        ),

                                                        CustomDateField(
                                                          isTimeRequired: true,
                                                          label:
                                                              "Next Schedule",
                                                          controller:
                                                              _nextScheduleController,
                                                        ),

                                                        CustomTextFormField(
                                                          label:
                                                              'Call Duration',
                                                          hintText:
                                                              'mm:ss or hh:mm:ss',
                                                          controller:
                                                              _callDurationController,
                                                          isRequired: true,
                                                          inputFormatters: [
                                                            DurationInputFormatter(
                                                                allowHours:
                                                                    true),
                                                            LengthLimitingTextInputFormatter(
                                                                8),
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),

                                                        // CustomDateField(controller: , label: '',isRequired: ,),
                                                        CustomTextFormField(
                                                          label: 'Feedback',
                                                          controller:
                                                              _feedbackController,
                                                          isRequired: true,
                                                        ),
                                                      ]),
                                                  const SizedBox(
                                                    height: 32,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          // Expanded(
                                          //   child: CustomActionButton(
                                          //     text: 'Reset',
                                          //     icon: Icons.refresh_rounded,
                                          //     onPressed: () {
                                          //       // Your reset logic
                                          //     },
                                          //     borderColor: Colors.grey.shade300,
                                          //   ),
                                          // ),
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
                                              text: 'Save Feedback',
                                              icon: Icons.save_rounded,
                                              isFilled: true,
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF7F00FF),
                                                  Color(0xFFE100FF)
                                                ],
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  Provider.of<LeadProvider>(
                                                    listen: false,
                                                    context,
                                                  ).addFeedback(context,
                                                      clientId: widget.clientId,
                                                      duration:
                                                          _callDurationController
                                                              .text
                                                              .trim(),
                                                      nextSchedule:
                                                          _nextScheduleController
                                                              .text
                                                              .trim(),
                                                      clientStatus:
                                                          _selectedLeadStatus ??
                                                              '',
                                                      comment:
                                                          _feedbackController
                                                              .text
                                                              .trim(),
                                                      callType:
                                                          _selectedCallType ??
                                                              '',
                                                      callStatus:
                                                          _selectedCallStatus ??
                                                              '');
                                                  // showLoaderDialog(context);
                                                  // officerController
                                                  //     .addOfficer(OfficerModel(
                                                  //   branch:
                                                  //       _selectedBranch ?? [],
                                                  //   designation:
                                                  //       _selectedDesignation ??
                                                  //           [],
                                                  //   joiningDate:
                                                  //       _joiningDateController
                                                  //           .text,
                                                  //   // salutation:
                                                  //   //     _selectedSalutation,
                                                  //   // firstName:
                                                  //   //     _firstNameController.text,
                                                  //   middleName:
                                                  //       _middleNameController
                                                  //           .text,
                                                  //   lastName:
                                                  //       _lastNameController
                                                  //           .text,
                                                  //   dob: _dobController.text,
                                                  //   address: _address.text,
                                                  //   city: _city.text,
                                                  //   state: _state.text,
                                                  //   alternatePhone:
                                                  //       _alterselectedTeleCode
                                                  //               .toString() +
                                                  //           _alternatePhoneController
                                                  //               .text,
                                                  // ));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
