import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../utils/functions/format_date.dart';
import '../../../widgets/widgets.dart';

class CallHistoryTab extends StatelessWidget {
  CallHistoryTab({super.key, required this.clientId});
  final String clientId;

  final RxString selectedFilter = "TOTAL".obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerProfileController>();
    controller.fetchCallEvents(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Obx(() {
        final calls = controller.callEvents;

        /// Summary counts
        final total = calls.length;
        final attended = calls
            .where((e) => (e.callStatus ?? '').toUpperCase() == "ATTENDED")
            .length;

        final outgoing = calls
            .where((e) => (e.callType ?? '').toLowerCase() == "outgoing")
            .length;

        final incoming = calls
            .where((e) => (e.callType ?? '').toLowerCase() == "incoming")
            .length;

        final missed = calls
            .where((e) => (e.callStatus ?? '').toUpperCase() == "MISSED")
            .length;

        final notAttended = calls
            .where((e) => (e.callStatus ?? '').toUpperCase() == "NOT ATTENDED")
            .length;

        /// Apply Filter
        final filteredCalls = calls.where((e) {
          final status = (e.callStatus ?? '').toUpperCase();
          final type = (e.callType ?? '').toLowerCase();

          switch (selectedFilter.value) {
            case "ATTENDED":
              return status == "ATTENDED";
            case "OUTGOING":
              return type == "outgoing";
            case "INCOMING":
              return type == "incoming";
            case "MISSED":
              return status == "MISSED";
            case "NOT_ATTENDED":
              return status == "NOT ATTENDED";
            case "TOTAL":
            default:
              return true;
          }
        }).toList();

        final totalDurationMinutes = calls.fold<int>(
          0,
          (previousValue, call) => previousValue + (call.duration ?? 0),
        );

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// ─────────────────────────────────────────────
              ///   FILTER ROW (6 CLICKABLE CARDS)
              /// ─────────────────────────────────────────────
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _filterCard(
                    "Total",
                    total.toString(),
                    Icons.call,
                    Colors.blue,
                    "TOTAL",
                  ),
                  _filterCard(
                    "Attended",
                    attended.toString(),
                    Icons.call_received,
                    Colors.green,
                    "ATTENDED",
                  ),
                  _filterCard(
                    "Outgoing",
                    outgoing.toString(),
                    Icons.call_made,
                    Colors.indigo,
                    "OUTGOING",
                  ),
                  _filterCard(
                    "Incoming",
                    incoming.toString(),
                    Icons.call_received_outlined,
                    Colors.teal,
                    "INCOMING",
                  ),
                  _filterCard(
                    "Missed",
                    missed.toString(),
                    Icons.call_missed,
                    Colors.red,
                    "MISSED",
                  ),
                  _filterCard(
                    "Not Attended",
                    notAttended.toString(),
                    Icons.call_end,
                    Colors.orange,
                    "NOT_ATTENDED",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Recent Calls",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  CustomText(
                    text: totalDurationMinutes >= 3600
                        ? " (Total Duration: ${(totalDurationMinutes ~/ 3600)} hr ${((totalDurationMinutes % 3600) ~/ 60)} min)"
                        : totalDurationMinutes >= 60
                            ? " (Total Duration: ${(totalDurationMinutes ~/ 60)} min)"
                            : " (Total Duration: ${totalDurationMinutes} sec)",
                    fontSize: 16,
                    color: AppColors.textGrayColour,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// ─────────────────────────────────────────────
              ///   CALL LIST
              /// ─────────────────────────────────────────────
              ...filteredCalls.map((call) {
                final status = (call.callStatus ?? '').toUpperCase();
                final type = (call.callType ?? '').toLowerCase();
                Color statusColor = status == "ATTENDED"
                    ? Colors.green
                    : status == "MISSED"
                        ? Colors.red
                        : Colors.orange;

                IconData icon = type == "incoming"
                    ? Icons.call_received
                    : type == "outgoing"
                        ? Icons.call_made
                        : Icons.call;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.iconWhiteColour),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: statusColor, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: call.createdAt != null
                                      ? formatDatetoISTString(
                                              call.createdAt ?? '') ??
                                          'N/A'
                                      : 'N/A',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CustomText(
                                    text: status,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                CustomText(
                                  text:
                                      "Duration: ${(call.duration ?? 0) ~/ 60}:${(call.duration ?? 0) % 60} Min",
                                  fontSize: 12,
                                  color: AppColors.textGrayColour,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: type.toUpperCase(),
                                      fontSize: 12,
                                      color: AppColors.textGrayColour,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  /// ─────────────────────────────────────────────
  ///   FILTER CARD WIDGET (CLICKABLE)
  /// ─────────────────────────────────────────────
  Widget _filterCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String filterKey,
  ) {
    final isActive = selectedFilter.value == filterKey;

    return GestureDetector(
      onTap: () => selectedFilter.value = filterKey,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? color : Colors.grey.shade300,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            CustomText(
              text: value,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: title,
              fontSize: 12,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';

// import '../../../../controller/customer_profile/customer_profile_controller.dart';
// import '../../../widgets/widgets.dart';

// class CallHistoryTab extends StatelessWidget {
//   const CallHistoryTab({super.key, required this.clientId});
//   final String clientId;

//   @override
//   Widget build(BuildContext context) {
//     final profileController = Get.find<CustomerProfileController>();
//     profileController.fetchCallEvents(context);
//     return Container(
//       height: double.infinity,
//       constraints: BoxConstraints(
//         maxHeight: 800,
//       ),
//       child: Obx(
//         () => SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Section Header
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       gradient: AppColors.buttonGraidentColour,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.call_outlined,
//                         color: Colors.white, size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   const CustomText(
//                     text: 'Call History',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               // Call Summary Cards
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: AppColors.blueSecondaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                             color:
//                                 AppColors.blueSecondaryColor.withOpacity(0.3)),
//                       ),
//                       child: Column(
//                         children: [
//                           const Icon(Icons.call,
//                               color: AppColors.blueSecondaryColor, size: 24),
//                           const SizedBox(height: 8),
//                           CustomText(
//                             text:
//                                 profileController.callEvents.length.toString(),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.blueSecondaryColor,
//                           ),
//                           const SizedBox(height: 4),
//                           const CustomText(
//                             text: 'Total Calls',
//                             fontSize: 12,
//                             color: AppColors.textGrayColour,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: AppColors.greenSecondaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                             color:
//                                 AppColors.greenSecondaryColor.withOpacity(0.3)),
//                       ),
//                       child: Column(
//                         children: [
//                           const Icon(Icons.call_received,
//                               color: AppColors.greenSecondaryColor, size: 24),
//                           const SizedBox(height: 8),
//                           CustomText(
//                             text: profileController.callEvents
//                                 .where((element) =>
//                                     element.callStatus == "ATTENDED")
//                                 .length
//                                 .toString(),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.greenSecondaryColor,
//                           ),
//                           const SizedBox(height: 4),
//                           const CustomText(
//                             text: 'Answered',
//                             fontSize: 12,
//                             color: AppColors.textGrayColour,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: AppColors.redSecondaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                             color:
//                                 AppColors.redSecondaryColor.withOpacity(0.3)),
//                       ),
//                       child: Column(
//                         children: [
//                           const Icon(Icons.call_missed,
//                               color: AppColors.redSecondaryColor, size: 24),
//                           const SizedBox(height: 8),
//                           CustomText(
//                             text: profileController.callEvents
//                                 .where(
//                                     (element) => element.callStatus == "MISSED")
//                                 .length
//                                 .toString(),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.redSecondaryColor,
//                           ),
//                           const SizedBox(height: 4),
//                           const CustomText(
//                             text: 'Missed',
//                             fontSize: 12,
//                             color: AppColors.textGrayColour,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Call History List
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const CustomText(
//                     text: 'Recent Calls',
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primaryColor,
//                   ),
//                   const SizedBox(height: 12),
//                   ...profileController.callEvents.map((call) {
//                     Color statusColor = call.callStatus == 'Answered'
//                         ? AppColors.greenSecondaryColor
//                         : AppColors.redSecondaryColor;
//                     IconData callIcon =
//                         call.callType?.toLowerCase() == 'incoming'
//                             ? Icons.call_received
//                             : Icons.call_made;

//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: AppColors.iconWhiteColour),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: statusColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(callIcon, color: statusColor, size: 20),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CustomText(
//                                       text: call.createdAt ?? '',
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.primaryColor,
//                                     ),
//                                     const Spacer(),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: statusColor.withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: CustomText(
//                                         text: call.callStatus ?? '',
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w600,
//                                         color: statusColor,
//                                       ),
//                                     ),
//                                     // InkWell(
//                                     //   onTap: () {
//                                     //     // showDialog(
//                                     //     //   context: context,
//                                     //     //   builder: (context) => CallRecordEditPopup(
//                                     //     //     clientId: clientId,
//                                     //     //     selectedCallType:
//                                     //     //         call.callType?.toLowerCase() ?? '',
//                                     //     //     selectedLeadStatus:
//                                     //     //         call.callStatus ?? '',
//                                     //     //     selectedScheduleDate:
//                                     //     //         DateFormat("dd/mm/yyyy").format(
//                                     //     //                 DateTime.tryParse(
//                                     //     //                         call.nextSchedule ??
//                                     //     //                             "") ??
//                                     //     //                     DateTime.now()) ??
//                                     //     //             '',
//                                     //     //     selectedDuration:
//                                     //     //         call.duration.toString() ?? '',
//                                     //     //     selectedCallStatus:
//                                     //     //         call.callStatus ?? '',
//                                     //     //     selectedFeedback: call.comment ?? '',
//                                     //     //     selectedScheduleTime: DateFormat(
//                                     //     //                 "HH:mm a")
//                                     //     //             .format(DateTime.tryParse(
//                                     //     //                     call.nextScheduleTime ??
//                                     //     //                         "") ??
//                                     //     //                 DateTime.now()) ??
//                                     //     //         '',
//                                     //     //   ),
//                                     //     // );
//                                     //   },
//                                     //   child: const Padding(
//                                     //     padding: EdgeInsets.all(8.0),
//                                     //     child: Icon(
//                                     //       Icons.edit,
//                                     //       color: AppColors.blueSecondaryColor,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     CustomText(
//                                       text:
//                                           'Duration: ${((call.duration ?? 0) / 60).toStringAsFixed(1)} min',
//                                       fontSize: 12,
//                                       color: AppColors.textGrayColour,
//                                     ),
//                                     const SizedBox(width: 16),
//                                     CustomText(
//                                       text: call.callType ?? '',
//                                       fontSize: 12,
//                                       color: AppColors.textGrayColour,
//                                     ),
//                                   ],
//                                 ),
//                                 if (call.comment?.isNotEmpty ?? false) ...[
//                                   const SizedBox(height: 6),
//                                   CustomText(
//                                     text: call.comment ?? '',
//                                     fontSize: 12,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
