// import 'package:flutter/material.dart';
//
// import '../../res/style/colors/colors.dart';
// import 'build_actionbutton_widget.dart';
//
// class PermissionItemWidget extends StatelessWidget {
//   final String category;
//   final Map<String, dynamic> item;
//
//    PermissionItemWidget({super.key, required this.category, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     final  bool isActive = item['status'] == 'active';
//
//     return    Container(
//       margin:const  EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//       decoration: BoxDecoration(
//         gradient: isActive
//             ? LinearGradient(
//           colors: [
//             AppColors.greenSecondaryColor.withOpacity(0.1),
//             AppColors.greenSecondaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         )
//             : LinearGradient(
//           colors: [
//             AppColors.redSecondaryColor.withOpacity(0.1),
//             AppColors.redSecondaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isActive
//               ? AppColors.greenSecondaryColor.withOpacity(0.3)
//               : AppColors.redSecondaryColor.withOpacity(0.3),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: isActive
//                 ? AppColors.greenSecondaryColor.withOpacity(0.1)
//                 : AppColors.redSecondaryColor.withOpacity(0.1),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient:
//                 isActive ? AppColors.greenGradient : AppColors.redGradient,
//                 boxShadow: [
//                   BoxShadow(
//                     color: isActive
//                         ? AppColors.greenSecondaryColor.withOpacity(0.4)
//                         : AppColors.redSecondaryColor.withOpacity(0.4),
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 isActive ? Icons.check : Icons.close,
//                 color: AppColors.whiteMainColor,
//                 size: 12,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item['name'],
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                   if (item.containsKey('code') ||
//                       item.containsKey('country') ||
//                       item.containsKey('range'))
//                     Padding(
//                       padding: EdgeInsets.only(top: 6),
//                       child: Container(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: AppColors.blueNeutralColor.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           _buildSubtitle(item),
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: AppColors.textGrayColour,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 BuildActionButtonWidget(
//                   icon: isActive ? Icons.toggle_on : Icons.toggle_off,
//                   gradient: isActive
//                       ? AppColors.greenGradient
//                       : AppColors.redGradient,
//                   onTap: () => _toggleStatus(category, item),
//                   tooltip: isActive ? 'Deactivate' : 'Activate',
//                 ),
//                 SizedBox(width: 8),
//                 BuildActionButtonWidget(
//                   icon: Icons.edit_rounded,
//                   gradient: AppColors.buttonGraidentColour,
//                   onTap: () => _showEditDialog(category, item),
//                   tooltip: 'Edit',
//                 ),
//                 SizedBox(width: 8),
//                 BuildActionButtonWidget(
//                   icon: Icons.delete_rounded,
//                   gradient: AppColors.redGradient,
//                   onTap: () => _showDeleteDialog(category, item),
//                   tooltip: 'Delete',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//   String _buildSubtitle(Map<String, dynamic> item) {
//     List<String> parts = [];
//     if (item.containsKey('code')) parts.add('Code: ${item['code']}');
//     if (item.containsKey('country')) parts.add('Country: ${item['country']}');
//     if (item.containsKey('province')) {
//       parts.add('Province: ${item['province']}');
//     }
//     if (item.containsKey('range')) parts.add('Range: ${item['range']}');
//     return parts.join(' • ');
//   }
//
//   void _toggleStatus(String category, Map<String, dynamic> item) {
//     setState(() {
//       item['status'] = item['status'] == 'active' ? 'inactive' : 'active';
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Container(
//           padding: EdgeInsets.symmetric(vertical: 4),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteMainColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   item['status'] == 'active'
//                       ? Icons.check_circle
//                       : Icons.cancel,
//                   color: AppColors.whiteMainColor,
//                   size: 20,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   '${item['name']} ${item['status'] == 'active' ? 'activated' : 'deactivated'}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: item['status'] == 'active'
//             ? AppColors.greenSecondaryColor
//             : AppColors.redSecondaryColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         margin: EdgeInsets.all(16),
//       ),
//     );
//   }
//
// }
//
