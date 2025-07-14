
import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';

class CustomMultiSelectDropdownField extends StatefulWidget {
  final String label;
  final List<String> selectedItems;
  final List<String> items;
  final Function(List<String>) onChanged;
  final bool isRequired;

  const CustomMultiSelectDropdownField({
    super.key,
    required this.label,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  State<CustomMultiSelectDropdownField> createState() =>
      _CustomMultiSelectDropdownFieldState();
}

class _CustomMultiSelectDropdownFieldState
    extends State<CustomMultiSelectDropdownField> {
  late List<String> _selectedItems;
  bool _isTouched = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _showMultiSelectDialog() async {
    final List<String> selecIds = [];
    final List<String> tempSelected = List.from(_selectedItems);
    List<String> filteredItems = List.from(widget.items);
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
                width: double.maxFinite,
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                              .where((item) => item
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
                          final itemOne = item.split(",");
                          final isSelected = tempSelected.contains(item);
                          return CheckboxListTile(
                            title: Text(item.split(",").first),
                            value: isSelected,
                            onChanged: (checked) {
                              setStateDialog(() {
                                if (checked == true) {
                                  tempSelected.add(item);
                                  selecIds.add(item.split(",")[1]);
                                } else {
                                  selecIds.remove(item.split(",")[1]);
                                  tempSelected.remove(item);
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                   if(context.mounted) {
                     setState(() {
                       _selectedItems = List.from(tempSelected);
                       // _selectedItems = List.from(selecIds);
                       _isTouched = true;
                     });
                   }
                    widget.onChanged(selecIds);
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
    final hasError = widget.isRequired && _isTouched && _selectedItems.isEmpty;

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
            setState(() {
              _isTouched = true;
            });
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
              isEmpty: _selectedItems.isEmpty,
              child: _selectedItems.isEmpty
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
                children: _selectedItems
                    .map((item) => Chip(label: Text(item.split(",")[0])))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}