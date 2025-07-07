//
// import 'package:flutter/material.dart';
//
// import '../../res/style/colors/colors.dart';
//
// void _showEditDialog(String category, Map<String, dynamic> item,BuildContext context) {
//   TextEditingController nameController =
//   TextEditingController(text: item['name']);
//   TextEditingController codeController =
//   TextEditingController(text: item['code'] ?? '');
//   TextEditingController countryController =
//   TextEditingController(text: item['country'] ?? '');
//   TextEditingController provinceController =
//   TextEditingController(text: item['province'] ?? '');
//   TextEditingController rangeController =
//   TextEditingController(text: item['range'] ?? '');
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: AppColors.whiteMainColor,
//         title: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: AppColors.buttonGraidentColour,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.edit_rounded, color: AppColors.whiteMainColor),
//               SizedBox(width: 12),
//               Text(
//                 'Edit ${category.substring(0, category.length - 1)}',
//                 style: TextStyle(
//                   color: AppColors.whiteMainColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         content: Container(
//           decoration: BoxDecoration(
//             gradient: AppColors.backgroundGraident,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildStyledTextField(
//                       nameController, 'Name', Icons.badge_rounded),
//                   if (item.containsKey('code')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(
//                         codeController, 'Code', Icons.code_rounded),
//                   ],
//                   if (item.containsKey('country')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(
//                         countryController, 'Country', Icons.flag_rounded),
//                   ],
//                   if (item.containsKey('province')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(provinceController, 'Province',
//                         Icons.location_on_rounded),
//                   ],
//                   if (item.containsKey('range')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(rangeController, 'Salary Range',
//                         Icons.attach_money_rounded),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: AppColors.textGrayColour,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: AppColors.buttonGraidentColour,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   item['name'] = nameController.text;
//                   if (item.containsKey('code'))
//                     item['code'] = codeController.text;
//                   if (item.containsKey('country'))
//                     item['country'] = countryController.text;
//                   if (item.containsKey('province'))
//                     item['province'] = provinceController.text;
//                   if (item.containsKey('range'))
//                     item['range'] = rangeController.text;
//                 });
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('${item['name']} updated successfully'),
//                     backgroundColor: AppColors.greenSecondaryColor,
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   color: AppColors.whiteMainColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
