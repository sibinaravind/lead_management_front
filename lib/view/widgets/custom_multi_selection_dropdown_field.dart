import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomMultiSelectDropdownField extends FormField<List<String>> {
  CustomMultiSelectDropdownField({
    super.key,
    required String label,
    bool isRequired = false,
    bool isSplit = false,
    required List<String> selectedItems,
    required List<String> items,
    required Function(List<String>) onChanged,
    super.onSaved,
    FormFieldValidator<List<String>>? validator,
  }) : super(
          initialValue: selectedItems,
          validator: validator ??
              (isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    }
                  : null),
          builder: (FormFieldState<List<String>> state) {
            return _CustomMultiSelectDropdownFieldBody(
              label: label,
              isRequired: isRequired,
              isSplit: isSplit,
              items: items,
              selectedItems: state.value ?? [],
              onChanged: (values) {
                state.didChange(values);
                onChanged(values);
              },
              errorText: state.errorText,
            );
          },
        );
}

class _CustomMultiSelectDropdownFieldBody extends StatefulWidget {
  final String label;
  final bool isRequired;
  final bool isSplit;
  final List<String> selectedItems;
  final List<String> items;
  final Function(List<String>) onChanged;
  final String? errorText;

  const _CustomMultiSelectDropdownFieldBody({
    required this.label,
    required this.isRequired,
    required this.isSplit,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  State<_CustomMultiSelectDropdownFieldBody> createState() =>
      _CustomMultiSelectDropdownFieldBodyState();
}

class _CustomMultiSelectDropdownFieldBodyState
    extends State<_CustomMultiSelectDropdownFieldBody>
    with SingleTickerProviderStateMixin {
  late List<String> _selectedItems;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showMultiSelectDialog() async {
    final List<String> selectedIds = [];
    final List<String> tempSelected = List.from(_selectedItems);
    List<String> filteredItems = List.from(widget.items);
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
                width: 300,
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
                              Icons.checklist_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomText(
                                text: widget.label,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            if (tempSelected.isNotEmpty)
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
                                  '${tempSelected.length}',
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
                            // Search field with enhanced styling
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
                                  hintText: 'Search items...',
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
                                    filteredItems = widget.items
                                        .where((item) => item
                                            .toLowerCase()
                                            .contains(
                                                searchQuery.toLowerCase()))
                                        .toList();
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Items list
                            Expanded(
                              child: filteredItems.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_off_rounded,
                                            color: Colors.grey[300],
                                            size: 48,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'No items found',
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final item = filteredItems[index];
                                        final isSelected =
                                            tempSelected.contains(item);

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
                                            title: Text(
                                              item.split(",").first,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? AppColors
                                                        .orangeSecondaryColor
                                                    : AppColors.primaryColor,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w500,
                                                fontSize: 14,
                                              ),
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
                                                  tempSelected.add(item);
                                                  widget.isSplit
                                                      ? selectedIds.add(
                                                          item.split(",")[1])
                                                      : selectedIds.add(item);
                                                } else {
                                                  widget.isSplit
                                                      ? selectedIds.remove(
                                                          item.split(",")[1])
                                                      : selectedIds
                                                          .remove(item);
                                                  tempSelected.remove(item);
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
                            if (tempSelected.isNotEmpty)
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    setStateDialog(() {
                                      tempSelected.clear();
                                      selectedIds.clear();
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

                            if (tempSelected.isNotEmpty)
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
                                  onPressed: () {
                                    setState(() => _selectedItems =
                                        List.from(tempSelected));
                                    widget.onChanged(selectedIds);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  label: const Text(
                                    'Apply',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: _showMultiSelectDialog,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.errorText != null
                      ? Colors.red.withOpacity(0.6)
                      : AppColors.primaryColor.withOpacity(0.5),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey[50]!,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.checklist_rounded,
                      color: _selectedItems.isEmpty
                          ? Colors.grey[400]
                          : AppColors.orangeSecondaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _selectedItems.isEmpty
                          ? CustomText(
                              text: 'Select ${widget.label.toLowerCase()}...',
                            )
                          : Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: _selectedItems.take(3).map((item) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.orangeGradient,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.orangeSecondaryColor
                                            .withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    item.split(",")[0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList()
                                ..addAll(_selectedItems.length > 3
                                    ? [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            '+${_selectedItems.length - 3}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ]
                                    : []),
                            ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey[400],
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
