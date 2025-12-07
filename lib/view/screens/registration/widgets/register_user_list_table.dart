// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/lead/lead_model.dart';

// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_text.dart';
// import '../../leads/flavour/customer_lead_flavour.dart';
// import '../../leads/widgets/call_record_popup.dart';
// import '../../cutsomer_profile/customer_profile.dart';
// import '../registeration_add.dart';

// class RegisterUserListTable extends StatelessWidget {
//   final List<LeadModel> userlist;
//   const RegisterUserListTable({super.key, required this.userlist});

//   @override
//   Widget build(BuildContext context) {
//     final horizontalController = ScrollController();
//     final verticalController = ScrollController();
//     final columnsData = CustomerLeadFlavour.userTableList();

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scrollbar(
//           thumbVisibility: true,
//           controller: horizontalController, // ✅ attach controller
//           child: SingleChildScrollView(
//             controller: horizontalController, // ✅ attach controller
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minWidth: constraints.maxWidth),
//               child: Scrollbar(
//                 thumbVisibility: true,
//                 controller: verticalController, // ✅ attach controller
//                 child: SingleChildScrollView(
//                   controller: verticalController, // ✅ attach controller
//                   scrollDirection: Axis.vertical,
//                   child: DataTable(
//                     headingRowColor: WidgetStateColor.resolveWith(
//                         (states) => AppColors.primaryColor),
//                     columnSpacing: 16.0,
//                     columns: columnsData.map((column) {
//                       return DataColumn(
//                         label: CustomText(
//                           text: column['name'],
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textWhiteColour,
//                           fontSize: 14,
//                         ),
//                       );
//                     }).toList(),
//                     rows: userlist.map((listUser) {
//                       return DataRow(
//                         color: WidgetStateProperty.resolveWith<Color?>(
//                             (_) => Colors.white),
//                         cells: columnsData.map((column) {
//                           final extractor = column['extractor'] as Function;
//                           final value = (column['name'] == 'Offer' ||
//                                   column['name'] == 'Offer Amount' ||
//                                   column['name'] == 'Eligibility Date')
//                               ? extractor(listUser, null)
//                               : extractor(listUser);

//                           return DataCell(
//                             ConstrainedBox(
//                               constraints: const BoxConstraints(maxWidth: 200),
//                               child: Builder(
//                                 builder: (context) {
//                                   switch (column['name']) {
//                                     case 'Registration Status':
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: getColorBasedOnStatus(value)
//                                               .withOpacity(0.5),
//                                         ),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         child: CustomText(
//                                             text: value,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 12,
//                                             color:
//                                                 Colors.black.withOpacity(0.6)),
//                                       );
//                                     case 'Phone Number':
//                                       return SelectionArea(
//                                         child: CustomText(
//                                           text: value,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.normal,
//                                           color: AppColors.textColor,
//                                         ),
//                                       );
//                                     case 'Action':
//                                       return Row(
//                                         children: [
//                                           IconButton(
//                                             color:
//                                                 AppColors.greenSecondaryColor,
//                                             icon: Icon(
//                                                 Icons.app_registration_rounded),
//                                             onPressed: () {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (context) =>
//                                                     RegistrationAdd(
//                                                   leadid:
//                                                       listuser.clientId ?? '',
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                           PopupMenuButton<int>(
//                                               color: Colors.white,
//                                               itemBuilder: (context) => [
//                                                     PopupMenuItem(
//                                                       onTap: () => showDialog(
//                                                         context: context,
//                                                         builder: (context) =>
//                                                             CallRecordPopup(
//                                                           clientName:
//                                                               listUser.name ??
//                                                                   '',
//                                                           clientId: '',
//                                                         ),
//                                                       ),
//                                                       value: 1,
//                                                       child: const Row(
//                                                         children: [
//                                                           Icon(
//                                                             Icons.call,
//                                                             color: AppColors
//                                                                 .greenSecondaryColor,
//                                                           ),
//                                                           SizedBox(
//                                                             width: 10,
//                                                           ),
//                                                           Text("Call")
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ]),
//                                         ],
//                                       );
//                                     case 'ID':
//                                       return CustomText(
//                                         text: value,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: AppColors.orangeSecondaryColor,
//                                       );
//                                     default:
//                                       return CustomText(
//                                         text: value,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.normal,
//                                         color: AppColors.textColor,
//                                       );
//                                   }
//                                 },
//                               ),
//                             ),
//                             onTap: () {
//                               if (column['name'] == 'ID') {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => CustomerProfileScreen(
//                                     // isRegistration: true,
//                                     clientId: listUser.clientId ?? "",
//                                     leadId: listuser.clientId ?? "",
//                                   ),
//                                 );
//                               }
//                             },
//                           );
//                         }).toList(),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Color getColorBasedOnStatus(String status) {
//   switch (status.toLowerCase()) {
//     case 'registered':
//       return AppColors.greenSecondaryColor;
//     case 'not registered':
//       return AppColors.redSecondaryColor;
//     // case 'registered' || 'qualified':
//     //   return AppColors.blueSecondaryColor;
//     // case 'interview':
//     //   return AppColors.pinkSecondaryColor;
//     // case 'onHold':
//     //   return AppColors.orangeSecondaryColor;
//     // case 'blocked':
//     //   return Colors.red.withOpacity(0.1);
//     default:
//       return Colors.grey.withOpacity(0.1);
//   }
// }
