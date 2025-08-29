import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/round_robin_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/model/models.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

class AddRoundRobinDialog extends StatefulWidget {
  const AddRoundRobinDialog({super.key, this.roundRobinId});
  final String? roundRobinId;

  @override
  State<AddRoundRobinDialog> createState() => _AddRoundRobinDialogState();
}

class _AddRoundRobinDialogState extends State<AddRoundRobinDialog> {
  final _formKey = GlobalKey<FormState>();

  String _nameController = '';
  String _selectedCountry = 'GCC';
  List<OfficerModel> _selectedOfficerIds = [];

  final configController = Get.find<ConfigController>();
  final officersController = Get.find<OfficersController>();
  final roundRobinController = Get.find<RoundRobinController>();

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
              const CustomText(
                text: 'Add Round Robin',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              const SizedBox(height: 16),

              /// Round Robin Name Dropdown
              Obx(() {
                final serviceTypes =
                    configController.configData.value.serviceType ?? [];

                return CustomDropdownField(
                  isRequired: true,
                  label: "Round Robin Name",
                  value: _nameController,
                  items: serviceTypes.map((e) => e.name ?? '').toList(),
                  onChanged: (value) {
                    setState(() {
                      _nameController = value ?? '';
                    });
                  },
                );
              }),
              const SizedBox(height: 16),

              /// Country Dropdown
              Obx(() {
                final countries =
                    configController.configData.value.country ?? [];
                return CustomDropdownField(
                  isRequired: true,
                  label: "Country",
                  value: _selectedCountry,
                  items: countries.map((e) => e.name ?? '').toList(),
                  onChanged: (value) {
                    _selectedCountry = value ?? '';
                  },
                );
              }),
              const SizedBox(height: 16),

              /// Officer Multi Select
              CustomMultiOfficerSelectDropdownField(
                isRequired: true,
                label: 'Add Officers',
                selectedItems: _selectedOfficerIds,
                items: officersController.filteredOfficersList,
                onChanged: (selectedIds) {
                  setState(() {
                    _selectedOfficerIds = selectedIds;
                  });
                },
              ),
              const SizedBox(height: 16),

              /// Action Buttons
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
                    child: Obx(() {
                      return CustomActionButton(
                        text: 'ADD',
                        icon: Icons.check,
                        isFilled: true,
                        gradient: AppColors.orangeGradient,
                        onPressed: roundRobinController.isLoading.value
                            ? () {}
                            : () async {
                                if ((_formKey.currentState?.validate() ??
                                        false) &&
                                    _selectedOfficerIds.isNotEmpty) {
                                  final name = _nameController.trim();
                                  showLoaderDialog(context);
                                  bool result = await roundRobinController
                                      .createRoundRobin(
                                    name: name,
                                    country: _selectedCountry,
                                    officers: _selectedOfficerIds,
                                  );

                                  Navigator.pop(context);

                                  if (result) {
                                    CustomSnackBar.showMessage("Success",
                                        "Round Robin Created Successfully",
                                        backgroundColor: Colors.green);
                                    Navigator.pop(context);
                                  } else {
                                    CustomSnackBar.showMessage(
                                        "error",
                                        roundRobinController.error.value ??
                                            'Failed to create',
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                      );
                    }),
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
