import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';
import 'package:provider/provider.dart';

import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';

class AddItemDialog extends StatelessWidget {
  AddItemDialog({super.key, required this.category, required this.item});
  final String category;
  final ConfigModel item;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController rangeController = TextEditingController();

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
          // key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with client info
              Row(
                children: [
                  CustomText(
                    text: "Add ${category.replaceAll('_', ' ').toUpperCase()}",
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
                // keyboardType: TextInputType.number,
              ),
              if (item.code != null) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: codeController,
                  label: 'Code',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),
              ],
              if (item.country != null) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: countryController,
                  label: 'Country',
                  isRequired: true,
                  // keyboardType: TextInputType.number,
                ),
              ],
              if (item.province != null) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: provinceController,
                  label: 'Province',
                  isRequired: true,
                  // keyboardType: TextInputType.number,
                ),
              ],
              // if (item.hasFieldName('range')) ...[
              //   SizedBox(height: 16),
              //   CustomTextFormField(
              //     controller: rangeController,
              //     label: 'Range',
              //     isRequired: true,
              //     // keyboardType: TextInputType.number,
              //   ),
              // ],
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
                      text: 'ADD',
                      icon: Icons.check,
                      onPressed: () {
                        ///-- setstate
                        item.name = nameController.text;
                        if (item.hasField('code')) {
                          item.code = codeController.text;
                        }
                        if (item.hasField('country')) {
                          item.country = countryController.text;
                        }
                        if (item.hasField('province')) {
                          item.province = provinceController.text;
                        }
                        // if (item.hasField('range')) {
                        //   item['range'] = rangeController.text;
                        // }
                        Provider.of<ConfigProvider>(context, listen: false)
                            .addConfig(
                                field: category,
                                name: nameController.text.trim());
                        Navigator.of(context).pop();
                        CustomSnackBar.show(
                            context, '${item.name} updated successfully');
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
