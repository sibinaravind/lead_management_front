import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../model/lead/call_event_model.dart';
import '../../../../utils/functions/format_date.dart';
import '../../../widgets/widgets.dart';

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
          } catch (_) {
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

            /// CALL LIST
            // ...filteredCalls.map(
            //   (call) => callCard(call, isUpcoming(call)),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCalls.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final call = filteredCalls[index];
                  return callCard(call, isUpcoming(call));
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
  Widget callCard(CallEventModel call, bool isupcoming) {
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
                    Text(
                      isUpComingSelected
                          ? "${call.nextSchedule ?? ''} ${formatDecimalMinutes(call.nextSheduleTime ?? 0)}"
                          : (formatDatetoISTString(call.createdAt!) ?? 'N/A'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const Spacer(),

                    /// Upcoming badge
                    if (!isUpComingSelected)
                      Container(
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
                const SizedBox(height: 6),
                if (!isUpComingSelected)

                  /// Duration + Type
                  Row(
                    children: [
                      Text(
                        "Duration: ${(call.duration ?? 0) ~/ 60}:${(call.duration ?? 0) % 60} Min",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        type.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),

                /// Comment
                if ((call.comment ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(call.comment ?? '',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatDecimalMinutes(double decimalMinutes) {
  final minutes = decimalMinutes.floor();
  final seconds = ((decimalMinutes - minutes) * 60).round();
  return "$minutes:${seconds.toString().padLeft(2, '0')} ";
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
