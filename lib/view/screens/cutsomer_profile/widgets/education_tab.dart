import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import 'info_item.dart';

class EducationDeatilsTab extends StatelessWidget {
  final LeadModel lead;
  const EducationDeatilsTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;

            int columnsCount = availableWidth > 1000
                ? 3
                : availableWidth > 600
                    ? 2
                    : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ EDUCATIONAL BACKGROUND --------------------
                const SectionTitle(
                  title: 'Educational Background',
                  icon: Icons.school_rounded,
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                  ),
                  child: ResponsiveGrid(
                    columns: columnsCount,
                    children: [
                      InfoItem(
                        label: 'Highest Qualification',
                        value: lead.highestQualification ?? 'N/A',
                        icon: Icons.school_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Field of Study',
                        value: lead.fieldOfStudy ?? 'N/A',
                        icon: Icons.menu_book_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Year of Passing',
                        value: lead.yearOfPassing?.toString() ?? 'N/A',
                        icon: Icons.calendar_month_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------ COURSES INTERESTED --------------------
                const SectionTitle(
                  title: 'Courses Interested',
                  icon: Icons.menu_book_rounded,
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                  ),
                  child: ResponsiveGrid(
                    columns: columnsCount,
                    children: [
                      InfoItem(
                        label: 'Courses Interested',
                        value: (lead.coursesInterested?.isNotEmpty ?? false)
                            ? lead.coursesInterested!.join(', ')
                            : 'N/A',
                        icon: Icons.bookmarks_rounded,
                        iconColor: AppColors.darkOrangeColour,
                      ),
                      InfoItem(
                        label: 'Preferred Study Mode',
                        value: lead.preferredStudyMode ?? 'N/A',
                        icon: Icons.cast_for_education_rounded,
                        iconColor: AppColors.skyBlueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Batch Preference',
                        value: lead.batchPreference ?? 'N/A',
                        icon: Icons.schedule_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
