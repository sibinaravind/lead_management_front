import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../model/lead/call_event_model.dart';

class CallRecordPopup extends StatefulWidget {
  final String clientId;
  final String clientName;
  final CallEventModel? editData; // For edit mode
  final bool isEditMode;

  const CallRecordPopup({
    super.key,
    required this.clientId,
    required this.clientName,
    this.editData,
  }) : isEditMode = editData != null;

  @override
  State<CallRecordPopup> createState() => _CallRecordPopupState();
}

class _CallRecordPopupState extends State<CallRecordPopup>
    with TickerProviderStateMixin {
  final configController = Get.find<ConfigController>();
  final customerController = Get.find<CustomerProfileController>();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  // Controllers
  final TextEditingController _callDurationController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _nextScheduleController = TextEditingController();
  final TextEditingController _deadLeadReasonController =
      TextEditingController();
  // Dropdown values
  String? _selectedCallType;
  String? _selectedCallStatus;
  String? _selectedLeadStatus;
  String? _selectedDeadLeadReason;

  // Track if DEAD status is selected
  bool get _isDeadLeadSelected => _selectedLeadStatus?.toUpperCase() == 'DEAD';

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.isEditMode && widget.editData != null) {
      final data = widget.editData!;

      // Set dropdown values
      _selectedCallType = data.callType;
      _selectedCallStatus = data.callStatus;
      _selectedLeadStatus = data.clientStatus;
      _selectedDeadLeadReason = data.deadLeadReason;

      // Set text field values
      _callDurationController.text = data.formattedDuration;
      _feedbackController.text = data.comment ?? '';

      // Set next schedule with time
      if (data.nextSchedule != null && data.nextSheduleTime != null) {
        final date = data.nextSchedule!;
        final time = data.formattedTime;
        _nextScheduleController.text = '$date $time';
      } else if (data.nextSchedule != null) {
        _nextScheduleController.text = data.nextSchedule!;
      }

      // Set dead lead reason
      _deadLeadReasonController.text = data.deadLeadReason ?? '';
    }
  }

  @override
  void dispose() {
    _callDurationController.dispose();
    _feedbackController.dispose();
    _nextScheduleController.dispose();
    _deadLeadReasonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Parse duration
    final durationText = _callDurationController.text.trim();
    final durationSeconds = CallEventModel.parseDuration(durationText) ?? 0;

    // Parse next schedule date and time
    String? scheduleDate;
    double? scheduleTime;

    final scheduleText = _nextScheduleController.text.trim();
    if (scheduleText.isNotEmpty) {
      final parts = scheduleText.split(' ');
      if (parts.isNotEmpty) {
        scheduleDate = parts.first;

        if (parts.length > 1) {
          // Parse time from string like "14:30"
          final timeString = parts.last;
          scheduleTime = CallEventModel.parseTime(timeString);
        }
      }
    }

    // Create model
    final model = CallEventModel(
      id: widget.isEditMode ? widget.editData!.id : null,
      clientId: widget.clientId,
      duration: durationSeconds,
      nextSchedule: scheduleDate,
      nextSheduleTime: scheduleTime,
      clientStatus: _selectedLeadStatus,
      deadLeadReason: _isDeadLeadSelected ? _selectedDeadLeadReason : null,
      comment: _feedbackController.text.trim(),
      callType: _selectedCallType,
      callStatus: _selectedCallStatus,
    );

    final success = await customerController.callRecordInsert(
      context: context,
      log: model,
      // isEdit: widget.isEditMode,
    );

    if (success && context.mounted) {
      Navigator.pop(context, true); // Return success
    }
  }

  Future<bool> _showDeadLeadDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100),
        child: AlertDialog(
          title: const Text('Dead Lead Confirmation'),
          content: const Text(
            'Marking this lead as DEAD will move it to the dead leads list. '
            'Are you sure you want to proceed?',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textColor,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redSecondaryColor,
                foregroundColor: AppColors.whiteMainColor,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Procced'),
            ),
          ],
        ),
      ),
    );
    return result ?? false;
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

          // Responsive width
          double dialogWidth = maxWidth * 0.95;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.6;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.7;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.85;
          }

          // Adjust height based on dead lead status
          final dialogHeight =
              _isDeadLeadSelected ? maxHeight * 0.85 : maxHeight * 0.8;

          return Center(
            child: Container(
              width: dialogWidth,
              height: dialogHeight,
              constraints: BoxConstraints(
                maxWidth: 800, // Max width for better appearance
                maxHeight: 900,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // Form Body
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
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
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.all(20),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final columns =
                                            constraints.maxWidth > 400 ? 2 : 1;

                                        return ResponsiveGrid(
                                          columns: columns,
                                          children: [
                                            // Required Fields Section
                                            if (columns == 2)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: 'Call Details',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),

                                            if (columns == 2)
                                              const SizedBox(
                                                  width: 0,
                                                  height: 0), // Spacer

                                            // Call Type
                                            CustomDropdownField(
                                              label: 'Call Type ',
                                              value: _selectedCallType,
                                              items: configController
                                                      .configData.value.callType
                                                      ?.map((e) => e.name ?? "")
                                                      .where((name) =>
                                                          name.isNotEmpty)
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) => setState(() =>
                                                  _selectedCallType = val),
                                              isRequired: true,
                                            ),

                                            // Call Status
                                            CustomDropdownField(
                                              label: 'Call Status ',
                                              value: _selectedCallStatus,
                                              items: configController.configData
                                                      .value.callStatus
                                                      ?.map((e) => e.name ?? "")
                                                      .where((name) =>
                                                          name.isNotEmpty)
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) => setState(() =>
                                                  _selectedCallStatus = val),
                                              isRequired: true,
                                            ),

                                            // Lead Status

                                            CustomDropdownField(
                                              label: 'Lead Status ',
                                              value: _selectedLeadStatus,
                                              items: configController.configData
                                                      .value.clientStatus
                                                      ?.map((e) => e.name ?? "")
                                                      .where((name) =>
                                                          name.isNotEmpty)
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) async {
                                                if (val?.toUpperCase() ==
                                                    'DEAD') {
                                                  if (await _showDeadLeadDialog()) {
                                                    setState(() =>
                                                        _selectedLeadStatus =
                                                            val);
                                                  } else {
                                                    return;
                                                  }
                                                } else {
                                                  setState(() =>
                                                      _selectedLeadStatus =
                                                          val);
                                                }
                                              },
                                              isRequired: true,
                                            ),

                                            // Dead Lead Reason (only shown if DEAD is selected)
                                            if (_isDeadLeadSelected)
                                              CustomTextFormField(
                                                label: 'Dead Lead Reason ',
                                                controller:
                                                    _deadLeadReasonController,
                                                isRequired: _isDeadLeadSelected,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'.')),
                                                ],
                                                validator: (value) {
                                                  if (_isDeadLeadSelected) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter reason for dead lead';
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),

                                            // Next Schedule with Time
                                            CustomDateField(
                                              label: 'Next Schedule',
                                              isTimeRequired: true,
                                              controller:
                                                  _nextScheduleController,
                                              initialDate: DateTime.now()
                                                  .add(const Duration(days: 1)),
                                              focusDate: DateTime.now()
                                                  .add(const Duration(days: 1)),
                                              endDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            ),

                                            // Call Duration
                                            CustomTextFormField(
                                              label: 'Call Duration *',
                                              hintText: 'MM:SS or HH:MM:SS',
                                              controller:
                                                  _callDurationController,
                                              isRequired: true,
                                              inputFormatters: [
                                                DurationInputFormatter(
                                                    allowHours: true),
                                                LengthLimitingTextInputFormatter(
                                                    8),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter call duration';
                                                }
                                                final parsed = CallEventModel
                                                    .parseDuration(value);
                                                if (parsed == null) {
                                                  return 'Invalid duration format (use MM:SS or HH:MM:SS)';
                                                }
                                                return null;
                                              },
                                            ),

                                            // Feedback/Comments (span full width)
                                            CustomTextFormField(
                                              label: 'Feedback/Comments',
                                              controller: _feedbackController,
                                              maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'.')),
                                              ],
                                            ),

                                            // For single column layout
                                            if (columns == 1)
                                              CustomTextFormField(
                                                label: 'Feedback/Comments',
                                                controller: _feedbackController,
                                                maxLines: 4,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'.')),
                                                ],
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              // Buttons
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomActionButton(
                                        text: 'Cancel',
                                        icon: Icons.close_rounded,
                                        textColor: Colors.grey,
                                        borderColor: Colors.grey.shade300,
                                        onPressed: () => Navigator.pop(context),
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
                                        onPressed: _handleSave,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.9),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            widget.isEditMode ? Icons.edit_rounded : Icons.add_call,
            size: 26,
            color: Colors.white,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.isEditMode
                      ? 'Edit Call Record'
                      : 'Add Call Record',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                CustomText(
                  text: widget.clientName,
                  fontSize: 14,
                  color: Colors.white70,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon:
                const Icon(Icons.close_rounded, color: Colors.white, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// Duration input formatter
class DurationInputFormatter extends TextInputFormatter {
  final bool allowHours;

  DurationInputFormatter({this.allowHours = false});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow only digits and colons
    final filtered = newValue.text.replaceAll(RegExp(r'[^0-9:]'), '');

    // Limit to allowed format
    final parts = filtered.split(':');
    if (parts.length > (allowHours ? 3 : 2)) {
      return oldValue;
    }

    // Validate each part
    for (final part in parts) {
      if (part.length > 2) return oldValue;
      if (int.tryParse(part) == null && part.isNotEmpty) return oldValue;
    }

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';

// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// import '../../../../model/lead/call_event_model.dart';

// class CallRecordPopup extends StatefulWidget {
//   const CallRecordPopup({
//     super.key,
//     required this.clientId,
//     required this.clientName,
//   });

//   final String clientId;
//   final String clientName;

//   @override
//   State<CallRecordPopup> createState() => _CallRecordPopupState();
// }

// class _CallRecordPopupState extends State<CallRecordPopup>
//     with TickerProviderStateMixin {
//   final configController = Get.find<ConfigController>();
//   final customerController = Get.find<CustomerProfileController>();
//   final _formKey = GlobalKey<FormState>();

//   String? _selectedCallType;
//   String? _selectedCallStatus;
//   String? _selectedLeadStatus;

//   final TextEditingController _callDurationController = TextEditingController();
//   final TextEditingController _feedbackController = TextEditingController();
//   final TextEditingController _nextScheduleController = TextEditingController();

//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _callDurationController.dispose();
//     _feedbackController.dispose();
//     _nextScheduleController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _handleSave() {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     final scheduleParts = _nextScheduleController.text.trim().split(" ");
//     final scheduleDate = scheduleParts.isNotEmpty ? scheduleParts.first : '';
//     final scheduleTime = scheduleParts.length > 1
//         ? DateFormat("HH:mm")
//             .format(DateTime.tryParse(scheduleParts.last) ?? DateTime.now())
//         : '';

//     final durationText = _callDurationController.text.trim();
//     final durationSeconds = durationText.contains(":")
//         ? ((int.tryParse(durationText.split(":").first) ?? 0) * 60) +
//             (int.tryParse(durationText.split(":").last) ?? 0)
//         : int.tryParse(durationText) ?? 0;

//     final model = CallEventModel(
//       clientId: widget.clientId,
//       nextSchedule: scheduleDate,
//       nextSheduleTime: double.parse(scheduleTime),
//       duration: durationSeconds,
//       comment: _feedbackController.text.trim(),
//       callType: _selectedCallType,
//       callStatus: _selectedCallStatus,
//     );

//     customerController.callRecordInsert(context: context, log: model);

//     // showLoaderDialog(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.9,
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
//               child: Column(
//                 children: [
//                   // Header
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.person_add_alt_1_rounded,
//                             size: 28, color: Colors.white),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               CustomText(
//                                 text: 'Call Followup',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: 'Register followup details',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Form Body
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: Colors.grey.shade200),
//                           ),
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: Scrollbar(
//                                   controller: _scrollController,
//                                   thumbVisibility: true,
//                                   child: SingleChildScrollView(
//                                     controller: _scrollController,
//                                     padding: const EdgeInsets.all(24),
//                                     child: LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         int columns = 1;
//                                         if (constraints.maxWidth > 1000) {
//                                           columns = 3;
//                                         } else if (constraints.maxWidth > 600) {
//                                           columns = 2;
//                                         }

//                                         return ResponsiveGrid(
//                                           columns: columns,
//                                           children: [
//                                             CustomDropdownField(
//                                               label: 'Call Type',
//                                               value: _selectedCallType,
//                                               items: configController
//                                                       .configData.value.callType
//                                                       ?.map((e) => e.name ?? "")
//                                                       .toList() ??
//                                                   [],
//                                               onChanged: (val) => setState(() {
//                                                 _selectedCallType = val;
//                                               }),
//                                               isRequired: true,
//                                             ),
//                                             CustomDropdownField(
//                                               label: 'Call Status',
//                                               value: _selectedCallStatus,
//                                               items: configController.configData
//                                                       .value.callStatus
//                                                       ?.map((e) => e.name ?? "")
//                                                       .toList() ??
//                                                   [],
//                                               onChanged: (val) => setState(() {
//                                                 _selectedCallStatus = val;
//                                               }),
//                                               isRequired: true,
//                                             ),
//                                             CustomDropdownField(
//                                               label: 'Lead Status',
//                                               value: _selectedLeadStatus,
//                                               items: configController.configData
//                                                       .value.clientStatus
//                                                       ?.map((e) => e.name ?? "")
//                                                       .toList() ??
//                                                   [],
//                                               onChanged: (val) => setState(() {
//                                                 _selectedLeadStatus = val;
//                                               }),
//                                               isRequired: true,
//                                             ),
//                                             CustomDateField(
//                                               isTimeRequired: true,
//                                               label: 'Next Schedule',
//                                               initialDate: DateTime.now(),
//                                               controller:
//                                                   _nextScheduleController,
//                                             ),
//                                             CustomTextFormField(
//                                               label: 'Call Duration',
//                                               hintText: 'mm:ss',
//                                               controller:
//                                                   _callDurationController,
//                                               isRequired: true,
//                                               inputFormatters: [
//                                                 DurationInputFormatter(
//                                                     allowHours: true),
//                                                 LengthLimitingTextInputFormatter(
//                                                     8),
//                                               ],
//                                               keyboardType:
//                                                   TextInputType.number,
//                                             ),
//                                             CustomTextFormField(
//                                               label: 'Feedback',
//                                               controller: _feedbackController,
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               // Buttons
//                               Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: CustomActionButton(
//                                         text: 'Cancel',
//                                         icon: Icons.close_rounded,
//                                         textColor: Colors.grey,
//                                         borderColor: Colors.grey.shade300,
//                                         onPressed: () => Navigator.pop(context),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16),
//                                     Expanded(
//                                       flex: 2,
//                                       child: CustomActionButton(
//                                         text: 'Save Feedback',
//                                         icon: Icons.save_rounded,
//                                         isFilled: true,
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color(0xFF7F00FF),
//                                             Color(0xFFE100FF)
//                                           ],
//                                         ),
//                                         onPressed: _handleSave,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
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
// }

// class DurationInputFormatter extends TextInputFormatter {
//   final bool allowHours;

//   DurationInputFormatter({this.allowHours = false});

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final text = newValue.text;
//     final filtered = text.replaceAll(RegExp(r'[^0-9:]'), '');
//     final parts = filtered.split(':');
//     if (parts.length > (allowHours ? 3 : 2)) {
//       return oldValue; // Prevent too many colons
//     }
//     for (final part in parts) {
//       if (part.length > 2) return oldValue;
//     }

//     return TextEditingValue(
//       text: filtered,
//       selection: TextSelection.collapsed(offset: filtered.length),
//     );
//   }
// }
