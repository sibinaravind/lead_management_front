import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../../utils/style/colors/colors.dart';
import 'widgets.dart';

class PaginationFooterWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final ValueChanged<int> onPageSelected;

  const PaginationFooterWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "$totalItems Leads",
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          CustomPager(
            currentPage: currentPage,
            totalPages: min(totalPages, 100),
            onPageSelected: onPageSelected,
          ),
        ],
      ),
    );
  }
}
