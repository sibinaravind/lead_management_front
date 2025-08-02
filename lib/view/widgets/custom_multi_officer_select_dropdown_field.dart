import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomMultiOfficerSelectDropdownField
    extends FormField<List<OfficerModel>> {
  CustomMultiOfficerSelectDropdownField({
    super.key,
    required String label,
    bool isRequired = false,
    required List<OfficerModel> selectedItems,
    required List<OfficerModel> items,
    required Function(List<OfficerModel>) onChanged,
    FormFieldSetter<List<OfficerModel>>? onSaved,
    FormFieldValidator<List<OfficerModel>>? validator,
  }) : super(
          initialValue: selectedItems,
          onSaved: onSaved,
          validator: validator ??
              (isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    }
                  : null),
          builder: (FormFieldState<List<OfficerModel>> state) {
            return _CustomMultiOfficerSelectDropdownFieldBody(
              label: label,
              isRequired: isRequired,
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

class _CustomMultiOfficerSelectDropdownFieldBody extends StatefulWidget {
  final String label;
  final bool isRequired;
  final List<OfficerModel> selectedItems;
  final List<OfficerModel> items;
  final Function(List<OfficerModel>) onChanged;
  final String? errorText;

  const _CustomMultiOfficerSelectDropdownFieldBody({
    required this.label,
    required this.isRequired,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  State<_CustomMultiOfficerSelectDropdownFieldBody> createState() =>
      _CustomMultiOfficerSelectDropdownFieldBodyState();
}

class _CustomMultiOfficerSelectDropdownFieldBodyState
    extends State<_CustomMultiOfficerSelectDropdownFieldBody>
    with SingleTickerProviderStateMixin {
  late List<OfficerModel> _selectedOfficers;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _selectedOfficers = List.from(widget.selectedItems);
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
    final List<OfficerModel> tempSelected = List.from(_selectedOfficers);
    List<OfficerModel> filteredItems = List.from(widget.items);
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
                              Icons.people_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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
                                    filteredItems = widget.items
                                        .where((item) => (item.name ?? '')
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
                              child: filteredItems.isEmpty
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
                                      itemCount: filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final officer = filteredItems[index];
                                        final isSelected = tempSelected
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
                                                    officer.name ??
                                                        'Unknown Officer',
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
                                                  tempSelected.add(officer);
                                                } else {
                                                  tempSelected.removeWhere(
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
                            if (tempSelected.isNotEmpty)
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    setStateDialog(() {
                                      tempSelected.clear();
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
                                    setState(() {
                                      _selectedOfficers =
                                          List.from(tempSelected);
                                    });
                                    widget.onChanged(_selectedOfficers);
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
    final selectedNames =
        _selectedOfficers.map((officer) => officer.name ?? 'Unknown').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enhanced label with better styling

        // Enhanced dropdown field
        GestureDetector(
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people_rounded,
                          color: selectedNames.isEmpty
                              ? Colors.grey[400]
                              : AppColors.orangeSecondaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: selectedNames.isEmpty
                              ? CustomText(
                                  text: 'Select officers...',
                                )
                              : Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: selectedNames.take(3).map((name) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.orangeGradient,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors
                                                .orangeSecondaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.person_rounded,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                                    ..addAll(selectedNames.length > 3
                                        ? [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                '+${selectedNames.length - 3}',
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
        ),

        // Error message with enhanced styling
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/officer/officer_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';

// class CustomMultiOfficerSelectDropdownField extends StatefulWidget {
//   final String label;
//   final List<OfficerModel> selectedItems; // store full officer objects
//   final List<OfficerModel> items; // all officer objects
//   final Function(List<OfficerModel>) onChanged;
//   final bool isRequired;

//   const CustomMultiOfficerSelectDropdownField({
//     super.key,
//     required this.label,
//     required this.selectedItems,
//     required this.items,
//     required this.onChanged,
//     this.isRequired = false,
//   });

//   @override
//   State<CustomMultiOfficerSelectDropdownField> createState() =>
//       _CustomMultiOfficerSelectDropdownFieldState();
// }

// class _CustomMultiOfficerSelectDropdownFieldState
//     extends State<CustomMultiOfficerSelectDropdownField> {
//   late List<OfficerModel> _selectedOfficers; // store full officers
//   bool _isTouched = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedOfficers = List.from(widget.selectedItems);
//   }

//   void _showMultiSelectDialog() async {
//     final List<OfficerModel> tempSelected = List.from(_selectedOfficers);
//     List<OfficerModel> filteredItems = List.from(widget.items);
//     String searchQuery = '';

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               backgroundColor: AppColors.whiteMainColor,
//               title: Text(widget.label),
//               content: SizedBox(
//                 width: 300,
//                 height: 350,
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: const InputDecoration(
//                         hintText: 'Search...',
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(horizontal: 8),
//                       ),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           searchQuery = value;
//                           filteredItems = widget.items
//                               .where((item) => (item.name ?? '')
//                                   .toLowerCase()
//                                   .contains(searchQuery.toLowerCase()))
//                               .toList();
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     Expanded(
//                       child: ListView(
//                         children: filteredItems.map((item) {
//                           final isSelected = tempSelected
//                               .any((officer) => officer.id == item.id);

//                           return CheckboxListTile(
//                             title: Text(item.name ?? ''),
//                             value: isSelected,
//                             onChanged: (checked) {
//                               setStateDialog(() {
//                                 if (checked == true) {
//                                   tempSelected.add(item);
//                                 } else {
//                                   tempSelected.removeWhere(
//                                       (officer) => officer.id == item.id);
//                                 }
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(
//                         AppColors.orangeSecondaryColor),
//                   ),
//                   onPressed: () {
//                     if (context.mounted) {
//                       setState(() {
//                         _selectedOfficers = List.from(tempSelected);
//                         _isTouched = true;
//                       });
//                       widget.onChanged(_selectedOfficers); // pass full objects
//                     }
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasError =
//         widget.isRequired && _isTouched && _selectedOfficers.isEmpty;

//     final selectedNames =
//         _selectedOfficers.map((officer) => officer.name ?? '').toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: widget.label,
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.onSurface,
//               fontSize: 16,
//             ),
//             children: widget.isRequired
//                 ? const [
//                     TextSpan(
//                       text: ' *',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ]
//                 : [],
//           ),
//         ),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () {
//             _showMultiSelectDialog();
//             setState(() => _isTouched = true);
//           },
//           child: SizedBox(
//             width: double.infinity,
//             child: InputDecorator(
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 errorText: hasError ? 'This field is required' : null,
//               ),
//               isEmpty: selectedNames.isEmpty,
//               child: selectedNames.isEmpty
//                   ? SizedBox(
//                       height: 24,
//                       child: Text(
//                         'Select...',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     )
//                   : Wrap(
//                       spacing: 6,
//                       runSpacing: 6,
//                       children: selectedNames
//                           .map((name) => Chip(label: Text(name)))
//                           .toList(),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
