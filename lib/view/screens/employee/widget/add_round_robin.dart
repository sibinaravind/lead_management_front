import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../../controller/lead/round_robin_provider.dart';
import '../../../../controller/officers_controller/officers_controller.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_multi_selection_dropdown_field.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';

class AddRoundRobinDialog extends StatefulWidget {
  const AddRoundRobinDialog({super.key});

  @override
  State<AddRoundRobinDialog> createState() => _AddRoundRobinDialogState();
}

class _AddRoundRobinDialogState extends State<AddRoundRobinDialog> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCountry = 'GCC';
  List<String> _selectedOfficerIds = [];

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(text: 'Add Round Robin', fontWeight: FontWeight.bold, fontSize: 18),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _nameController,
              label: 'Round Robin Name',
              isRequired: true,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
              value: _selectedCountry,

              /// static ------------------------------
              items: ['GCC', 'INDIA', 'EUROPE']
                  .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCountry = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            Consumer<OfficersControllerProvider>(
              builder: (context, officers, child) {
                return CustomMultiSelectDropdownField(
                  label: 'Add Officers',
                  selectedItems: _selectedOfficerIds,
                  items: officers.officersListModel!
                      .map((e) => "${e.name},${e.id}")
                      .toList(),
                  onChanged: (selectedIds) {
                    setState(() {
                      _selectedOfficerIds = selectedIds;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 16),
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
                  child: Consumer<RoundRobinProvider>(
                    builder: (context, provider, child) {
                      return CustomActionButton(
                        text: 'ADD',
                        icon: Icons.check,
                        onPressed: () async {
                          final name = _nameController.text.trim();
                          if (name.isEmpty) {
                            SnackBar(content: Text( 'Please enter round robin name'));

                            return;
                          }
                          bool result = await provider.createRoundRobin(
                            name: name,
                            country: _selectedCountry,
                            officerIds: _selectedOfficerIds,
                          );
                          if (result) {
                            SnackBar(content: Text( 'Round Robin Created Successfully'));

                            if (context.mounted) Navigator.pop(context);
                          } else {
                            SnackBar(content: Text( 'Failed to create'));

                          }
                        },
                        isFilled: true,
                        gradient: AppColors.orangeGradient,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
