import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../widgets/widgets.dart';

class CallHistoryTab extends StatelessWidget {
  const CallHistoryTab({super.key, required this.clientId});
  final String clientId;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<CustomerProfileController>();
    profileController.fetchCallEvents(context);
    return Container(
      height: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 800,
      ),
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGraidentColour,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.call_outlined,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const CustomText(
                    text: 'Call History',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Call Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.blueSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color:
                                AppColors.blueSecondaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.call,
                              color: AppColors.blueSecondaryColor, size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text:
                                profileController.callEvents.length.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueSecondaryColor,
                          ),
                          const SizedBox(height: 4),
                          const CustomText(
                            text: 'Total Calls',
                            fontSize: 12,
                            color: AppColors.textGrayColour,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.greenSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color:
                                AppColors.greenSecondaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.call_received,
                              color: AppColors.greenSecondaryColor, size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: profileController.callEvents
                                .where((element) =>
                                    element.callStatus == "ATTENDED")
                                .length
                                .toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenSecondaryColor,
                          ),
                          const SizedBox(height: 4),
                          const CustomText(
                            text: 'Answered',
                            fontSize: 12,
                            color: AppColors.textGrayColour,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.redSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color:
                                AppColors.redSecondaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.call_missed,
                              color: AppColors.redSecondaryColor, size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: profileController.callEvents
                                .where(
                                    (element) => element.callStatus == "MISSED")
                                .length
                                .toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.redSecondaryColor,
                          ),
                          const SizedBox(height: 4),
                          const CustomText(
                            text: 'Missed',
                            fontSize: 12,
                            color: AppColors.textGrayColour,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 20),
              // Call History List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Recent Calls',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 12),
                  ...profileController.callEvents.map((call) {
                    Color statusColor = call.callStatus == 'Answered'
                        ? AppColors.greenSecondaryColor
                        : AppColors.redSecondaryColor;
                    IconData callIcon =
                        call.callType?.toLowerCase() == 'incoming'
                            ? Icons.call_received
                            : Icons.call_made;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.iconWhiteColour),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(callIcon, color: statusColor, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: DateFormat('HH:mm:ss a dd MMM yyyy')
                                          .format(DateTime.parse(
                                              call.createdAt ??
                                                  DateTime.now().toString())),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: CustomText(
                                        text: call.callStatus ?? '',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: statusColor,
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     // showDialog(
                                    //     //   context: context,
                                    //     //   builder: (context) => CallRecordEditPopup(
                                    //     //     clientId: clientId,
                                    //     //     selectedCallType:
                                    //     //         call.callType?.toLowerCase() ?? '',
                                    //     //     selectedLeadStatus:
                                    //     //         call.callStatus ?? '',
                                    //     //     selectedScheduleDate:
                                    //     //         DateFormat("dd/mm/yyyy").format(
                                    //     //                 DateTime.tryParse(
                                    //     //                         call.nextSchedule ??
                                    //     //                             "") ??
                                    //     //                     DateTime.now()) ??
                                    //     //             '',
                                    //     //     selectedDuration:
                                    //     //         call.duration.toString() ?? '',
                                    //     //     selectedCallStatus:
                                    //     //         call.callStatus ?? '',
                                    //     //     selectedFeedback: call.comment ?? '',
                                    //     //     selectedScheduleTime: DateFormat(
                                    //     //                 "HH:mm a")
                                    //     //             .format(DateTime.tryParse(
                                    //     //                     call.nextScheduleTime ??
                                    //     //                         "") ??
                                    //     //                 DateTime.now()) ??
                                    //     //         '',
                                    //     //   ),
                                    //     // );
                                    //   },
                                    //   child: const Padding(
                                    //     padding: EdgeInsets.all(8.0),
                                    //     child: Icon(
                                    //       Icons.edit,
                                    //       color: AppColors.blueSecondaryColor,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    CustomText(
                                      text:
                                          'Duration: ${((call.duration ?? 0) / 60).toStringAsFixed(1)} min',
                                      fontSize: 12,
                                      color: AppColors.textGrayColour,
                                    ),
                                    const SizedBox(width: 16),
                                    CustomText(
                                      text: call.callType ?? '',
                                      fontSize: 12,
                                      color: AppColors.textGrayColour,
                                    ),
                                  ],
                                ),
                                if (call.comment?.isNotEmpty ?? false) ...[
                                  const SizedBox(height: 6),
                                  CustomText(
                                    text: call.comment ?? '',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
