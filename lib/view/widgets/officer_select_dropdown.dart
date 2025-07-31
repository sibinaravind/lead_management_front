import 'package:flutter/material.dart';
import '../../res/style/colors/colors.dart';
import 'custom_text.dart';

class OfficerSelectDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;
  final bool isSplit;
  final String? hintText;
  final IconData? prefixIcon;
  final bool enableSearch;

  const OfficerSelectDropdown({
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
  State<OfficerSelectDropdown> createState() => _OfficerSelectDropdownState();
}

class _OfficerSelectDropdownState extends State<OfficerSelectDropdown>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    setState(() {
      _isOpen = true;
    });
    _animationController.forward();
    _createOverlay();
  }

  void _closeDropdown() {
    setState(() {
      _isOpen = false;
      _searchText = '';
    });
    _searchController.clear();
    _animationController.reverse();
    _removeOverlay();
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
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  alignment: Alignment.topCenter,
                  child: Opacity(
                    opacity: _animation.value,
                    child: _buildDropdownContent(),
                  ),
                );
              },
            ),
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
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final displayText = widget.isSplit ? item.split(',')[0] : item;
                final isSelected = widget.value == item;

                return InkWell(
                  onTap: () {
                    widget.onChanged(item);
                    _closeDropdown();
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
                              bottom: BorderSide(color: Colors.grey.shade200))
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
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
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
        onChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = widget.value != null && widget.value!.isNotEmpty
        ? (widget.isSplit ? widget.value!.split(',')[0] : widget.value!)
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
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
                onTap: _toggleDropdown,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isOpen
                          ? AppColors.blueSecondaryColor
                          : AppColors.textGrayColour.withOpacity(0.3),
                      width: _isOpen ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isOpen
                            ? AppColors.blueSecondaryColor.withOpacity(0.1)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: _isOpen ? 8 : 4,
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
                            gradient: AppColors.buttonGraidentColour,
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
                      AnimatedRotation(
                        turns: _isOpen ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.textGrayColour.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textGrayColour,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Validation message
            if (widget.isRequired &&
                (widget.value == null ||
                    widget.value!.isEmpty ||
                    widget.value == 'Choose...'))
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
      },
    );
  }
}

// Usage Example
class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedOfficer;

  final List<String> officers = [
    'John Smith, Badge: 12345',
    'Sarah Johnson, Badge: 23456',
    'Michael Brown, Badge: 34567',
    'Emily Davis, Badge: 45678',
    'David Wilson, Badge: 56789',
    'Lisa Anderson, Badge: 67890',
    'Robert Taylor, Badge: 78901',
    'Jessica Martinez, Badge: 89012',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Officer Selection'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.heroGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFEFF6FF),
              Color(0xFFF1F5F9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              OfficerSelectDropdown(
                label: 'Select Officer',
                value: selectedOfficer,
                items: officers,
                onChanged: (value) {
                  setState(() {
                    selectedOfficer = value;
                  });
                },
                isRequired: true,
                isSplit: true,
                hintText: 'Choose an officer...',
                prefixIcon: Icons.person_outline,
                enableSearch: true,
              ),
              const SizedBox(height: 20),
              if (selectedOfficer != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGraidentColour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Selected Officer:',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedOfficer!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
  }
}
