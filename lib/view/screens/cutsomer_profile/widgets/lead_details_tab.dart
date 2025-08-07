import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class LeadDetailsTab extends StatelessWidget {
  const LeadDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CustomerProfileController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Lead Information', Icons.assignment_outlined),
            const SizedBox(height: 16),
            _buildDetailCard([
              _buildDetailRow(
                  'Name', controller.leadDetails.value.name ?? 'N/A',
                  color: AppColors.orangeSecondaryColor),
              _buildDetailRow(
                  'Gender', controller.leadDetails?.value.gender ?? 'N/A',
                  color: AppColors.redSecondaryColor),
              _buildDetailRow(
                  'Contact No.', controller.leadDetails?.value.phone ?? 'N/A',
                  color: AppColors.orangeSecondaryColor),
              _buildDetailRow('Alternative No.',
                  controller.leadDetails?.value.alternatePhone ?? 'N/A'),
              _buildDetailRow(
                  'Email', controller.leadDetails?.value.email ?? 'N/A',
                  color: AppColors.greenSecondaryColor),
              _buildDetailRow(
                'Address',
                controller.leadDetails?.value.address ?? 'N/A',
              ),
              _buildDetailRow(
                'City',
                controller.leadDetails?.value.city ?? 'N/A',
              ),
              _buildDetailRow(
                  'Dob',
                  DateFormat("dd MMM yyyy").format(DateTime.tryParse(
                              controller.leadDetails?.value.dob ?? '') ??
                          DateTime.now()) ??
                      'N/A'),
              _buildDetailRow('Material Status',
                  controller.leadDetails?.value.maritalStatus ?? 'N/A'),
            ]),
            const SizedBox(height: 20),
            _buildSectionHeader('Email Credential', Icons.contact_phone),
            const SizedBox(height: 16),
            _buildDetailCard([
              _buildDetailRow(
                  'Email', controller.leadDetails?.value.email ?? 'N/A',
                  color: AppColors.greenSecondaryColor),
            ]),
            _buildSectionHeader('Candidate Preference', Icons.contact_phone),
            const SizedBox(height: 16),
            _buildDetailCard([
              _buildDetailRow(
                  'Expected Salary',
                  controller.leadDetails?.value.expectedSalary?.toString() ??
                      'N/A'),
            ]),
            const SizedBox(height: 20),
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
