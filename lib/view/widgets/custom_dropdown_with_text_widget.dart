import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

import 'custom_action_button.dart';

class CustomDropdownWithText extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;
  final String label;

  const CustomDropdownWithText({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.label = 'Select Steps',
  });

  @override
  State<CustomDropdownWithText> createState() =>
      _CheckedMultiSelectDropdownState();
}

class _CheckedMultiSelectDropdownState extends State<CustomDropdownWithText> {
  late List<String> _options;
  late List<String> _selected;
  final TextEditingController _newItemController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _options = List.from(widget.options);
    _selected = List.from(widget.selectedValues);

    // Add any selected values not present in options to options
    for (final value in _selected) {
      if (!_options.contains(value)) {
        _options.add(value);
      }
    }
  }

  @override
  void didUpdateWidget(covariant CustomDropdownWithText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _options = List.from(widget.options);
    }

    if (oldWidget.selectedValues != widget.selectedValues) {
      _selected = List.from(widget.selectedValues);
    }
  }

  void _openDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: 420,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: CustomText(
                              text: widget.label,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _options.length,
                        itemBuilder: (_, index) {
                          final item = _options[index];
                          return CheckboxListTile(
                            activeColor: AppColors.darkOrangeColour,
                            value: _selected.contains(item),
                            title: CustomText(text: item, fontSize: 13),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (_) {
                              setModalState(() {
                                if (_selected.contains(item)) {
                                  _selected.remove(item);
                                } else {
                                  _selected.add(item);
                                }
                              });

                              /// notify parent
                              widget.onChanged(_selected);
                            },
                          );
                        },
                      ),
                    ),

                    /// ➕ ADD NEW ITEM
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _newItemController,
                              decoration: InputDecoration(
                                hintText: 'Add new item',
                                hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => _addNewItem(setModalState),
                                ),
                              ),
                              onSubmitted: (_) => _addNewItem(setModalState),
                            ),
                          ),
                          // const SizedBox(width: 8),
                          // SizedBox(
                          //   width: 70,
                          //   height: 48,
                          //   child: CustomActionButton(
                          //     text: '+',
                          //     textSize: 20,
                          //     // icon: Icons.add,
                          //     onPressed: () => _addNewItem(setModalState),
                          //     isFilled: true,
                          //     gradient: AppColors.buttonGraidentColour,
                          //     textColor: Colors.blue.shade600,
                          //     // borderColor: Colors.blue.shade100,
                          //   ),
                          // ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 70,
                            height: 48,
                            child: CustomActionButton(
                              text: 'Done',
                              textSize: 12,
                              // icon: Icons.add,
                              onPressed: () => Navigator.of(context).pop(),
                              isFilled: true,
                              gradient: AppColors.buttonGraidentColour,
                              textColor: Colors.blue.shade600,
                              // borderColor: Colors.blue.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _addNewItem(StateSetter setModalState) {
    final text = _newItemController.text.trim();
    if (text.isEmpty || _options.contains(text)) return;

    setModalState(() {
      _options.add(text);
      _selected.add(text);
    });

    _newItemController.clear();
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDropdown(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.label,
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _selected.isEmpty
                      ? Text(
                          widget.label,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      : Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _selected
                              .map(
                                (item) => Chip(
                                  label: Text(item),
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              )
                              .toList(),
                        ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _newItemController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class CustomDropdownWithText extends StatefulWidget {
//   final List<String> options;
//   final List<String> selectedValues;
//   final ValueChanged<List<String>> onChanged;
//   final String hint;

//   const CustomDropdownWithText({
//     super.key,
//     required this.options,
//     required this.selectedValues,
//     required this.onChanged,
//     this.hint = 'Select steps',
//   });

//   @override
//   State<CustomDropdownWithText> createState() =>
//       _CheckedMultiSelectDropdownState();
// }

// class _CheckedMultiSelectDropdownState
//     extends State<CustomDropdownWithText> {
//   late List<String> _options;
//   late List<String> _selected;
//   final TextEditingController _newItemController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _options = List.from(widget.options);
//     _selected = List.from(widget.selectedValues);
//   }

//   void _toggleItem(String value) {
//     setState(() {
//       if (_selected.contains(value)) {
//         _selected.remove(value);
//       } else {
//         _selected.add(value);
//       }
//     });
//     widget.onChanged(_selected);
//   }

//   void _addNewItem() {
//     final text = _newItemController.text.trim();
//     if (text.isEmpty || _options.contains(text)) return;

//     setState(() {
//       _options.add(text);
//       _selected.add(text);
//     });

//     _newItemController.clear();
//     widget.onChanged(_selected);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _openDropdown(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade400),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: _selected.isEmpty
//                   ? Text(
//                       widget.hint,
//                       style: TextStyle(color: Colors.grey.shade600),
//                     )
//                   : Wrap(
//                       spacing: 6,
//                       runSpacing: 6,
//                       children: _selected
//                           .map(
//                             (e) => Chip(
//                               label: Text(e),
//                               backgroundColor:
//                                   AppColors.primaryColor.withOpacity(0.12),
//                             ),
//                           )
//                           .toList(),
//                     ),
//             ),
//             const Icon(Icons.arrow_drop_down),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openDropdown(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: SizedBox(
//             height: 420,
//             child: Column(
//               children: [
//                 const SizedBox(height: 12),
//                 Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const CustomText(
//                   text: 'Select Steps',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const Divider(),

//                 /// OPTIONS
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _options.length,
//                     itemBuilder: (_, index) {
//                       final item = _options[index];
//                       return CheckboxListTile(
//                         value: _selected.contains(item),
//                         title: Text(item),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         onChanged: (_) => _toggleItem(item),
//                       );
//                     },
//                   ),
//                 ),

//                 /// ADD NEW ITEM
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _newItemController,
//                           decoration: const InputDecoration(
//                             hintText: 'Add new step',
//                             border: OutlineInputBorder(),
//                           ),
//                           onSubmitted: (_) => _addNewItem(),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: _addNewItem,
//                         child: const Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _newItemController.dispose();
//     super.dispose();
//   }
// }

// // step_builder_widget.dart
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class CustomDropdownWithText extends StatefulWidget {
//   final List<String> values;
//   final ValueChanged<List<String>> onChanged;
//   final String label;
//   final List<String>? suggestions;

//   const CustomDropdownWithText({
//     super.key,
//     required this.values,
//     required this.onChanged,
//     this.label = 'Steps',
//     this.suggestions,
//   });

//   @override
//   State<CustomDropdownWithText> createState() => _MultiTextInputFieldState();
// }

// class _MultiTextInputFieldState extends State<CustomDropdownWithText> {
//   final TextEditingController _controller = TextEditingController();
//   late List<String> _items;

//   @override
//   void initState() {
//     super.initState();
//     _items = List.from(widget.values);
//   }

//   void _addItem(String value) {
//     final text = value.trim();
//     if (text.isEmpty || _items.contains(text)) return;

//     setState(() {
//       _items.add(text);
//     });
//     _controller.clear();
//     widget.onChanged(_items);
//   }

//   void _removeItem(String value) {
//     setState(() {
//       _items.remove(value);
//     });
//     widget.onChanged(_items);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: widget.label,
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//         ),
//         const SizedBox(height: 8),

//         /// Text box
//         TextField(
//           controller: _controller,
//           onSubmitted: _addItem,
//           decoration: InputDecoration(
//             hintText: 'Type and press Enter',
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () => _addItem(_controller.text),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),

//         /// Chips
//         if (_items.isNotEmpty) ...[
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: _items
//                 .map(
//                   (item) => Chip(
//                     label: Text(item),
//                     deleteIcon: const Icon(Icons.close, size: 18),
//                     onDeleted: () => _removeItem(item),
//                     backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],

//         /// Suggestions
//         if (widget.suggestions != null && widget.suggestions!.isNotEmpty) ...[
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             children: widget.suggestions!
//                 .where((s) => !_items.contains(s))
//                 .map(
//                   (s) => ActionChip(
//                     label: Text(s),
//                     onPressed: () => _addItem(s),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ],
//     );
//   }
// }
