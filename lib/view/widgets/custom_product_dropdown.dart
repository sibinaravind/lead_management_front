import 'package:flutter/material.dart';
import '../../model/product/product_model.dart';
import '../../utils/style/colors/colors.dart';

class CustomProductDropDown extends StatefulWidget {
  final String label;
  final ProductModel? selectedProduct;
  final List<ProductModel> products;
  final Function(ProductModel?) onChanged;
  final bool isRequired;
  final String? hintText;
  final bool enableSearch;

  const CustomProductDropDown({
    super.key,
    required this.label,
    required this.products,
    required this.selectedProduct,
    required this.onChanged,
    this.isRequired = false,
    this.hintText,
    this.enableSearch = true,
  });

  @override
  State<CustomProductDropDown> createState() => _CustomProductDropDownState();
}

class _CustomProductDropDownState extends State<CustomProductDropDown> {
  ProductModel? _selectedProduct;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _fieldFocus = FocusNode();
  final FocusNode _searchFocus = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();

  bool _isOpen = false;
  String searchText = '';

  @override
  void initState() {
    super.initState();

    _selectedProduct = widget.products.firstWhere(
      (e) => e.productId == widget.selectedProduct?.productId,
      orElse: () => ProductModel(),
    );

    _fieldFocus.addListener(_handleFocusChange);

    _searchController.addListener(() {
      setState(() => searchText = _searchController.text);
      _overlayEntry?.markNeedsBuild();
    });
  }

  @override
  void dispose() {
    _fieldFocus.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomProductDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedProduct != oldWidget.selectedProduct ||
        widget.products != oldWidget.products) {
      _selectedProduct = widget.products.firstWhere(
        (e) => e.productId == widget.selectedProduct?.productId,
        orElse: () => ProductModel(),
      );
      setState(() {});
    }
  }

  void _handleFocusChange() {
    if (_fieldFocus.hasFocus && !_isOpen) {
      _openDropdown();
    } else if (!_searchFocus.hasFocus) {
      _closeDropdown();
    }
  }

  void _openDropdown() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);

    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _searchController.clear();
    searchText = '';
    _overlayEntry?.remove();
    _overlayEntry = null;

    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlay() {
    final box = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final size = box.size;

    return OverlayEntry(
      builder: (_) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 6),
          showWhenUnlinked: false,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(10),
            child: _dropdownContent(),
          ),
        ),
      ),
    );
  }

  Widget _dropdownContent() {
    List<ProductModel> filtered = widget.products.where((p) {
      String combined = "${p.name} ${p.productId}".toLowerCase();
      return combined.contains(searchText.toLowerCase());
    }).toList();

    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          if (widget.enableSearch) _searchBox(),
          Flexible(
            child: filtered.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("No matching products found"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final product = filtered[i];
                      bool selected =
                          product.productId == _selectedProduct?.productId;

                      return InkWell(
                        onTap: () {
                          setState(() => _selectedProduct = product);
                          widget.onChanged(product);
                          _closeDropdown();
                          _fieldFocus.unfocus();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.blue.withOpacity(0.08)
                                : Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: i == filtered.length - 1
                                    ? Colors.transparent
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${product.name} - ${product.productId}",
                                      style: TextStyle(
                                        fontWeight: selected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: selected
                                            ? Colors.blue
                                            : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "Price : ${product.sellingPrice} ",
                                    ),
                                  ],
                                ),
                              ),
                              if (selected)
                                const Icon(Icons.check,
                                    size: 16, color: Colors.blue),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocus,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 20),
          hintText: "Search product...",
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black26),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String labelText = (_selectedProduct?.productId == null)
        ? widget.hintText ?? "Choose product..."
        : "${_selectedProduct?.name} - ${_selectedProduct?.productId}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABEL
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              if (widget.isRequired)
                const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // INPUT FIELD
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _dropdownKey,
            onTap: () {
              _isOpen ? _fieldFocus.unfocus() : _fieldFocus.requestFocus();
            },
            child: Focus(
              focusNode: _fieldFocus,
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isOpen
                        ? AppColors.greenSecondaryColor
                        : Colors.black87,
                    width: _isOpen ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        labelText,
                        style: TextStyle(
                          color: (_selectedProduct?.productId == null)
                              ? Colors.black54
                              : Colors.black87,
                          fontWeight: (_selectedProduct?.productId == null)
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      _isOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        if (widget.isRequired && _selectedProduct?.productId == null)
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              "This field is required",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
