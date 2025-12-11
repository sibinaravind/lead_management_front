import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../model/lead/call_event_model.dart';

class CallRecordPopup extends StatefulWidget {
  final String clientId;
  final CallEventModel? editData;

  const CallRecordPopup({
    super.key,
    this.editData,
    required this.clientId,
  });

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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool get _isDeadLeadSelected => _selectedLeadStatus?.toUpperCase() == 'DEAD';

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.editData != null) {
      final data = widget.editData!;
      // Set dropdown values
      _selectedCallType = data.callType;
      _selectedCallStatus = data.callStatus;
      _selectedLeadStatus = data.clientStatus;
      _selectedDeadLeadReason = data.deadLeadReason;
      if (data.duration != null) {
        _callDurationController.text = _formatDuration(data.duration!);
      }
      _feedbackController.text = data.comment ?? '';
      if (data.nextSchedule != null) {
        try {
          _selectedDate = DateTime.parse(data.nextSchedule!);

          if (data.nextSheduleTime != null) {
            final timeParts =
                data.nextSheduleTime?.toString().split('.') ?? ["10", '00'];
            if (timeParts.length == 2) {
              final hour = int.tryParse(timeParts[0]) ?? 0;
              final minute = int.tryParse(timeParts[1]) ?? 0;
              _selectedTime = TimeOfDay(hour: hour, minute: minute);
            }
          }
          _updateDateTimeDisplay();
        } catch (e) {
          debugPrint('Error parsing date/time: $e');
        }
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
              child: const Text('Proceed'),
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
              constraints: const BoxConstraints(
                maxWidth: 800,
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: CustomText(
                                                    text: 'Next Schedule',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          {
                                                            final DateTime?
                                                                picked =
                                                                await showDatePicker(
                                                              context: context,
                                                              initialDate: _selectedDate ??
                                                                  DateTime.now().add(
                                                                      const Duration(
                                                                          days:
                                                                              1)),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          365)),
                                                            );

                                                            if (picked !=
                                                                null) {
                                                              setState(() {
                                                                _selectedDate =
                                                                    picked;
                                                                _updateDateTimeDisplay();
                                                              });
                                                            }
                                                          }
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                            vertical: 14,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .blackNeutralColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 18,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Expanded(
                                                                child: Text(
                                                                  _selectedDate !=
                                                                          null
                                                                      ? _formatDate(
                                                                          _selectedDate!)
                                                                      : 'Select Date',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: _selectedDate !=
                                                                            null
                                                                        ? Colors
                                                                            .black87
                                                                        : Colors
                                                                            .grey
                                                                            .shade500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                          final TimeOfDay?
                                                              picked =
                                                              await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                _selectedTime ??
                                                                    TimeOfDay
                                                                        .now(),
                                                          );

                                                          if (picked != null) {
                                                            setState(() {
                                                              _selectedTime =
                                                                  picked;
                                                              _updateDateTimeDisplay();
                                                            });
                                                          }
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 12,
                                                            vertical: 14,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .blackNeutralColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time,
                                                                size: 18,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Expanded(
                                                                child: Text(
                                                                  _selectedTime !=
                                                                          null
                                                                      ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                                                                      : 'Time',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: _selectedTime !=
                                                                            null
                                                                        ? Colors
                                                                            .black87
                                                                        : Colors
                                                                            .grey
                                                                            .shade500,
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
                                              ],
                                            ),

                                            // Call Duration
                                            CustomTextFormField(
                                              label: 'Call Duration',
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
                                        onPressed: () async {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          try {
                                            final scheduleData =
                                                _parseNextSchedule();
                                            if (scheduleData['date'] == null ||
                                                scheduleData['time'] == null) {
                                              CustomToast.showToast(
                                                  context: context,
                                                  message:
                                                      "Please select a valid next schedule date and time.");
                                              return;
                                            }
                                            CallEventModel requestBody =
                                                CallEventModel(
                                              clientId: widget.clientId,
                                              duration: _parseDurationToSeconds(
                                                  _callDurationController.text),
                                              nextSchedule:
                                                  scheduleData['date'],
                                              nextSheduleTime:
                                                  scheduleData['time'] != null
                                                      ? double.parse(
                                                          scheduleData[
                                                                  'time'] ??
                                                              '0')
                                                      : null,
                                              clientStatus: _selectedLeadStatus,
                                              deadLeadReason: _isDeadLeadSelected
                                                  ? _deadLeadReasonController
                                                      .text
                                                  : null,
                                              comment: _feedbackController
                                                      .text.isEmpty
                                                  ? null
                                                  : _feedbackController.text,
                                              callType: _selectedCallType,
                                              callStatus: _selectedCallStatus,
                                            );
                                            if (widget.editData != null) {
                                              // Update existing record
                                              // await customerController.updateCallRecord(
                                              //   recordId: widget.editData!.id!,
                                              //   data: requestBody,
                                              // );
                                            } else {
                                              // Create new record
                                              await customerController
                                                  .callRecordInsert(
                                                      context: context,
                                                      log: requestBody);
                                            }
                                          } catch (e) {}
                                        },
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
            widget.editData != null ? Icons.edit_rounded : Icons.add_call,
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
                  text: widget.editData != null
                      ? 'Edit Call Record'
                      : 'Add Call Record',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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

  void _updateDateTimeDisplay() {
    if (_selectedDate != null) {
      final dateStr = _formatDate(_selectedDate!);
      if (_selectedTime != null) {
        final timeStr =
            '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
        _nextScheduleController.text = '$dateStr $timeStr';
      } else {
        _nextScheduleController.text = dateStr;
      }
    } else {
      _nextScheduleController.text = '';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }

  // Convert MM:SS or HH:MM:SS format to seconds
  int _parseDurationToSeconds(String duration) {
    final parts = duration.split(':');
    if (parts.length == 2) {
      // MM:SS format
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return (minutes * 60) + seconds;
    } else if (parts.length == 3) {
      // HH:MM:SS format
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return (hours * 3600) + (minutes * 60) + seconds;
    }
    return 0;
  }

  // Parse datetime string to separate date and time in 24-hour format
  Map<String, String?> _parseNextSchedule() {
    if (_selectedDate == null) {
      return {'date': null, 'time': null};
    }

    final date = _formatDate(_selectedDate!);
    String? time;

    if (_selectedTime != null) {
      final hour = _selectedTime!.hour.toString().padLeft(2, '0');
      final minute = _selectedTime!.minute.toString().padLeft(2, '0');
      time = '$hour.$minute'; // Format as HH.MM for API
    }

    return {'date': date, 'time': time};
  }

  // Show date picker

  // Show time picker
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
