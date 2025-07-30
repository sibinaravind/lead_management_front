// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/custom_text.dart';

// class CustomGenderWidget extends StatelessWidget {
//   final String? selectedGender;
//   final ValueChanged<String?>? onGenderChanged;
//   const CustomGenderWidget(
//       {super.key, this.selectedGender, this.onGenderChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.person_outline_rounded,
//                   size: 18, color: AppColors.violetPrimaryColor),
//               SizedBox(width: 8),
//               CustomText(
//                 text: 'Gender',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//                 color: AppColors.primaryColor,
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth < 500) {
//                 return Column(
//                   children: ['Male', 'Female', 'Other']
//                       .map((gender) => RadioListTile<String>(
//                             title: CustomText(text: gender, fontSize: 15),
//                             value: gender,
//                             groupValue: selectedGender,
//                             onChanged: onGenderChanged,
//                             contentPadding: EdgeInsets.zero,
//                             activeColor: AppColors.violetPrimaryColor,
//                           ))
//                       .toList(),
//                 );
//               } else {
//                 return Row(
//                   children: ['Male', 'Female', 'Other']
//                       .map((gender) => Expanded(
//                             child: RadioListTile<String>(
//                               title: CustomText(text: gender, fontSize: 15),
//                               value: gender,
//                               groupValue: selectedGender,
//                               onChanged: onGenderChanged,
//                               contentPadding: EdgeInsets.zero,
//                               activeColor: AppColors.violetPrimaryColor,
//                             ),
//                           ))
//                       .toList(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomGenderWidget extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?>? onGenderChanged;
  final bool isRequired;

  const CustomGenderWidget({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: state.hasError ? Colors.red : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline_rounded,
                          size: 18, color: AppColors.violetPrimaryColor),
                      SizedBox(width: 8),
                      CustomText(
                        text: 'Gender',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final genderOptions = ['MALE', 'FEMALE', 'OTHER'];
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
                          activeColor: AppColors.violetPrimaryColor,
                        );
                      }).toList();

                      return constraints.maxWidth < 500
                          ? Column(children: tiles)
                          : Row(
                              children: tiles
                                  .map((e) => Expanded(child: e))
                                  .toList());
                    },
                  ),
                ],
              ),
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
