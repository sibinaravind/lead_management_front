// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../controller/lead/lead_provider.dart';
// import '../../../res/style/colors/colors.dart';
// import '../../widgets/custom_text.dart';

// class LeadMobDisplay extends StatefulWidget {
//   const LeadMobDisplay({super.key});

//   @override
//   State<LeadMobDisplay> createState() => _LeadMobDisplayState();
// }

// List dummyData = [
//   {
//     "mobile": "+81-90-1234-5678",
//     "name": "Tanaka Hiroshi",
//     "type": "Incoming",
//     "status": "Attended",
//     "timestamp": "2025-07-04T08:15:00",
//     "duration": "120",
//     "leadStatus": "Hotlead"
//   },
//   {
//     "mobile": "+81-90-2345-6789",
//     "name": "Sato Yumi",
//     "type": "Outgoing",
//     "status": "Attended",
//     "timestamp": "2025-07-04T09:30:00",
//     "duration": "300",
//     "leadStatus": "Qualified"
//   },
//   {
//     "mobile": "+81-70-3456-7890",
//     "name": "Suzuki Ken",
//     "type": "Incoming",
//     "status": "Not Attended",
//     "timestamp": "2025-07-04T10:45:00",
//     "duration": "0",
//     "leadStatus": "OnHold"
//   },
//   {
//     "mobile": "+81-98-456-7890",
//     "name": "Unknown",
//     "type": "Incoming",
//     "status": "Missed Call",
//     "timestamp": "2025-07-04T11:00:00",
//     "duration": "0",
//     "leadStatus": "Blocked"
//   },
//   {
//     "mobile": "+81-80-5678-9012",
//     "name": "Kobayashi Mika",
//     "type": "Outgoing",
//     "status": "Attended",
//     "timestamp": "2025-07-04T11:30:00",
//     "duration": "180",
//     "leadStatus": "Registered"
//   },
//   {
//     "mobile": "+81-90-6789-0123",
//     "name": "Yamamoto Taro",
//     "type": "Incoming",
//     "status": "Attended",
//     "timestamp": "2025-07-04T12:00:00",
//     "duration": "60",
//     "leadStatus": "Interview"
//   },
//   {
//     "mobile": "+81-70-7890-1234",
//     "name": "Unknown",
//     "type": "Outgoing",
//     "status": "Not Attended",
//     "timestamp": "2025-07-04T12:45:00",
//     "duration": "0",
//     "leadStatus": "NotEligible"
//   },
//   {
//     "mobile": "+81-98-890-1234",
//     "name": "Nakamura Ayaka",
//     "type": "Incoming",
//     "status": "Missed Call",
//     "timestamp": "2025-07-04T13:15:00",
//     "duration": "0",
//     "leadStatus": "Closed"
//   },
//   {
//     "mobile": "+81-80-9012-3456",
//     "name": "Fujita Koji",
//     "type": "Outgoing",
//     "status": "Attended",
//     "timestamp": "2025-07-04T14:00:00",
//     "duration": "240",
//     "leadStatus": "Hotlead"
//   },
//   {
//     "mobile": "+81-90-0123-4567",
//     "name": "Shimizu Reina",
//     "type": "Incoming",
//     "status": "Attended",
//     "timestamp": "2025-07-04T14:30:00",
//     "duration": "150",
//     "leadStatus": "Qualified"
//   }
// ];

