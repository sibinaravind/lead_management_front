import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../model/lead/call_event_model.dart';
import '../../../../utils/functions/format_date.dart';
import '../../../widgets/widgets.dart';
import '../../leads/widgets/call_record_popup.dart';

// ignore: must_be_immutable
class CallHistoryTab extends StatelessWidget {
  CallHistoryTab({super.key, required this.clientId});
  final String clientId;
  bool isUpComingSelected = false;
  final RxString selectedFilter = "TOTAL".obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerProfileController>();
    controller.fetchCallEvents(context);

    return Align(
      alignment: Alignment.topLeft,
      child: Obx(() {
        final calls = controller.callEvents;

        /// Convert Next Schedule → DateTime if valid
        bool isUpcoming(CallEventModel e) {
          if (e.nextSchedule == null) return false;
          try {
            // Handle dd/MM/yyyy format
            final parts = e.nextSchedule!.split('/');

            if (parts.length == 3) {
              final day = int.parse(parts[0]);
              final month = int.parse(parts[1]);
              final year = int.parse(parts[2]);

              final upcoming = DateTime(year, month, day);

              return upcoming.isAfter(DateTime.now());
            }
            // Fallback to DateTime.parse for other formats
            final upcoming = DateTime.parse(e.nextSchedule!);
            return upcoming.isAfter(DateTime.now());
          } catch (e) {
            return false;
          }
        }

        /// Summary Counts
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

        final upcomingCount = calls.where((e) => isUpcoming(e)).length;

        /// Apply Filter
        final filteredCalls = calls.where((e) {
          final status = (e.callStatus ?? '').toUpperCase();
          final type = (e.callType ?? '').toLowerCase();
          switch (selectedFilter.value) {
            case "UPCOMING":
              return isUpcoming(e);
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

        // Sort filteredCalls by createdAt descending (most recent first)
        filteredCalls.sort((a, b) {
          final aDate = a.createdAt;
          final bDate = b.createdAt;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return bDate.compareTo(aDate);
        });

        final totalDurationMinutes = filteredCalls.fold<int>(
          0,
          (prev, call) => prev + (call.duration ?? 0),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// FILTERS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // spacing: 8,
                // runSpacing: 8,
                children: [
                  _filterCard("Upcoming", upcomingCount, Icons.schedule,
                      Colors.deepPurple, "UPCOMING"),
                  _filterCard("Total", total, Icons.call, Colors.blue, "TOTAL"),
                  _filterCard("Attended", attended, Icons.check_circle,
                      Colors.green, "ATTENDED"),
                  _filterCard("Outgoing", outgoing, Icons.call_made,
                      Colors.indigo, "OUTGOING"),
                  _filterCard("Incoming", incoming, Icons.call_received,
                      Colors.teal, "INCOMING"),
                  _filterCard("Missed", missed, Icons.call_missed, Colors.red,
                      "MISSED"),
                  _filterCard("Not Attended", notAttended, Icons.call_end,
                      Colors.orange, "NOT_ATTENDED"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// HEADER WITH TOTAL DURATION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: isUpComingSelected ? "Upcoming Calls" : "Recent Calls",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                if (!isUpComingSelected)
                  CustomText(
                    text: totalDurationMinutes >= 3600
                        ? " (Total Duration: ${(totalDurationMinutes ~/ 3600)} hr ${((totalDurationMinutes % 3600) ~/ 60)} min)"
                        : totalDurationMinutes >= 60
                            ? " (Total Duration: ${(totalDurationMinutes ~/ 60)} min)"
                            : " (Total Duration: ${totalDurationMinutes} sec)",
                    fontSize: 14,
                    color: AppColors.textGrayColour,
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // // / CALL LIST
            // ...filteredCalls.map(
            //   (call) => callCard(call, isUpcoming(call));
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCalls.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final call = filteredCalls[index];
                  return callCard(call, isUpcoming(call), context);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  /// ───────────────────────────
  /// FORMAT TOTAL DURATION
  /// ───────────────────────────
  String formatDuration(int sec) {
    if (sec >= 3600) {
      return "(${sec ~/ 3600} hr ${(sec % 3600) ~/ 60} min)";
    } else if (sec >= 60) {
      return "(${sec ~/ 60} min)";
    }
    return "($sec sec)";
  }

  /// ───────────────────────────
  /// FILTER CARD
  /// ───────────────────────────
  Widget _filterCard(
      String title, int value, IconData icon, Color color, String key) {
    final active = selectedFilter.value == key;

    return GestureDetector(
      onTap: () {
        if (key == "UPCOMING") {
          isUpComingSelected = true;
        } else {
          isUpComingSelected = false;
        }
        selectedFilter.value = key;
      },
      child: Container(
        width: 115,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: active ? color : Colors.grey.shade300,
              width: active ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text("$value",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: color)),
            Text(title, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  /// ───────────────────────────
  /// CALL ITEM CARD WITH UPCOMING BADGE
  /// ───────────────────────────
  Widget callCard(CallEventModel call, bool isupcoming, BuildContext context) {
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconWhiteColour),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          /// Leading Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUpComingSelected
                  ? Colors.deepPurple.withOpacity(0.12)
                  : statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(isUpComingSelected ? Icons.schedule : icon,
                color: isUpComingSelected ? Colors.deepPurple : statusColor),
          ),
          const SizedBox(width: 12),

          /// Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Time + Status + Upcoming Tag
                Row(
                  children: [
                    CustomRichText(sections: [
                      // if (!isUpComingSelected) ...[
                      //   RichTextSection(
                      //       text: type.toUpperCase(),
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 14,
                      //       color: AppColors.textGrayColour),
                      //   RichTextSection(
                      //       text: "  |  ",
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 14,
                      //       color: AppColors.textGrayColour),
                      // ],
                      RichTextSection(
                          text: isUpComingSelected
                              ? "${call.nextSchedule ?? ''} ${call.nextSheduleTime ?? ''}"
                              : (formatDatetoISTString(call.createdAt!) ??
                                  'N/A'),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: AppColors.primaryColor),
                      if (!isUpComingSelected) ...[
                        RichTextSection(
                            text: "  |  ",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.textGrayColour),
                        RichTextSection(
                            text:
                                " ${(call.duration ?? 0) ~/ 60}:${(call.duration ?? 0) % 60} Min",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.violetPrimaryColor),
                      ],
                    ]),
                    Spacer(),
                    if (call.nextSchedule != null && isupcoming)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CallRecordPopup(
                              clientId: clientId,
                              editData: call,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.edit_calendar_sharp,
                            size: 30,
                            color: AppColors.redSecondaryColor,
                          ),
                        ),
                      )
                  ],
                ),

                /// Comment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if ((call.comment ?? '').isNotEmpty) ...[
                      Text(call.comment ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black87)),
                    ],
                    if (!isUpComingSelected)
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(call.callStatus ?? '',
                            style: TextStyle(
                                fontSize: 10,
                                color: statusColor,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';

// import '../../../../controller/customer_profile/customer_profile_controller.dart';
// import '../../../../utils/functions/format_date.dart';
// import '../../../widgets/widgets.dart';

// class CallHistoryTab extends StatelessWidget {
//   CallHistoryTab({super.key, required this.clientId});
//   final String clientId;

//   final RxString selectedFilter = "TOTAL".obs;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CustomerProfileController>();
//     controller.fetchCallEvents(context);
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Obx(() {
//         final calls = controller.callEvents;

//         /// Summary counts
//         final total = calls.length;
//         final attended = calls
//             .where((e) => (e.callStatus ?? '').toUpperCase() == "ATTENDED")
//             .length;

//         final outgoing = calls
//             .where((e) => (e.callType ?? '').toLowerCase() == "outgoing")
//             .length;

//         final incoming = calls
//             .where((e) => (e.callType ?? '').toLowerCase() == "incoming")
//             .length;

//         final missed = calls
//             .where((e) => (e.callStatus ?? '').toUpperCase() == "MISSED")
//             .length;

//         final notAttended = calls
//             .where((e) => (e.callStatus ?? '').toUpperCase() == "NOT ATTENDED")
//             .length;

//         /// Apply Filter
//         final filteredCalls = calls.where((e) {
//           final status = (e.callStatus ?? '').toUpperCase();
//           final type = (e.callType ?? '').toLowerCase();

//           switch (selectedFilter.value) {
//             case "ATTENDED":
//               return status == "ATTENDED";
//             case "OUTGOING":
//               return type == "outgoing";
//             case "INCOMING":
//               return type == "incoming";
//             case "MISSED":
//               return status == "MISSED";
//             case "NOT_ATTENDED":
//               return status == "NOT ATTENDED";
//             case "TOTAL":
//             default:
//               return true;
//           }
//         }).toList();

//         final totalDurationMinutes = filteredCalls.fold<int>(
//           0,
//           (previousValue, call) => previousValue + (call.duration ?? 0),
//         );

//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),

//               /// ─────────────────────────────────────────────
//               ///   FILTER ROW (6 CLICKABLE CARDS)
//               /// ─────────────────────────────────────────────
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: [
//                   _filterCard(
//                     "Total",
//                     total.toString(),
//                     Icons.call,
//                     Colors.blue,
//                     "TOTAL",
//                   ),
//                   _filterCard(
//                     "Attended",
//                     attended.toString(),
//                     Icons.call_received,
//                     Colors.green,
//                     "ATTENDED",
//                   ),
//                   _filterCard(
//                     "Outgoing",
//                     outgoing.toString(),
//                     Icons.call_made,
//                     Colors.indigo,
//                     "OUTGOING",
//                   ),
//                   _filterCard(
//                     "Incoming",
//                     incoming.toString(),
//                     Icons.call_received_outlined,
//                     Colors.teal,
//                     "INCOMING",
//                   ),
//                   _filterCard(
//                     "Missed",
//                     missed.toString(),
//                     Icons.call_missed,
//                     Colors.red,
//                     "MISSED",
//                   ),
//                   _filterCard(
//                     "Not Attended",
//                     notAttended.toString(),
//                     Icons.call_end,
//                     Colors.orange,
//                     "NOT_ATTENDED",
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const CustomText(
//                     text: "Recent Calls",
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primaryColor,
//                   ),
//                   CustomText(
//                     text: totalDurationMinutes >= 3600
//                         ? " (Total Duration: ${(totalDurationMinutes ~/ 3600)} hr ${((totalDurationMinutes % 3600) ~/ 60)} min)"
//                         : totalDurationMinutes >= 60
//                             ? " (Total Duration: ${(totalDurationMinutes ~/ 60)} min)"
//                             : " (Total Duration: ${totalDurationMinutes} sec)",
//                     fontSize: 16,
//                     color: AppColors.textGrayColour,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               /// ─────────────────────────────────────────────
//               ///   CALL LIST
//               /// ─────────────────────────────────────────────
//               ...filteredCalls.map((call) {
//                 final status = (call.callStatus ?? '').toUpperCase();
//                 final type = (call.callType ?? '').toLowerCase();
//                 Color statusColor = status == "ATTENDED"
//                     ? Colors.green
//                     : status == "MISSED"
//                         ? Colors.red
//                         : Colors.orange;

//                 IconData icon = type == "incoming"
//                     ? Icons.call_received
//                     : type == "outgoing"
//                         ? Icons.call_made
//                         : Icons.call;

//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.iconWhiteColour),
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: statusColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(icon, color: statusColor, size: 22),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 CustomText(
//                                   text: call.createdAt != null
//                                       ? formatDatetoISTString(
//                                               call.createdAt ?? '') ??
//                                           'N/A'
//                                       : 'N/A',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.primaryColor,
//                                 ),
//                                 const Spacer(),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: statusColor.withOpacity(0.15),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: CustomText(
//                                     text: status,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     color: statusColor,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 CustomText(
//                                   text:
//                                       "Duration: ${(call.duration ?? 0) ~/ 60}:${(call.duration ?? 0) % 60} Min",
//                                   fontSize: 12,
//                                   color: AppColors.textGrayColour,
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: CustomText(
//                                       text: type.toUpperCase(),
//                                       fontSize: 12,
//                                       color: AppColors.textGrayColour,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (call.comment != null &&
//                                 (call.comment ?? '').isNotEmpty) ...[
//                               const SizedBox(height: 8),
//                               CustomText(
//                                 text: call.comment ?? '',
//                                 fontSize: 12,
//                                 color: AppColors.primaryColor,
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   /// ─────────────────────────────────────────────
//   ///   FILTER CARD WIDGET (CLICKABLE)
//   /// ─────────────────────────────────────────────
//   Widget _filterCard(
//     String title,
//     String value,
//     IconData icon,
//     Color color,
//     String filterKey,
//   ) {
//     final isActive = selectedFilter.value == filterKey;

//     return GestureDetector(
//       onTap: () => selectedFilter.value = filterKey,
//       child: Container(
//         width: 150,
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: isActive ? color.withOpacity(0.2) : Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: isActive ? color : Colors.grey.shade300,
//             width: isActive ? 2 : 1,
//           ),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 22),
//             const SizedBox(height: 6),
//             CustomText(
//               text: value,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//             const SizedBox(height: 4),
//             CustomText(
//               text: title,
//               fontSize: 12,
//               color: Colors.black54,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
