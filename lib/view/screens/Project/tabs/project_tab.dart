import 'package:flutter/material.dart';
import '../../../../model/project/vacancy_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class ProjectTab extends StatelessWidget {
  final VacancyModel? data;

  const ProjectTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final isLargeScreen = screenWidth > 1200;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: isLargeScreen
            ? screenHeight - 200
            : 1000, // Fixed height to prevent scrolling
        child: isLargeScreen ? _buildTabletLayout() : _buildMobileLayout(),
      ),
    );
  }

  // Tablet Layout (2 columns)
  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 2, child: _buildJobOverviewCompact()),
              const SizedBox(height: 8),
              Expanded(flex: 1, child: _buildQualificationsCompact()),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right Column
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 1, child: _buildProjectInfoCompact()),
              const SizedBox(height: 8),
              Expanded(flex: 2, child: _buildSpecializationCompact()),
            ],
          ),
        ),
      ],
    );
  }

  // Mobile Layout (Single column with grid cards)
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Top row - Key info
        Expanded(child: _buildJobOverviewCompact()),
        const SizedBox(height: 8),
        Expanded(flex: 1, child: _buildProjectInfoCompact()),
        const SizedBox(height: 8),
        Expanded(child: _buildQualificationsCompact()),
        const SizedBox(height: 8),
        Expanded(child: _buildSpecializationCompact()),
      ],
    );
  }

  Widget _buildJobOverviewCompact() {
    return _buildCompactCard(
      'Job Overview',
      Icons.work_outline,
      [
        _buildCompactRow('Position', data?.jobCategory ?? 'N/A'),
        _buildCompactRow('Experience', '${data?.experience ?? 'N/A'} years'),
        _buildCompactRow('Status', data?.status ?? 'N/A',
            color: data?.status == 'ACTIVE' ? Colors.green : Colors.red),
        if (data?.description?.isNotEmpty == true)
          _buildCompactRow(
              'Description', _truncateText(data!.description!, 50)),
        _buildCompactRow('Salary Range',
            '${_formatSalary(data?.salaryFrom)} - ${_formatSalary(data?.salaryTo)}'),
        _buildCompactRow('Deadline', data?.lastDateToApply ?? 'N/A',
            color: Colors.red.shade600),
        _buildCompactRow('Total Vacancies', '${data?.totalVacancies ?? 0}',
            color: AppColors.primaryColor),
        _buildCompactRow('Target CVs', '${data?.totalTargetCv ?? 0}',
            color: AppColors.primaryColor),
      ],
    );
  }

  Widget _buildProjectInfoCompact() {
    return _buildCompactCard(
      'Project Info',
      Icons.assignment_outlined,
      [
        _buildCompactRow(
            'Project', _truncateText(data?.project?.projectName ?? 'N/A', 25)),
        _buildCompactRow('Type', data?.project?.organizationType ?? 'N/A'),
        _buildCompactRow(
            'Category', data?.project?.organizationCategory ?? 'N/A'),
        _buildCompactRow(
            'Job Location', '${data?.city ?? 'N/A'}, ${data?.country ?? 'N/A'}',
            color: Colors.green.shade600),
        _buildCompactRow('Project Location',
            '${data?.project?.city ?? 'N/A'}, ${data?.project?.country ?? 'N/A'}'),
      ],
    );
  }

  Widget _buildQualificationsCompact() {
    return _buildCompactCard(
      'Qualifications',
      Icons.school_outlined,
      [
        if (data?.qualifications?.isNotEmpty == true)
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: data!.qualifications!
                .take(6)
                .map((qual) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomText(
                        text: qual,
                        fontSize: 13,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                .toList(),
          )
        else
          const CustomText(
              text: 'Not specified', fontSize: 12, color: Colors.grey),
      ],
    );
  }

  Widget _buildSpecializationCompact() {
    return _buildCompactCard(
      'Specializations',
      Icons.category_outlined,
      [
        if (data?.specializationTotals?.isNotEmpty == true)
          ...data!.specializationTotals!
              .take(4)
              .map((spec) => Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: spec.specialization ?? 'N/A',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        CustomText(
                          text: '${spec.count}/${spec.targetCv}',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.orangeSecondaryColor,
                        ),
                      ],
                    ),
                  ))
              .toList()
        else
          const CustomText(
              text: 'No specializations', fontSize: 12, color: Colors.grey),
      ],
    );
  }

  Widget _buildCompactCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.iconWhiteColour),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGraidentColour,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: 80,
              child: CustomText(
                text: '$label:',
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
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

  String _formatSalary(dynamic salary) {
    if (salary == null) return 'N/A';

    if (salary is! int && salary is! double && salary is! num) {
      return 'N/A';
    }

    int salaryInt = salary is int ? salary : (salary as num).toInt();

    if (salaryInt >= 100000) {
      double lakhs = salaryInt / 100000.0;
      return '₹${lakhs.toStringAsFixed(lakhs == lakhs.toInt() ? 0 : 1)}L';
    } else if (salaryInt >= 1000) {
      double thousands = salaryInt / 1000.0;
      return '₹${thousands.toStringAsFixed(thousands == thousands.toInt() ? 0 : 1)}K';
    } else {
      return '₹$salaryInt';
    }
  }

  String _truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
