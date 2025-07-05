import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomGenderRowFormatWidget extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?>? onGenderChanged;
  final bool isRequired;

  const CustomGenderRowFormatWidget({
    super.key,
    this.selectedGender,
    this.onGenderChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedGender,
      validator: isRequired
          ? (value) =>
              (value == null || value.isEmpty) ? 'Please select a gender' : null
          : null,
      builder: (FormFieldState<String> state) {
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Gender',
                        style: TextStyle(color: Colors.black87),
                      ),
                      if (isRequired)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Row(
                      //   children: [
                      //     Icon(Icons.person_outline_rounded,
                      //         size: 18, color: AppColors.violetPrimaryColor),
                      //     SizedBox(width: 8),
                      //     CustomText(
                      //       text: 'Gender',
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 16,
                      //       color: AppColors.primaryColor,
                      //     ),
                      //   ],
                      // ),

                      // const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final genderOptions = ['Male', 'Female', 'Other'];
                          final tiles = genderOptions.map((gender) {
                            return RadioListTile<String>(
                              title: CustomText(text: gender, fontSize: 15),
                              value: gender,
                              groupValue: state.value,
                              onChanged: (val) {
                                state.didChange(val);
                                if (onGenderChanged != null) {
                                  onGenderChanged!(val);
                                }
                              },
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColors.greenSecondaryColor,
                            );
                          }).toList();

                          return constraints.maxWidth < 400
                              ? Row(
                                  children: tiles
                                      .map((e) => Expanded(child: e))
                                      .toList())
                              // Column(children: tiles)
                              : Row(
                                  children: tiles
                                      .map((e) => Expanded(child: e))
                                      .toList());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
