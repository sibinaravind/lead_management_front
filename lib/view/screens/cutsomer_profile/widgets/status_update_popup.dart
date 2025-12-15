import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../model/lead/call_event_model.dart';

class StatusUpdatePopup extends StatefulWidget {
  final String clientId;
  final CallEventModel? editData;

  const StatusUpdatePopup({
    super.key,
    this.editData,
    required this.clientId,
  });

  @override
  State<StatusUpdatePopup> createState() => _StatusUpdatePopupState();
}

class _StatusUpdatePopupState extends State<StatusUpdatePopup> {
  final configController = Get.find<ConfigController>();
  final customerController = Get.find<CustomerProfileController>();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  // Dropdown values
  String? _selectedLeadStatus;
  String? _selectedDeadLeadReason;
  final TextEditingController _deadLeadReasonController =
      TextEditingController();
  bool get _isDeadLeadSelected => _selectedLeadStatus?.toUpperCase() == 'DEAD';

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.editData != null) {
      final data = widget.editData!;
      _selectedLeadStatus = data.clientStatus;
      _selectedDeadLeadReason = data.deadLeadReason;
      _deadLeadReasonController.text = data.deadLeadReason ?? '';
    }
  }

  @override
  void dispose() {
    _deadLeadReasonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _showDeadLeadDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
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
            dialogWidth = maxWidth * 0.4;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.5;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.65;
          }

          // Adjust height based on dead lead status
          final dialogHeight =
              _isDeadLeadSelected ? maxHeight * 0.60 : maxHeight * 0.45;

          return Center(
            child: Container(
              width: dialogWidth,
              height: dialogHeight,
              constraints: const BoxConstraints(
                maxWidth: 600,
                maxHeight: 500,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Lead Status
                                        CustomDropdownField(
                                          label: 'Lead Status ',
                                          value: _selectedLeadStatus,
                                          items: configController
                                                  .configData.value.clientStatus
                                                  ?.map((e) => e.name ?? "")
                                                  .where(
                                                      (name) => name.isNotEmpty)
                                                  .toList() ??
                                              [],
                                          onChanged: (val) async {
                                            if (val?.toUpperCase() == 'DEAD') {
                                              if (await _showDeadLeadDialog()) {
                                                setState(() =>
                                                    _selectedLeadStatus = val);
                                              } else {
                                                return;
                                              }
                                            } else {
                                              setState(() =>
                                                  _selectedLeadStatus = val);
                                            }
                                          },
                                          isRequired: true,
                                        ),

                                        const SizedBox(height: 16),

                                        // Dead Lead Reason (only shown if DEAD is selected)
                                        if (_isDeadLeadSelected)
                                          CustomTextFormField(
                                            label: 'Dead Lead Reason ',
                                            controller:
                                                _deadLeadReasonController,
                                            isRequired: _isDeadLeadSelected,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 3,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'.')),
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
                                      ],
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
                                        text: 'Update Status',
                                        icon: Icons.update_rounded,
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

                                          if (widget.editData != null) {
                                            // Update existing record
                                            // await customerController.updateCallRecord(
                                            //   recordId: widget.editData!.id!,
                                            //   data: requestBody,
                                            // );
                                          } else {
                                            // Create new status update record
                                            await customerController
                                                .updateLeadStatusRecord(
                                              context: context,
                                              body: {
                                                'client_status':
                                                    _selectedLeadStatus,
                                                'dead_lead_reason':
                                                    _isDeadLeadSelected
                                                        ? _deadLeadReasonController
                                                            .text
                                                        : null,
                                              },
                                              recordId: widget.clientId,
                                            );
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
            Icons.update_rounded,
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
                  text: 'Update Lead Status',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                CustomText(
                  text: 'Client ID: ${widget.clientId}',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
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
