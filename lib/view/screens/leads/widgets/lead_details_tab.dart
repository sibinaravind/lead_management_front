import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../controller/lead/lead_provider.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class LeadDetailsTab extends StatelessWidget {
  const LeadDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<LeadProvider>(
        builder: (context, leadProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Lead Information', Icons.assignment_outlined),
            const SizedBox(height: 16),
            _buildDetailCard([
              _buildDetailRow('Name', leadProvider.leadDetails?.name ?? 'N/A',
                  color: AppColors.orangeSecondaryColor),
              // _buildDetailRow('Last Name', leadProvider.leadDetails?.lastName ?? 'N/A'),
              _buildDetailRow(
                  'Gender', leadProvider.leadDetails?.gender ?? 'N/A',
                  color: AppColors.redSecondaryColor),
              _buildDetailRow(
                  'Contact No.', leadProvider.leadDetails?.phone ?? 'N/A',
                  color: AppColors.orangeSecondaryColor),
              _buildDetailRow('Alternative No.',
                  leadProvider.leadDetails?.alternatePhone ?? 'N/A'),
              // _buildDetailRow('Emergency Contact No.', leadProvider.leadDetails?.emergencyContact ?? 'N/A'),
              _buildDetailRow('Email', leadProvider.leadDetails?.email ?? 'N/A',
                  color: AppColors.greenSecondaryColor),
              _buildDetailRow(
                'Address',
                leadProvider.leadDetails?.address ?? 'N/A',
              ),
              _buildDetailRow(
                'City',
                leadProvider.leadDetails?.city ?? 'N/A',
              ),
              _buildDetailRow(
                  'Dob',
                  DateFormat("dd MMM yyyy").format(DateTime.tryParse(
                              leadProvider.leadDetails?.dob ?? '') ??
                          DateTime.now()) ??
                      'N/A'),
              // _buildDetailRow('Birth Place', leadProvider.leadDetails?. ?? 'N/A'),
              // _buildDetailRow('Country of Birth', leadProvider.leadDetails?. ?? 'N/A'),
              _buildDetailRow('Material Status',
                  leadProvider.leadDetails?.maritalStatus ?? 'N/A'),
              // _buildDetailRow('Religion', leadProvider.leadDetails?. ?? 'N/A'),
              // _buildDetailRow('Passport No.', leadProvider.leadDetails?. ?? 'N/A'),
              // _buildDetailRow('Passport Expiry', leadProvider.leadDetails?. ?? 'N/A'),
            ]),
            const SizedBox(height: 20),
            _buildSectionHeader('Email Credential', Icons.contact_phone),
            const SizedBox(height: 16),
            _buildDetailCard([
              _buildDetailRow('Email', leadProvider.leadDetails?.email ?? 'N/A',
                  color: AppColors.greenSecondaryColor),
              // _buildDetailRow('Password', leadProvider.leadDetails?.password ?? 'N/A'),
              // _buildDetailRow('Contact Method', 'Phone Call, WhatsApp'),
              // _buildDetailRow('Time Zone', 'IST (UTC+5:30)'),
            ]),
            _buildSectionHeader('Candidate Preference', Icons.contact_phone),
            const SizedBox(height: 16),
            _buildDetailCard([
              // _buildDetailRow('Designation', leadProvider.leadDetails?. ?? 'N/A'),
              _buildDetailRow(
                  'Expected Salary',
                  leadProvider.leadDetails?.expectedSalary?.toString() ??
                      'N/A'),
              // _buildDetailRow('Contact Method', 'Phone Call, WhatsApp'),
              // _buildDetailRow('Time Zone', 'IST (UTC+5:30)'),
            ]),
            const SizedBox(height: 20),
            // _buildSectionHeader('Lead Notes', Icons.note_alt_outlined),
            // const SizedBox(height: 16),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: AppColors.textWhiteColour,
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: AppColors.iconWhiteColour),
            //   ),
            //   child: const CustomText(
            //     text:
            //         'Customer showed high interest in Canada PR program. Has relevant work experience in IT sector. Requested detailed information about Express Entry process and timeline.',
            //     fontSize: 14,
            //     color: AppColors.primaryColor,
            //   ),
            // ),
          ],
        ),
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

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.iconWhiteColour),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textGrayColour,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomText(
              text: value,
              fontSize: 14,
              color: color ?? AppColors.primaryColor,
              fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
