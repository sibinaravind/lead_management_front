import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/lead/lead_provider.dart';
import 'package:overseas_front_end/model/lead/call_event_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/screens/leads/widgets/call_record_edit_popup.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';

class CallHistoryTab extends StatelessWidget {
  const CallHistoryTab({super.key, required this.clientId});
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Call History', Icons.call_outlined),
          const SizedBox(height: 16),
          _buildCallSummaryCards(context),
          const SizedBox(height: 20),
          _buildCallHistoryList(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGraidentColour,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildCallSummaryCards(context) {
    return Row(
      children: [
        Expanded(
            child: _buildSummaryCard(
                'Total Calls',
                Provider.of<LeadProvider>(context, listen: false)
                    .callEvents
                    .length
                    .toString(),
                AppColors.blueSecondaryColor,
                Icons.call)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildSummaryCard(
                'Answered',
                Provider.of<LeadProvider>(context, listen: false)
                    .callEvents
                    .where(
                      (element) => element.callStatus == "ATTENDED",
                    )
                    .length
                    .toString(),
                AppColors.greenSecondaryColor,
                Icons.call_received)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildSummaryCard(
                'Missed',
                Provider.of<LeadProvider>(context, listen: false)
                    .callEvents
                    .where(
                      (element) => element.callStatus == "MISSED",
                    )
                    .length
                    .toString(),
                AppColors.redSecondaryColor,
                Icons.call_missed)),
        const SizedBox(width: 12),
        // Expanded(
        //     child: _buildSummaryCard('Total Duration', '2h 45m',
        //         AppColors.viloletSecondaryColor, Icons.schedule)),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          CustomText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: title,
            fontSize: 12,
            color: AppColors.textGrayColour,
          ),
        ],
      ),
    );
  }

  Widget _buildCallHistoryList(context) {
    final calls = [
      {
        'date': '28 May 2024',
        'time': '2:30 PM',
        'duration': '15 min',
        'type': 'Outgoing',
        'status': 'Answered',
        'notes': 'Discussed Canada PR requirements'
      },
      {
        'date': '25 May 2024',
        'time': '11:45 AM',
        'duration': '8 min',
        'type': 'Incoming',
        'status': 'Answered',
        'notes': 'Follow-up on document submission'
      },
      {
        'date': '22 May 2024',
        'time': '4:15 PM',
        'duration': '0 min',
        'type': 'Outgoing',
        'status': 'Missed',
        'notes': 'Customer callback requested'
      },
      {
        'date': '20 May 2024',
        'time': '10:20 AM',
        'duration': '22 min',
        'type': 'Outgoing',
        'status': 'Answered',
        'notes': 'Initial consultation - Express Entry'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Recent Calls',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 12),
        ...Provider.of<LeadProvider>(context, listen: false)
            .callEvents
            .map((call) => _buildCallItem(call, context))
            .toList(),
      ],
    );
  }

  Widget _buildCallItem(CallEventModel call, BuildContext context) {
    Color statusColor = call.callStatus == 'Answered'
        ? AppColors.greenSecondaryColor
        : AppColors.redSecondaryColor;
    IconData callIcon =
        call.callType == 'Incoming' ? Icons.call_received : Icons.call_made;

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
                      text:
                          '${DateFormat('HH:mm:ss a dd MMM yyyy').format(DateTime.parse(call.createdAt ?? DateTime.now().toString()))}',
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
                    InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => CallRecordEditPopup(
                                    clientId: clientId,
                                    selectedCallType:
                                        call.callType?.toLowerCase() ?? '',
                                    selectedLeadStatus: call.callStatus ?? '',
                                    selectedScheduleDate: DateFormat(
                                                "dd/mm/yyyy")
                                            .format(DateTime.tryParse(
                                                    call.nextSchedule ?? "") ??
                                                DateTime.now()) ??
                                        '',
                                    selectedDuration:
                                        call.duration.toString() ?? '',
                                    selectedCallStatus: call.callStatus ?? '',
                                    selectedFeedback: call.comment ?? '',
                                    selectedScheduleTime: DateFormat("HH:mm a")
                                            .format(DateTime.tryParse(
                                                    call.nextScheduleTime ??
                                                        "") ??
                                                DateTime.now()) ??
                                        '',
                                  ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            color: AppColors.blueSecondaryColor,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    CustomText(
                      text: 'Duration: ${call.duration}',
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
  }
}
