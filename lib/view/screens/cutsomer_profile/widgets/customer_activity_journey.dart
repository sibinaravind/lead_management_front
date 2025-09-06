import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../model/lead/customer_journeydata.dart';
import '../../../../utils/style/colors/colors.dart';

class CustomerJourneyStages extends StatelessWidget {
  final String leadid;
  const CustomerJourneyStages({
    required this.leadid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration

    final profile_controller = Get.find<CustomerProfileController>();
    profile_controller.getCustomerJourneyStages(context, leadid);
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGraident,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Journey',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          if (profile_controller.customerJourneyStages.isEmpty) ...[
            ListView.builder(
                itemBuilder: (context, index) {
                  return CustomShimmerWidget();
                },
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()),
          ] else ...[
            ...profile_controller.customerJourneyStages
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              CustomerJourneyData data = entry.value;
              bool isLast =
                  index == profile_controller.customerJourneyStages.length - 1;

              return _buildStageItem(data, index, isLast);
            }).toList(),
          ]
        ],
      ),
    );
  }

  Widget _buildStageItem(CustomerJourneyData data, int index, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _getGradientForType(data.type),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _getColorForType(data.type).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                _getIconForType(data.type),
                color: Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _getColorForType(data.type).withOpacity(0.5),
                      Colors.grey.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: _getGradientForType(data.type),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStageTitle(data.type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDate(data.createdAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (data.comment.isNotEmpty)
                  Text(
                    data.comment,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                const SizedBox(height: 8),
                if (data.officer.name?.isNotEmpty ?? false)
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGraidentColour,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.officer.name ?? '',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (data.officer.designation?.isNotEmpty ?? false)
                              Text(
                                data.officer.designation?.join(', ') ?? '',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getGradientForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return AppColors.greenGradient;
      case 'assign_officer':
        return AppColors.blueGradient;
      case 'status_update':
        return AppColors.orangeGradient;
      case 'client_restored':
        return AppColors.pinkGradient;
      default:
        return AppColors.buttonGraidentColour;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return const Color(0xFF10B981);
      case 'assign_officer':
        return const Color(0xFF3B82F6);
      case 'status_update':
        return const Color(0xFFF59E0B);
      case 'client_restored':
        return const Color(0xFFEC4899);
      default:
        return AppColors.violetPrimaryColor;
    }
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return Icons.person_add;
      case 'assign_officer':
        return Icons.assignment_ind;
      case 'status_update':
        return Icons.update;
      case 'client_restored':
        return Icons.restore;
      default:
        return Icons.timeline;
    }
  }

  String _getStageTitle(String type) {
    switch (type.toLowerCase()) {
      case 'customer_created':
        return 'Customer Created';
      case 'assign_officer':
        return 'Officer Assigned';
      case 'status_update':
        return 'Status Updated';
      case 'client_restored':
        return 'Client Restored';
      default:
        return type.replaceAll('_', ' ').toUpperCase();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
