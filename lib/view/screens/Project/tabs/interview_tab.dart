import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../utils/style/colors/colors.dart';

class InterviewTab extends StatelessWidget {
  InterviewTab({super.key});
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        // margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Table Header
            // Container(
            //   width: double.maxFinite,
            //   padding: const EdgeInsets.only(
            //       top: 6, bottom: 8, left: 15, right: 15),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: const BorderRadius.only(
            //         bottomLeft: Radius.circular(20),
            //         bottomRight: Radius.circular(20)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.05),
            //         blurRadius: 20,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            // child: Row(
            // children: [
            // Expanded(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         _buildFilterChip(
            //           icon: Icons.all_inclusive,
            //           text: 'All Leads',
            //           count: 128,
            //           color: AppColors.primaryColor,
            //           isSelected: selectedFilter == 'all',
            //           onTap: () {
            //             selectedFilter = 'all';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.fiber_new,
            //           text: 'New',
            //           count: 10,
            //           color: AppColors.blueSecondaryColor,
            //           isSelected: selectedFilter == 'new',
            //           onTap: () {
            //             selectedFilter = 'new';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.today,
            //           text: 'Today',
            //           count: 24,
            //           color: AppColors.greenSecondaryColor,
            //           isSelected: selectedFilter == 'today',
            //           onTap: () {
            //             selectedFilter = 'today';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.schedule,
            //           text: 'Pending',
            //           count: 8,
            //           color: AppColors.orangeSecondaryColor,
            //           isSelected: selectedFilter == 'pending',
            //           onTap: () {
            //             selectedFilter = 'pending';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.trending_up,
            //           text: 'Hot Leads',
            //           count: 15,
            //           color: AppColors.redSecondaryColor,
            //           isSelected: selectedFilter == 'hot',
            //           onTap: () {
            //             selectedFilter = 'hot';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.history,
            //           text: 'Converted',
            //           count: 156,
            //           color: AppColors.viloletSecondaryColor,
            //           isSelected: selectedFilter == 'converted',
            //           onTap: () {
            //             selectedFilter = 'converted';
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ],
            // ),
            // ),
            // Table Content
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: InterviewUserListTable(userlist: userList.data),
            // ),

            // Footer with Pagination
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.textGrayColour.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.blackGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomText(
                          //   text: "${userList.totalItems} Leads",
                          //   color: AppColors.primaryColor,
                          //   fontWeight: FontWeight.w700,
                          //   fontSize: 15,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // CustomPager(
                  //   currentPage: controller.currentPage.value + 1,
                  //   totalPages: min(userList.totalItems, 100),
                  //   onPageSelected: (page) {
                  //     if (controller.currentPage.value != page - 1) {
                  //       controller.currentPage.value = page - 1;
                  //       controller.onPageSelected(page - 1);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
