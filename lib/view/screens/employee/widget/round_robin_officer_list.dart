// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/shared/enums.dart';
// import 'package:overseas_front_end/model/app_configs/config_model.dart';
// import 'package:overseas_front_end/view/screens/config/widget/delete_dialogue.dart';
// import 'package:overseas_front_end/view/screens/employee/widget/officers_delete_dialogue.dart';
// import 'package:provider/provider.dart';

// import '../../../../model/lead/round_robin.dart';
// import '../../../../res/style/colors/colors.dart';
// import '../../config/widget/action_button.dart';


// class RoundRobinOfficerList extends StatelessWidget {
//   const RoundRobinOfficerList({super.key,
//     required this.item,
//     // required this.category,
//     required this.roundrobinId
//   });

//   // final String category;
//   final RoundRobinOfficerModel item;
//    final  String roundrobinId;
//   @override
//   Widget build(BuildContext context) {
//     // bool isActive = item.status == Status.ACTIVE;
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//       decoration: BoxDecoration(
//         gradient:
//             LinearGradient(
//           colors: [
//             AppColors.greenSecondaryColor.withOpacity(0.1),
//             AppColors.greenSecondaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,

//           //   : LinearGradient(
//           // colors: [
//           //   AppColors.redSecondaryColor.withOpacity(0.1),
//           //   AppColors.redSecondaryColor.withOpacity(0.05),
//           // ],
//           // begin: Alignment.centerLeft,
//           // end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color:  AppColors.greenSecondaryColor.withOpacity(0.3)
//               // : AppColors.redSecondaryColor.withOpacity(0.3),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.greenSecondaryColor.withOpacity(0.1),
//                 // : AppColors.redSecondaryColor.withOpacity(0.1),
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
//                  AppColors.greenGradient ,
//                 boxShadow: [
//                   BoxShadow(
//                     color:
//                          AppColors.redSecondaryColor.withOpacity(0.4),
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.check,
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
//                     item.name??'',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),

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
//                           item.phone??'',
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
//                 // ActionButton(
//                 //   icon: isActive ? Icons.toggle_on : Icons.toggle_off,
//                 //   gradient: isActive
//                 //       ? AppColors.greenGradient
//                 //       : AppColors.redGradient,
//                 //   onTap: () {
//                 //     Provider.of<ConfigProvider>(context, listen: false)
//                 //         .toggleStatus(category, item);
//                 //   },
//                 //   tooltip: isActive ? 'Deactivate' : 'Activate',
//                 // ),
//                 // SizedBox(width: 8),
//                 // if (category != "designation")
//                 //   ActionButton(
//                 //     icon: Icons.edit_rounded,
//                 //     gradient: AppColors.buttonGraidentColour,
//                 //     onTap: () => (){},
//                 //     // onTap: () => configEditDialog(context, category, item),
//                 //     tooltip: 'Edit',
//                 //   ),
//                 SizedBox(width: 8),

//                   ActionButton(
//                     icon: Icons.delete_rounded,
//                     gradient: AppColors.redGradient,
//                     onTap: () => showDialog(
//                       context: context,
//                       builder: (context) {
//                         List<String> officers=[];
//                         officers.add(item.id??'');
//                       return  OfficersDeleteDialogue(officerIds: officers,item: item.name??'', roundrobinId:roundrobinId??'');

//                       }
//                     ),
//                     tooltip: 'Delete',
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }




// }
