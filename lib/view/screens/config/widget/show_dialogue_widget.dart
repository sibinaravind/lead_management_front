import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:overseas_front_end/controller/config/config_provider.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';

void configEditDialog(BuildContext context, String category, ConfigModel item
    // Map<String, dynamic> client
    ) {
  // _vacancyController.clear();
  // _commissionController.clear();
  TextEditingController nameController = TextEditingController(text: item.name);
  TextEditingController colourController =
      TextEditingController(text: item.colour ?? "");

  TextEditingController codeController =
      TextEditingController(text: item.code ?? '');
  TextEditingController countryController =
      TextEditingController(text: item.country ?? '');
  TextEditingController provinceController =
      TextEditingController(text: item.province ?? '');
  // TextEditingController rangeController =
  //     TextEditingController(text: item['range'] ?? '');
  final formKey = GlobalKey<FormState>();

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
          key: formKey,
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
              if (item.colour != null) ...[
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: colourController,
                  label: 'Colour',
                  isRequired: true,
                  readOnly: true,
                  // keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                if (item.colour != null)
                  FittedBox(
                    fit: BoxFit.contain,
                    child: ColorPicker(
                        pickerColor: Color(0xffffffff),
                        onColorChanged: (color) {
                          colourController.text = "0X" + color.toHexString();
                        }),
                  )
              ],
              // if (item.hasField('range')) ...[
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
                      text: 'Confirm',
                      icon: Icons.check,
                      onPressed: () {
                        ///-- setstate
                        item.name = nameController.text;
                        if (item.hasField('code')) {
                          item.code = (codeController.text);
                        }
                        if (item.hasField('country')) {
                          item.country = countryController.text;
                        }
                        if (item.hasField('province')) {
                          item.province = provinceController.text;
                        }
                        if (formKey.currentState?.validate() ?? false) {
                          // if (item.containsKey('range')) {
                          //   item['range'] = rangeController.text;
                          // }
                          Provider.of<ConfigProvider>(context, listen: false)
                              .updateConfig(context,
                                  colour: colourController.text.trim(),
                                  field: category,
                                  name: item.name ?? "",
                                  id: item.id ?? "",
                                  status: "ACTIVE");
                          Navigator.of(context).pop();
                          CustomSnackBar.show(
                              context, '${item.name} updated successfully');
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
    ),
  );
}
