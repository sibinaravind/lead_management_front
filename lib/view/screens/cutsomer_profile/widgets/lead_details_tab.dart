import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/functions/format_date.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/responsive_grid.dart';
import 'info_section.dart';
import 'info_item.dart';

class LeadDetailsTab extends StatelessWidget {
  const LeadDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CustomerProfileController>(
        builder: (controller) {
          final lead = controller.leadDetails.value;
          return LayoutBuilder(builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            int columnsCount = availableWidth > 1000 ? 2 : 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Responsive Grid Layout
                ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    InfoSection(
                      title: 'Lead Information',
                      icon: Icons.assignment_outlined,
                      items: [
                        InfoItem(
                          label: 'Lead ID',
                          value: lead.clientId ?? 'N/A',
                          icon: Icons.badge,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Service Type',
                          value: lead.serviceType ?? 'N/A',
                          icon: Icons.category,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Lead Source',
                          value: lead.leadSource ?? 'N/A',
                          icon: Icons.source,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Source Campaign',
                          value: lead.sourceCampaign ?? 'N/A',
                          icon: Icons.campaign,
                          iconColor: AppColors.viloletSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Branch',
                          value: lead.branch ?? 'N/A',
                          icon: Icons.business,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Officer ID',
                          value: lead.officerGenId ?? 'N/A',
                          icon: Icons.person_pin,
                          iconColor: AppColors.redSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Officer Name',
                          value: lead.officerName ?? 'N/A',
                          icon: Icons.person_pin,
                          iconColor: AppColors.redSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Created At',
                          value: lead.createdAt ?? 'N/A',
                          icon: Icons.calendar_month,
                          iconColor: AppColors.redSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Last Updated',
                          value: lead.updatedAt ?? 'N/A',
                          icon: Icons.update,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        if (lead.lastcall != null)
                          InfoItem(
                            label: 'Last Call Date',
                            value: lead.lastcall?.createdAt != null
                                ? formatDatetoISTString(
                                        lead.lastcall?.createdAt ?? '') ??
                                    'N/A'
                                : 'N/A',
                            icon: Icons.call,
                            iconColor: AppColors.darkOrangeColour,
                          ),
                      ],
                    ),
                    InfoSection(
                      title: 'Preferences',
                      icon: Icons.favorite_border,
                      items: [
                        if (lead.interestedIn != null &&
                            lead.interestedIn!.isNotEmpty)
                          InfoItem(
                            label: 'Interested In',
                            value: lead.interestedIn!.join(', '),
                            icon: Icons.interests,
                            iconColor: AppColors.blueSecondaryColor,
                          ),
                        if (lead.countryInterested != null &&
                            lead.countryInterested!.isNotEmpty)
                          InfoItem(
                            label: 'Countries Interested',
                            value: lead.countryInterested!.join(', '),
                            icon: Icons.public,
                            iconColor: AppColors.greenSecondaryColor,
                          ),
                        if (lead.coursesInterested != null &&
                            lead.coursesInterested!.isNotEmpty)
                          InfoItem(
                            label: 'Courses Interested',
                            value: lead.coursesInterested!.join(', '),
                            icon: Icons.school,
                            iconColor: AppColors.viloletSecondaryColor,
                          ),
                        if (lead.highestQualification != null &&
                            lead.highestQualification!.isNotEmpty)
                          InfoItem(
                            label: 'Highest Qualification',
                            value: lead.highestQualification!,
                            icon: Icons.school,
                            iconColor: AppColors.orangeSecondaryColor,
                          ),
                        if (lead.preferredDate != null &&
                            lead.preferredDate!.isNotEmpty)
                          InfoItem(
                            label: 'Preferred Date',
                            value: lead.preferredDate != null
                                ? DateFormat("dd MMM yyyy").format(
                                    DateTime.tryParse(lead.preferredDate!) ??
                                        DateTime.now())
                                : 'N/A',
                            icon: Icons.calendar_month,
                            iconColor: AppColors.blueSecondaryColor,
                          ),
                        if (lead.expectedSalary != null)
                          InfoItem(
                            label: 'Expected Salary',
                            value: '₹${lead.expectedSalary}',
                            icon: Icons.attach_money,
                            iconColor: AppColors.greenSecondaryColor,
                          ),
                        if (lead.preferredLocation != null &&
                            lead.preferredLocation!.isNotEmpty)
                          InfoItem(
                            label: 'Preferred Location',
                            value: lead.preferredLocation!,
                            icon: Icons.place,
                            iconColor: AppColors.orangeSecondaryColor,
                          ),
                        if (lead.budget != null && lead.budget! > 0)
                          InfoItem(
                            label: 'Budget',
                            value: '₹${lead.budget!.toStringAsFixed(0)}',
                            icon: Icons.account_balance_wallet,
                            iconColor: AppColors.greenSecondaryColor,
                          ),
                        if (lead.deadLeadReason != null &&
                            lead.deadLeadReason!.isNotEmpty)
                          InfoItem(
                            label: 'Dead Lead Reason',
                            value: lead.deadLeadReason!,
                            icon: Icons.cancel,
                            iconColor: AppColors.redSecondaryColor,
                          ),
                        if (lead.groupType != null &&
                            lead.groupType!.isNotEmpty)
                          InfoItem(
                            label: 'Group Type',
                            value: lead.groupType!,
                            icon: Icons.group,
                            iconColor: AppColors.blueSecondaryColor,
                          ),
                        if (lead.totalPeoples != null &&
                            lead.totalPeoples!.isNotEmpty)
                          InfoItem(
                            label: 'Total People',
                            value: lead.totalPeoples!,
                            icon: Icons.people,
                            iconColor: AppColors.greenSecondaryColor,
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    InfoSection(
                      title: 'Contact Information',
                      icon: Icons.contact_phone,
                      items: [
                        InfoItem(
                          label: 'Primary Phone',
                          value:
                              '${lead.countryCode ?? ''} ${lead.phone ?? 'N/A'}',
                          icon: Icons.phone,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        if (lead.alternatePhone != null &&
                            lead.alternatePhone!.isNotEmpty)
                          InfoItem(
                            label: 'Alternate Phone',
                            value: lead.alternatePhone!,
                            icon: Icons.phone_android,
                            iconColor: AppColors.blueSecondaryColor,
                          ),
                        InfoItem(
                          label: 'Email',
                          value: lead.email ?? 'N/A',
                          icon: Icons.email,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                        if (lead.whatsapp != null && lead.whatsapp!.isNotEmpty)
                          InfoItem(
                            label: 'WhatsApp',
                            value: lead.whatsapp!,
                            icon: Icons.chat,
                            iconColor: AppColors.greenSecondaryColor,
                          ),
                        if (lead.emergencyContact != null &&
                            lead.emergencyContact!.isNotEmpty)
                          InfoItem(
                            label: 'Emergency Contact',
                            value: lead.emergencyContact!,
                            icon: Icons.emergency,
                            iconColor: AppColors.redSecondaryColor,
                          ),
                      ],
                    ),
                    _buildCommunicationSection(lead),
                  ],
                ),

                const SizedBox(height: 16),

                ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    InfoSection(
                      title: 'Personal Information',
                      icon: Icons.person_outlined,
                      items: [
                        InfoItem(
                          label: 'Date of Birth',
                          value: lead.dob != null
                              ? DateFormat("dd MMM yyyy").format(
                                  DateTime.tryParse(lead.dob!) ??
                                      DateTime.now())
                              : 'N/A',
                          icon: Icons.cake,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Marital Status',
                          value: lead.maritalStatus ?? 'N/A',
                          icon: Icons.family_restroom,
                          iconColor: AppColors.redSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Gender',
                          value: lead.gender ?? 'N/A',
                          icon: Icons.person,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Religion',
                          value: lead.religion ?? 'N/A',
                          icon: Icons.people,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Birth Place',
                          value: lead.birthPlace ?? 'N/A',
                          icon: Icons.place,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Birth Country',
                          value: lead.birthCountry ?? 'N/A',
                          icon: Icons.flag,
                          iconColor: AppColors.viloletSecondaryColor,
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Address Information',
                      icon: Icons.location_on,
                      items: [
                        InfoItem(
                          label: 'Address',
                          value: lead.address ?? 'N/A',
                          icon: Icons.home,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                        InfoItem(
                          label: 'City',
                          value: lead.city ?? 'N/A',
                          icon: Icons.location_city,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                        InfoItem(
                          label: 'State',
                          value: lead.state ?? 'N/A',
                          icon: Icons.map,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                        InfoItem(
                          label: 'Country',
                          value: lead.country ?? 'N/A',
                          icon: Icons.flag,
                          iconColor: AppColors.viloletSecondaryColor,
                        ),
                        if (lead.pincode != null && lead.pincode!.isNotEmpty)
                          InfoItem(
                            label: 'Pincode',
                            value: lead.pincode!,
                            icon: Icons.numbers,
                            iconColor: AppColors.orangeSecondaryColor,
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Additional Notes & Feedback Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.05),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGraidentColour,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.note,
                                  color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomText(
                                text: 'Additional Information',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            if (lead.note != null && lead.note!.isNotEmpty)
                              InfoItem(
                                label: 'Note',
                                value: lead.note!,
                                icon: Icons.note,
                                iconColor: AppColors.orangeSecondaryColor,
                              ),
                            const SizedBox(height: 16),
                            if (lead.feedback != null &&
                                lead.feedback!.isNotEmpty)
                              InfoItem(
                                label: 'Feedback',
                                value: lead.feedback!,
                                icon: Icons.feedback,
                                iconColor: AppColors.redSecondaryColor,
                              ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildCommunicationSection(LeadModel lead) {
    final preferences = [
      if (lead.onCallCommunication == true)
        {
          'label': 'On Call',
          'icon': Icons.call,
          'color': AppColors.blueSecondaryColor
        },
      if (lead.phoneCommunication == true)
        {
          'label': 'Text Message',
          'icon': Icons.message,
          'color': AppColors.greenSecondaryColor
        },
      if (lead.emailCommunication == true)
        {
          'label': 'Email',
          'icon': Icons.email,
          'color': AppColors.redSecondaryColor
        },
      if (lead.whatsappCommunication == true)
        {
          'label': 'WhatsApp',
          'icon': Icons.chat,
          'color': AppColors.darkVioletColour
        },
    ];

    if (preferences.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGraidentColour,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.settings_phone,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(
                      text: 'Communication Preferences',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CustomText(
                  text: 'No communication preferences set',
                  fontSize: 14,
                  color: AppColors.textGrayColour,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGraidentColour,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.settings_phone,
                      color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomText(
                    text: 'Communication Preferences',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: preferences.map((pref) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: (pref['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: (pref['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(pref['icon'] as IconData,
                          size: 16, color: pref['color'] as Color),
                      const SizedBox(width: 8),
                      CustomText(
                        text: pref['label'] as String,
                        fontSize: 13,
                        color: pref['color'] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
