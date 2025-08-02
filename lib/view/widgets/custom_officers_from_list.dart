import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomOfficersFromList extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final List<OfficerModel> selectedOfficers;
  final List<OfficerModel> allOfficers;
  final Function(List<OfficerModel>) onOfficersSelected;
  final VoidCallback? onSubmitted;
  final bool showSelectedCount;
  final Color? buttonColor;
  final double? buttonWidth;

  const CustomOfficersFromList({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.selectedOfficers,
    required this.allOfficers,
    required this.onOfficersSelected,
    this.showSelectedCount = true,
    this.buttonColor,
    this.buttonWidth,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton.icon(
        onPressed: () => _showOfficerSelectionDialog(context),
        icon: Icon(buttonIcon, size: 20),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(buttonText),
            if (showSelectedCount && selectedOfficers.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedOfficers.length.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _showOfficerSelectionDialog(BuildContext context) async {
    List<OfficerModel> filteredOfficers = List.from(allOfficers);
    String searchQuery = '';

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFBFF),
                      Color(0xFFF8FAFC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with gradient
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: AppColors.blackGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.orangeSecondaryColor
                                  .withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Select Officers',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (selectedOfficers.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${selectedOfficers.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content
                      Container(
                        height: 380,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Search field
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search officers...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    color: AppColors.orangeSecondaryColor,
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                onChanged: (value) {
                                  setStateDialog(() {
                                    searchQuery = value;
                                    filteredOfficers = allOfficers
                                        .where((officer) =>
                                            (officer.name ?? '')
                                                .toLowerCase()
                                                .contains(searchQuery
                                                    .toLowerCase()) ||
                                            (officer.officerId ?? '')
                                                .toLowerCase()
                                                .contains(searchQuery
                                                    .toLowerCase()) ||
                                            (officer.phone ?? '')
                                                .toLowerCase()
                                                .contains(
                                                    searchQuery.toLowerCase()))
                                        .toList();
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Officers list
                            Expanded(
                              child: filteredOfficers.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            searchQuery.isEmpty
                                                ? Icons.person_off_rounded
                                                : Icons.search_off_rounded,
                                            color: Colors.grey[300],
                                            size: 48,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            searchQuery.isEmpty
                                                ? 'No officers available'
                                                : 'No officers found',
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: filteredOfficers.length,
                                      itemBuilder: (context, index) {
                                        final officer = filteredOfficers[index];
                                        final isSelected = selectedOfficers
                                            .any((o) => o.id == officer.id);

                                        return AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.orangeSecondaryColor
                                                    .withOpacity(0.1)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors
                                                      .orangeSecondaryColor
                                                      .withOpacity(0.3)
                                                  : Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                          child: CheckboxListTile(
                                            title: Row(
                                              children: [
                                                // Officer avatar
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    gradient: isSelected
                                                        ? AppColors
                                                            .orangeGradient
                                                        : LinearGradient(
                                                            colors: [
                                                              AppColors
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              AppColors
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.05),
                                                            ],
                                                          ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Icon(
                                                    Icons.person_rounded,
                                                    color: isSelected
                                                        ? Colors.white
                                                        : AppColors.primaryColor
                                                            .withOpacity(0.6),
                                                    size: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                // Officer name
                                                Expanded(
                                                  child: Text(
                                                    '${officer.officerId} -  ${officer.name ?? 'Unknown Officer'}  ',
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? AppColors
                                                              .orangeSecondaryColor
                                                          : AppColors
                                                              .primaryColor,
                                                      fontWeight: isSelected
                                                          ? FontWeight.w600
                                                          : FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: isSelected,
                                            activeColor:
                                                AppColors.orangeSecondaryColor,
                                            checkColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            onChanged: (checked) {
                                              setStateDialog(() {
                                                if (checked == true) {
                                                  selectedOfficers.add(officer);
                                                } else {
                                                  selectedOfficers.removeWhere(
                                                      (o) =>
                                                          o.id == officer.id);
                                                }
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),

                      // Action buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Row(
                          children: [
                            // Clear all button
                            if (selectedOfficers.isNotEmpty)
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    setStateDialog(() {
                                      selectedOfficers.clear();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear_all_rounded,
                                    size: 16,
                                  ),
                                  label: const Text('Clear All'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey[600],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                              ),

                            if (selectedOfficers.isNotEmpty)
                              const SizedBox(width: 12),

                            // Cancel button
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[600],
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // OK button
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: AppColors.buttonGraidentColour,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: onSubmitted,
                                  icon: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  label: const CustomText(
                                    text: 'Insert Officers',
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
