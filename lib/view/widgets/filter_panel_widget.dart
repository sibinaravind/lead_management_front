import 'package:flutter/material.dart';
import '../../../../../utils/style/colors/colors.dart';
import 'custom_text.dart';

class FilterPanelWidget extends StatelessWidget {
  final bool showFilters;
  final Map<String, List<String>> filterOptions;
  final Map<String, dynamic> selectedFilters;
  final ValueChanged<Map<String, dynamic>> onFilterChange;
  final VoidCallback onApply;
  final VoidCallback onClose;

  const FilterPanelWidget({
    super.key,
    required this.showFilters,
    required this.filterOptions,
    required this.selectedFilters,
    required this.onFilterChange,
    required this.onApply,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: showFilters ? null : 0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const CustomText(
                      text: "Advanced Filters",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onClose,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Dropdown filters
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: filterOptions.keys.map((category) {
                return SizedBox(
                  width: 180,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: CustomText(
                              text: category,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                              fontSize: 14,
                            ),
                            isExpanded: true,
                            value: selectedFilters[category],
                            items: filterOptions[category]
                                ?.toSet()
                                .map((option) => DropdownMenuItem<String>(
                                      value: option,
                                      child: CustomText(
                                          text: option, fontSize: 14),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                final newFilters =
                                    Map<String, dynamic>.from(selectedFilters);
                                newFilters[category] = value;
                                onFilterChange(newFilters);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Apply button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const CustomText(
                  text: "Apply Filters",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
