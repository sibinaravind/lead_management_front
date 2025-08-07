import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';

import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import '../../../../model/lead/call_event_model.dart';

class CallRecordPopup extends StatefulWidget {
  const CallRecordPopup({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  final String clientId;
  final String clientName;

  @override
  State<CallRecordPopup> createState() => _CallRecordPopupState();
}

class _CallRecordPopupState extends State<CallRecordPopup>
    with TickerProviderStateMixin {
  final configController = Get.find<ConfigController>();
  final customerController = Get.find<CustomerProfileController>();
  final _formKey = GlobalKey<FormState>();

  String? _selectedCallType;
  String? _selectedCallStatus;
  String? _selectedLeadStatus;

  final TextEditingController _callDurationController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _nextScheduleController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _callDurationController.dispose();
    _feedbackController.dispose();
    _nextScheduleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final scheduleParts = _nextScheduleController.text.trim().split(" ");
    final scheduleDate = scheduleParts.isNotEmpty ? scheduleParts.first : '';
    final scheduleTime = scheduleParts.length > 1
        ? DateFormat("HH:mm")
            .format(DateTime.tryParse(scheduleParts.last) ?? DateTime.now())
        : '';

    final durationText = _callDurationController.text.trim();
    final durationSeconds = durationText.contains(":")
        ? ((int.tryParse(durationText.split(":").first) ?? 0) * 60) +
            (int.tryParse(durationText.split(":").last) ?? 0)
        : int.tryParse(durationText) ?? 0;

    final model = CallEventModel(
      clientId: widget.clientId,
      nextSchedule: scheduleDate,
      nextScheduleTime: scheduleTime,
      duration: durationSeconds,
      comment: _feedbackController.text.trim(),
      callType: _selectedCallType,
      callStatus: _selectedCallStatus,
      clientStatus: _selectedLeadStatus,
    );

    customerController.callRecordInsert(context: context, log: model);

    // showLoaderDialog(context);
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
          } else {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.9,
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
                          AppColors.primaryColor.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person_add_alt_1_rounded,
                            size: 28, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // Form Body
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
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.all(24),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        int columns = 1;
                                        if (constraints.maxWidth > 1000) {
                                          columns = 3;
                                        } else if (constraints.maxWidth > 600) {
                                          columns = 2;
                                        }

                                        return ResponsiveGrid(
                                          columns: columns,
                                          children: [
                                            CustomDropdownField(
                                              label: 'Call Type',
                                              value: _selectedCallType,
                                              items: configController
                                                      .configData.value.callType
                                                      ?.map((e) => e.name ?? "")
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) => setState(() {
                                                _selectedCallType = val;
                                              }),
                                              isRequired: true,
                                            ),
                                            CustomDropdownField(
                                              label: 'Call Status',
                                              value: _selectedCallStatus,
                                              items: configController.configData
                                                      .value.callStatus
                                                      ?.map((e) => e.name ?? "")
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) => setState(() {
                                                _selectedCallStatus = val;
                                              }),
                                              isRequired: true,
                                            ),
                                            CustomDropdownField(
                                              label: 'Lead Status',
                                              value: _selectedLeadStatus,
                                              items: configController.configData
                                                      .value.clientStatus
                                                      ?.map((e) => e.name ?? "")
                                                      .toList() ??
                                                  [],
                                              onChanged: (val) => setState(() {
                                                _selectedLeadStatus = val;
                                              }),
                                              isRequired: true,
                                            ),
                                            CustomDateField(
                                              isTimeRequired: true,
                                              label: 'Next Schedule',
                                              initialDate: DateTime.now(),
                                              controller:
                                                  _nextScheduleController,
                                            ),
                                            CustomTextFormField(
                                              label: 'Call Duration',
                                              hintText: 'mm:ss',
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
                                            ),
                                            CustomTextFormField(
                                              label: 'Feedback',
                                              controller: _feedbackController,
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
}

class DurationInputFormatter extends TextInputFormatter {
  final bool allowHours;

  DurationInputFormatter({this.allowHours = false});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final filtered = text.replaceAll(RegExp(r'[^0-9:]'), '');
    final parts = filtered.split(':');
    if (parts.length > (allowHours ? 3 : 2)) {
      return oldValue; // Prevent too many colons
    }
    for (final part in parts) {
      if (part.length > 2) return oldValue;
    }

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
