import 'package:flutter/material.dart';
import '../../utils/style/colors/colors.dart';
import 'custom_text.dart';

class CustomOfficerDropDown extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;
  final bool isSplit;
  final String? hintText;
  final IconData? prefixIcon;
  final bool enableSearch;

  const CustomOfficerDropDown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.isSplit = false,
    this.hintText,
    this.prefixIcon,
    this.enableSearch = true,
  });

  @override
  State<CustomOfficerDropDown> createState() => _CustomOfficerDropDownState();
}

class _CustomOfficerDropDownState extends State<CustomOfficerDropDown> {
  String? _selectedValue;
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _searchFocusNode =
      FocusNode(); // Separate focus node for search
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
    _focusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchChanged);
    // Add listener for search focus node
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchController.removeListener(_onSearchChanged);
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;
    });
    // Rebuild the overlay with filtered items
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_isDropdownOpen) {
      _openDropdown();
    } else if (!_focusNode.hasFocus &&
        !_searchFocusNode.hasFocus &&
        _isDropdownOpen) {
      // Only close if neither the dropdown nor search field has focus
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!_searchFocusNode.hasFocus && !_focusNode.hasFocus) {
          _closeDropdown();
        }
      });
    }
  }

  void _onSearchFocusChange() {
    // Keep dropdown open when search field gains focus
    if (_searchFocusNode.hasFocus) {
      _isDropdownOpen = true;
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  void _openDropdown() {
    if (_overlayEntry != null) return;
    _isDropdownOpen = true;
    _createOverlay();
  }

  void _closeDropdown() {
    _searchText = '';
    _searchController.clear();
    _removeOverlay();
    _searchFocusNode.unfocus();
  }

  void _createOverlay() {
    final RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: _buildDropdownContent(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildDropdownContent() {
    final filteredItems = widget.items.where((item) {
      final displayText = widget.isSplit ? item.split(',')[0] : item;
      return displayText.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return Container(
      constraints: const BoxConstraints(maxHeight: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textGrayColour.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.enableSearch) _buildSearchField(),
          Flexible(
            child: filteredItems.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No matching officers found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final displayText =
                          widget.isSplit ? item.split(',')[0] : item;
                      final isSelected = _selectedValue == item;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedValue = item;
                          });
                          widget.onChanged(item);
                          _closeDropdown();
                          _focusNode.unfocus();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.blueSecondaryColor.withOpacity(0.1)
                                : null,
                            border: index < filteredItems.length - 1
                                ? Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200))
                                : null,
                          ),
                          child: Row(
                            children: [
                              if (widget.prefixIcon != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.buttonGraidentColour,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    widget.prefixIcon,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              Expanded(
                                child: CustomText(
                                  text: displayText,
                                  color: isSelected
                                      ? AppColors.blueSecondaryColor
                                      : AppColors.primaryColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.buttonGraidentColour,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode, // Use the separate focus node
        autofocus: false, // Changed to false to prevent immediate focus
        decoration: InputDecoration(
          hintText: 'Search officers...',
          hintStyle: TextStyle(color: AppColors.textGrayColour),
          prefixIcon: Icon(Icons.search, color: AppColors.textGrayColour),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.textGrayColour.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.blueSecondaryColor),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        style: const TextStyle(fontSize: 14),
        onTap: () {
          // Ensure dropdown stays open when search field is tapped
          _isDropdownOpen = true;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = _selectedValue != null && _selectedValue!.isNotEmpty
        ? (widget.isSplit ? _selectedValue!.split(',')[0] : _selectedValue!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Dropdown Field
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _dropdownKey,
            onTap: () {
              if (!_isDropdownOpen) {
                _focusNode.requestFocus();
              } else {
                _focusNode.unfocus();
              }
            },
            child: Focus(
              focusNode: _focusNode,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isDropdownOpen
                        ? AppColors.blueSecondaryColor
                        : AppColors.textGrayColour.withOpacity(0.3),
                    width: _isDropdownOpen ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isDropdownOpen
                          ? AppColors.blueSecondaryColor.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isDropdownOpen ? 8 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: displayValue != null ? null : Colors.grey,
                          gradient: displayValue != null
                              ? AppColors.buttonGraidentColour
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          widget.prefixIcon,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: CustomText(
                        text: displayValue ??
                            widget.hintText ??
                            'Choose an officer...',
                        color: displayValue != null
                            ? AppColors.primaryColor
                            : AppColors.textGrayColour,
                        fontSize: 16,
                        fontWeight: displayValue != null
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.textGrayColour.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        _isDropdownOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.textGrayColour,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Validation message
        if (widget.isRequired &&
            (_selectedValue == null ||
                _selectedValue!.isEmpty ||
                _selectedValue == 'Choose...'))
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: const Text(
              'This field is required',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../utils/style/colors/colors.dart';
// import 'custom_text.dart';

// class CustomOfficerDropDown extends StatefulWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final Function(String?) onChanged;
//   final bool isRequired;
//   final bool isSplit;
//   final String? hintText;
//   final IconData? prefixIcon;
//   final bool enableSearch;

//   const CustomOfficerDropDown({
//     super.key,
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.isRequired = false,
//     this.isSplit = false,
//     this.hintText,
//     this.prefixIcon,
//     this.enableSearch = true,
//   });

//   @override
//   State<CustomOfficerDropDown> createState() => _CustomOfficerDropDownState();
// }

// class _CustomOfficerDropDownState extends State<CustomOfficerDropDown> {
//   String? _selectedValue;
//   String _searchText = '';
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   OverlayEntry? _overlayEntry;
//   final LayerLink _layerLink = LayerLink();
//   final GlobalKey _dropdownKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.value;
//     _focusNode.addListener(_onFocusChange);
//   }

//   @override
//   void dispose() {
//     _focusNode.removeListener(_onFocusChange);
//     _focusNode.dispose();
//     _searchController.dispose();
//     _removeOverlay();
//     super.dispose();
//   }

//   void _onFocusChange() {
//     if (_focusNode.hasFocus) {
//       _openDropdown();
//     } else {
//       _closeDropdown();
//     }
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   void _openDropdown() {
//     _createOverlay();
//   }

//   void _closeDropdown() {
//     _searchText = '';
//     _searchController.clear();
//     _removeOverlay();
//   }

//   void _createOverlay() {
//     final RenderBox renderBox =
//         _dropdownKey.currentContext!.findRenderObject() as RenderBox;
//     final size = renderBox.size;

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: size.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(0, size.height + 4),
//           child: Material(
//             elevation: 8,
//             borderRadius: BorderRadius.circular(12),
//             child: _buildDropdownContent(),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   Widget _buildDropdownContent() {
//     final filteredItems = widget.items.where((item) {
//       final displayText = widget.isSplit ? item.split(',')[0] : item;
//       return displayText.toLowerCase().contains(_searchText.toLowerCase());
//     }).toList();

//     return Container(
//       constraints: const BoxConstraints(maxHeight: 250),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.textGrayColour.withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (widget.enableSearch) _buildSearchField(),
//           Flexible(
//             child: ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.zero,
//               itemCount: filteredItems.length,
//               itemBuilder: (context, index) {
//                 final item = filteredItems[index];
//                 final displayText = widget.isSplit ? item.split(',')[0] : item;
//                 final isSelected = _selectedValue == item;

//                 return InkWell(
//                   onTap: () {
//                     setState(() {
//                       _selectedValue = item;
//                     });
//                     widget.onChanged(item);
//                     _closeDropdown();
//                     _focusNode.unfocus();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? AppColors.blueSecondaryColor.withOpacity(0.1)
//                           : null,
//                       border: index < filteredItems.length - 1
//                           ? Border(
//                               bottom: BorderSide(color: Colors.grey.shade200))
//                           : null,
//                     ),
//                     child: Row(
//                       children: [
//                         if (widget.prefixIcon != null) ...[
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               gradient: AppColors.buttonGraidentColour,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Icon(
//                               widget.prefixIcon,
//                               size: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                         ],
//                         Expanded(
//                           child: CustomText(
//                             text: displayText,
//                             color: isSelected
//                                 ? AppColors.blueSecondaryColor
//                                 : AppColors.primaryColor,
//                             fontWeight:
//                                 isSelected ? FontWeight.w600 : FontWeight.w400,
//                           ),
//                         ),
//                         if (isSelected)
//                           Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               gradient: AppColors.buttonGraidentColour,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.check,
//                               size: 12,
//                               color: Colors.white,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.shade200),
//         ),
//       ),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) {
//           setState(() {
//             _searchText = value;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search officers...',
//           hintStyle: TextStyle(color: AppColors.textGrayColour),
//           prefixIcon: Icon(Icons.search, color: AppColors.textGrayColour),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide:
//                 BorderSide(color: AppColors.textGrayColour.withOpacity(0.3)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: AppColors.blueSecondaryColor),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           filled: true,
//           fillColor: Colors.grey.shade50,
//         ),
//         style: const TextStyle(fontSize: 14),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final displayValue = _selectedValue != null && _selectedValue!.isNotEmpty
//         ? (widget.isSplit ? _selectedValue!.split(',')[0] : _selectedValue!)
//         : null;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Label
//         Container(
//           margin: const EdgeInsets.only(bottom: 8),
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: widget.label,
//                   style: const TextStyle(
//                     color: AppColors.primaryColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (widget.isRequired)
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),

//         // Dropdown Field
//         CompositedTransformTarget(
//           link: _layerLink,
//           child: GestureDetector(
//             key: _dropdownKey,
//             onTap: () {
//               if (_overlayEntry == null) {
//                 _focusNode.requestFocus();
//               } else {
//                 _focusNode.unfocus();
//               }
//             },
//             child: Focus(
//               focusNode: _focusNode,
//               child: Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: _overlayEntry != null
//                         ? AppColors.blueSecondaryColor
//                         : AppColors.textGrayColour.withOpacity(0.3),
//                     width: _overlayEntry != null ? 2 : 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: _overlayEntry != null
//                           ? AppColors.blueSecondaryColor.withOpacity(0.1)
//                           : Colors.black.withOpacity(0.05),
//                       blurRadius: _overlayEntry != null ? 8 : 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     if (widget.prefixIcon != null) ...[
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           gradient: AppColors.buttonGraidentColour,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(
//                           widget.prefixIcon,
//                           size: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                     ],
//                     Expanded(
//                       child: CustomText(
//                         text: displayValue ??
//                             widget.hintText ??
//                             'Choose an officer...',
//                         color: displayValue != null
//                             ? AppColors.primaryColor
//                             : AppColors.textGrayColour,
//                         fontSize: 16,
//                         fontWeight: displayValue != null
//                             ? FontWeight.w500
//                             : FontWeight.w400,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: AppColors.textGrayColour.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: AppColors.textGrayColour,
//                         size: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // Validation message
//         if (widget.isRequired &&
//             (_selectedValue == null ||
//                 _selectedValue!.isEmpty ||
//                 _selectedValue == 'Choose...'))
//           Container(
//             margin: const EdgeInsets.only(top: 6),
//             child: const Text(
//               'This field is required',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
