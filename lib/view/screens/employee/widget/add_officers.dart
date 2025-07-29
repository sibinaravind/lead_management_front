import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/lead/round_robin_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_action_button.dart';
import 'package:overseas_front_end/view/widgets/custom_multi_selection_dropdown_field.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';

import '../../../widgets/custom_multi_officer_select_dropdown_field.dart';

class AddOfficerDialog extends StatefulWidget {
  final String roundRobinId;

  const AddOfficerDialog({super.key, required this.roundRobinId});

  @override
  State<AddOfficerDialog> createState() => _AddOfficerDialogState();
}

class _AddOfficerDialogState extends State<AddOfficerDialog> {
  final OfficersController officersController = Get.put(OfficersController());
  final RoundRobinController roundRobinController = Get.find();

  final List<String> _employeeController = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    officersController.fetchOfficersList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with officers list
              Row(
                children: [
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(() {
                      if (officersController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final items = officersController.officersList
                          .map((e) => "${e.name},${e.id}")
                          .toList();
                      // return CustomMultiSelectDropdownField(
                      //   isRequired: true,
                      //   label: 'Select Officers',
                      //   selectedItems: _employeeController,
                      //   items: items,
                      //   onChanged: (selectedIds) {
                      //     setState(() {
                      //       _employeeController.clear();
                      //       _employeeController.addAll(selectedIds);
                      //     });
                      //   },
                      // );
                      return CustomMultiOfficerSelectDropdownField(
                        isRequired: true,
                        label: 'Select Officers',
                        selectedItems: _employeeController,
                        items: officersController.officersList,
                        onChanged: (selectedIds) {
                          setState(() {
                            _employeeController.clear();
                            _employeeController.addAll(selectedIds);
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Action buttons
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
                      text: 'ADD',
                      icon: Icons.check,
                      onPressed: () async {
                        if ((_formKey.currentState?.validate() ?? false) &&
                            _employeeController.isNotEmpty) {
                          final result = await roundRobinController
                              .addOfficersToRoundRobin(
                            roundRobinId: widget.roundRobinId,
                            officerIds: _employeeController,
                          );

                          if (result) {
                            CustomToast.showToast(
                              context: context,
                              message: 'Officers added successfully!',
                            );
                            Navigator.pop(context);
                          } else {
                            CustomToast.showToast(
                              context: context,
                              message: roundRobinController.error.value ??
                                  'Failed to add officers',
                            );
                          }
                        }
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
    );
  }
}
