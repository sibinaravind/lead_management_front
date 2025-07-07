


import 'package:flutter/material.dart';

import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';

void configEditDialog(
    BuildContext context,
    String category, Map<String, dynamic> item
    // Map<String, dynamic> client
    ) {
  // _vacancyController.clear();
  // _commissionController.clear();
  TextEditingController nameController =
  TextEditingController(text: item['name']);
  TextEditingController codeController =
  TextEditingController(text: item['code'] ?? '');
  TextEditingController countryController =
  TextEditingController(text: item['country'] ?? '');
  TextEditingController provinceController =
  TextEditingController(text: item['province'] ?? '');
  TextEditingController rangeController =
  TextEditingController(text: item['range'] ?? '');

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Form(
          // key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with client info
              Row(
                children: [
                  CustomText(
                    text: "Edit ${category}",
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontSize: 18,
                  ),
                  const SizedBox(width: 16),

                ],
              ),
              const SizedBox(height: 24),

              // Form fields
              CustomTextFormField(
                controller: nameController,
                label: 'Name',
                isRequired: true,
                keyboardType: TextInputType.number,
              ),
              if (item.containsKey('code')) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: codeController,
                  label: 'Code',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),
              ],
              if (item.containsKey('country')) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: countryController,
                  label: 'Country',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),
              ],
              if (item.containsKey('province')) ...[
                SizedBox(height: 16),

              CustomTextFormField(
                  controller: provinceController,
                  label: 'Province',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),

              ],
              if (item.containsKey('range')) ...[
                SizedBox(height: 16),
                 CustomTextFormField(
                  controller: rangeController,
                  label: 'Range',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),

              ],
              SizedBox(height: 16),

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
                      text: 'Edit $category',
                      icon: Icons.check,
                      onPressed: () {
                      ///-- setstate
                          item['name'] = nameController.text;
                          if (item.containsKey('code'))
                            item['code'] = codeController.text;
                          if (item.containsKey('country'))
                            item['country'] = countryController.text;
                          if (item.containsKey('province'))
                            item['province'] = provinceController.text;
                          if (item.containsKey('range'))
                            item['range'] = rangeController.text;

                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['name']} updated successfully'),
                            backgroundColor: AppColors.greenSecondaryColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
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
    ),
  );
}