// class _LeadMobDisplayState extends State<LeadMobDisplay> {
//   String selectedFilter = 'all';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Consumer<LeadProvider>(
//           builder: (context, value, child) => Column(
//             children: value.allLeadModel
//                 .map((e) => Card(
//                       color: Colors.white,
//                       elevation: 4,
//                       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       e.name ?? "",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: const Color.fromARGB(
//                                             255, 56, 69, 113),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.all(5),
//                                         child: Text(e.clientId ?? '')),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: 8),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.primaryColor,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                       e.phone ?? "",
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4),
//                             Container(
//                               margin: EdgeInsets.all(5),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     e.email ?? "",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                   // Icon(
//                                   //   Icons.call,
//                                   //   color: AppColors.greenSecondaryColor,
//                                   // )
//                                 ],
//                               ),
//                             ),
//                             Wrap(spacing: 8, runSpacing: 4, children: [
//                               _buildStatusChip(
//                                   'MIGRATION', AppColors.skyBlueSecondaryColor),
//                               _buildStatusChip('REGISTRATION',
//                                   AppColors.orangeSecondaryColor),
//                               _buildInfoChip(Icons.email, 'sibin.pp@email.com',
//                                   AppColors.greenSecondaryColor),
//                               _buildInfoChip(
//                                   Icons.location_on,
//                                   'Location: Kerala, India',
//                                   AppColors.orangeSecondaryColor),
//                             ]),
//                           ],
//                         ),
//                         // subtitle: Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         //     Padding(
//                         //       padding: EdgeInsets.only(top: 8),
//                         //       child: Container(
//                         //         padding: EdgeInsets.symmetric(
//                         //             horizontal: 8, vertical: 4),
//                         //         decoration: BoxDecoration(
//                         //           color: AppColors.greenSecondaryColor
//                         //               .withOpacity(0.1),
//                         //           borderRadius: BorderRadius.circular(8),
//                         //         ),
//                         //         child: Text(
//                         //           e.leadStatus ?? "",
//                         //           style: TextStyle(
//                         //             color: getColorBasedOnStatus(
//                         //                 e.leadStatus ?? ""),
//                         //             fontWeight: FontWeight.w500,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //     SizedBox(
//                         //       width: 5,
//                         //     ),
//                         //     Padding(
//                         //       padding: EdgeInsets.only(top: 8),
//                         //       child: Container(
//                         //         padding: EdgeInsets.symmetric(
//                         //             horizontal: 8, vertical: 4),
//                         //         decoration: BoxDecoration(
//                         //           color: AppColors.greenSecondaryColor
//                         //               .withOpacity(0.1),
//                         //           borderRadius: BorderRadius.circular(8),
//                         //         ),
//                         //         child: Text(
//                         //           e.status ?? "",
//                         //           style: TextStyle(
//                         //             color: e.status == "Attended"
//                         //                 ? AppColors.greenSecondaryColor
//                         //                 : AppColors.redSecondaryColor,
//                         //             fontWeight: FontWeight.w500,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ],
//                         // ),
//                         // trailing: FittedBox(
//                         //   child: Column(
//                         //     children: [
//                         //       Icon(
//                         //         e.type?.toLowerCase() == "incoming" &&
//                         //                 e.status?.toLowerCase() != "missed call"
//                         //             ? Icons.call_received
//                         //             : e.status?.toLowerCase() == "missed call"
//                         //                 ? Icons.call_missed
//                         //                 : Icons.call_made,
//                         //         color: e.type?.toLowerCase() == "incoming"
//                         //             ? AppColors.redSecondaryColor
//                         //             : AppColors.greenSecondaryColor,
//                         //         size: 28,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 10,
//                         //       ),
//                         //       Icon(
//                         //         Icons.call,
//                         //         color: AppColors.greenSecondaryColor,
//                         //       )
//                         //     ],
//                         //   ),
//                         // ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 6),
//           CustomText(text: text, fontSize: 9, color: color),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip({
//     required IconData icon,
//     required String text,
//     required int count,
//     required Color color,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: onTap,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//             decoration: BoxDecoration(
//               color: isSelected ? color : Colors.transparent,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: isSelected ? color : color.withOpacity(0.3),
//                 width: 1.5,
//               ),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: color.withOpacity(0.3),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ]
//                   : null,
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   icon,
//                   color: isSelected ? Colors.white : color,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 8),
//                 CustomText(
//                   text: text,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: isSelected ? Colors.white : AppColors.primaryColor,
//                 ),
//                 const SizedBox(width: 12),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? Colors.white.withOpacity(0.2)
//                         : color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: CustomText(
//                     text: count.toString(),
//                     color: isSelected ? Colors.white : color,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: CustomText(
//         text: text,
//         fontSize: 9,
//         fontWeight: FontWeight.w600,
//         color: color,
//       ),
//     );
//   }

//   Color getColorBasedOnStatus(String status) {
//     switch (status.toLowerCase()) {
//       case 'hotlead':
//         return AppColors.greenSecondaryColor;
//       case 'noteligible' || 'closed':
//         return AppColors.redSecondaryColor;
//       case 'registered' || 'qualified':
//         return AppColors.blueSecondaryColor;
//       case 'interview':
//         return AppColors.pinkSecondaryColor;
//       case 'onHold':
//         return AppColors.orangeSecondaryColor;
//       case 'blocked':
//         return Colors.red.withOpacity(1);
//       default:
//         return Colors.white.withOpacity(1);
//     }
//   }
// }
