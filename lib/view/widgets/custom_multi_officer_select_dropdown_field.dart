import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';

class CustomMultiOfficerSelectDropdownField extends StatefulWidget {
  final String label;
  final List<String> selectedItems; // should store IDs
  final List<OfficerModel> items; // full officer objects
  final Function(List<String>) onChanged;
  final bool isRequired;

  const CustomMultiOfficerSelectDropdownField({
    super.key,
    required this.label,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  State<CustomMultiOfficerSelectDropdownField> createState() =>
      _CustomMultiOfficerSelectDropdownFieldState();
}

class _CustomMultiOfficerSelectDropdownFieldState
    extends State<CustomMultiOfficerSelectDropdownField> {
  late List<String> _selectedIds; // store IDs
  bool _isTouched = false;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedItems); // copy IDs
  }

  void _showMultiSelectDialog() async {
    final List<String> tempSelectedIds = List.from(_selectedIds);
    List<OfficerModel> filteredItems = List.from(widget.items);
    String searchQuery = '';

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppColors.whiteMainColor,
              title: Text(widget.label),
              content: SizedBox(
                width: 300,
                height: 350,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (value) {
                        setStateDialog(() {
                          searchQuery = value;
                          filteredItems = widget.items
                              .where((item) => (item.name ?? '')
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: filteredItems.map((item) {
                          final String officerId = item.id ?? '';
                          final isSelected =
                              tempSelectedIds.contains(officerId);

                          return CheckboxListTile(
                            title: Text(item.name ?? ''),
                            value: isSelected,
                            onChanged: (checked) {
                              setStateDialog(() {
                                if (checked == true) {
                                  tempSelectedIds.add(officerId);
                                } else {
                                  tempSelectedIds.remove(officerId);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        AppColors.orangeSecondaryColor),
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      setState(() {
                        _selectedIds = List.from(tempSelectedIds);
                        _isTouched = true;
                      });
                      widget.onChanged(_selectedIds); // pass IDs
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.isRequired && _isTouched && _selectedIds.isEmpty;

    // Convert selected IDs to names for display
    final selectedNames = _selectedIds
        .map(
            (id) => widget.items.firstWhere((item) => item.id == id).name ?? '')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
            children: widget.isRequired
                ? const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _showMultiSelectDialog();
            setState(() => _isTouched = true);
          },
          child: SizedBox(
            width: double.infinity,
            child: InputDecorator(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                errorText: hasError ? 'This field is required' : null,
              ),
              isEmpty: selectedNames.isEmpty,
              child: selectedNames.isEmpty
                  ? SizedBox(
                      height: 24,
                      child: Text(
                        'Select...',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: selectedNames
                          .map((name) => Chip(label: Text(name)))
                          .toList(),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
