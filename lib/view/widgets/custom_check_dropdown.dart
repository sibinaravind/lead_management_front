import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_gradient_button.dart';

class CustomCheckDropdown<T> extends FormField<List<T>> {
  CustomCheckDropdown({
    super.key,
    required String label,
    required List<T> items,
    required List<T> values,
    required ValueChanged<List<T>> onChanged,
    bool isRequired = false,
    bool showAllOption = false,
    FormFieldValidator<List<T>>? validator,
  }) : super(
          initialValue: values,
          validator: validator ??
              (isRequired
                  ? (v) =>
                      (v == null || v.isEmpty) ? 'This field is required' : null
                  : null),
          builder: (FormFieldState<List<T>> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label above the box
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: label,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isRequired)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () async {
                    final selected = await showDialog<List<T>>(
                      context: state.context,
                      builder: (context) {
                        final tempSelected = List<T>.from(state.value ?? []);

                        return StatefulBuilder(
                          builder: (context, setState) {
                            void handleAllChanged(bool? checked) {
                              setState(() {
                                if (checked == true) {
                                  tempSelected.clear();
                                  tempSelected.addAll(items);
                                } else {
                                  tempSelected.clear();
                                }
                              });
                            }

                            void handleItemChanged(T item, bool? checked) {
                              setState(() {
                                if (checked == true) {
                                  tempSelected.add(item);
                                } else {
                                  tempSelected.remove(item);
                                }
                              });
                            }

                            return AlertDialog(
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: label,
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                    ),
                                    if (isRequired)
                                      const TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                      ),
                                  ],
                                ),
                              ),
                              content: SizedBox(
                                width: 300,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    if (showAllOption)
                                      CheckboxListTile(
                                        value: tempSelected.length ==
                                                items.length &&
                                            items.isNotEmpty,
                                        tristate: false,
                                        title: const Text('All'),
                                        onChanged: (checked) =>
                                            handleAllChanged(checked),
                                      ),
                                    ...items.map((item) {
                                      final isChecked =
                                          tempSelected.contains(item);
                                      return CheckboxListTile(
                                        value: isChecked,
                                        title: Text(item.toString()),
                                        onChanged: (checked) =>
                                            handleItemChanged(item, checked),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, state.value),
                                  child: const Text('Cancel'),
                                ),
                                CustomGradientButton(
                                  text: 'Save',
                                  gradientColors: AppColors.greenGradient,
                                  onPressed: () {
                                    Navigator.pop(context, tempSelected);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                    if (selected != null) {
                      state.didChange(selected);
                      onChanged(selected);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      errorText: state.errorText,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                    child: Text(
                      (state.value == null || state.value!.isEmpty)
                          ? 'Select'
                          : state.value!.map((e) => e.toString()).join(', '),
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ],
            );
          },
        );
}



// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/custom_gradient_button.dart';

// class CutomCheckDropdown<T> extends FormField<List<T>> {
//   CutomCheckDropdown({
//     super.key,
//     required String label,
//     required List<T> items,
//     required List<T> values,
//     required ValueChanged<List<T>> onChanged,
//     bool isRequired = false,
//     bool showAllOption = false,
//     FormFieldValidator<List<T>>? validator,
//   }) : super(
//           initialValue: values,
//           validator: validator ??
//               (isRequired
//                   ? (v) =>
//                       (v == null || v.isEmpty) ? 'This field is required' : null
//                   : null),
//           builder: (FormFieldState<List<T>> state) {
//             return GestureDetector(
//               onTap: () async {
//                 final selected = await showDialog<List<T>>(
//                   context: state.context,
//                   builder: (context) {
//                     final tempSelected = List<T>.from(state.value ?? []);

//                     return StatefulBuilder(
//                       builder: (context, setState) {
//                         void handleAllChanged(bool? checked) {
//                           setState(() {
//                             if (checked == true) {
//                               tempSelected.clear();
//                               tempSelected.addAll(items);
//                             } else {
//                               tempSelected.clear();
//                             }
//                           });
//                         }

//                         void handleItemChanged(T item, bool? checked) {
//                           setState(() {
//                             if (checked == true) {
//                               tempSelected.add(item);
//                             } else {
//                               tempSelected.remove(item);
//                             }
//                           });
//                         }

//                         return Column(
//                           children: [
//                             RichText(
//                                 text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: label,
//                                   style: const TextStyle(
//                                       color: Colors.black87, fontSize: 18),
//                                 ),
//                                 if (isRequired)
//                                   const TextSpan(
//                                     text: ' *',
//                                     style: TextStyle(
//                                         color: Colors.red, fontSize: 18),
//                                   ),
//                               ],
//                             )),
//                             AlertDialog(
//                               title: RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: label,
//                                       style: const TextStyle(
//                                           color: Colors.black87, fontSize: 18),
//                                     ),
//                                     if (isRequired)
//                                       const TextSpan(
//                                         text: ' *',
//                                         style: TextStyle(
//                                             color: Colors.red, fontSize: 18),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               content: SizedBox(
//                                 width: 300,
//                                 child: ListView(
//                                   shrinkWrap: true,
//                                   children: [
//                                     if (showAllOption)
//                                       CheckboxListTile(
//                                         value: tempSelected.length ==
//                                                 items.length &&
//                                             items.isNotEmpty,
//                                         tristate: false,
//                                         title: const Text('All'),
//                                         onChanged: (checked) =>
//                                             handleAllChanged(checked),
//                                       ),
//                                     ...items.map((item) {
//                                       final isChecked =
//                                           tempSelected.contains(item);
//                                       return CheckboxListTile(
//                                         value: isChecked,
//                                         title: Row(
//                                           children: [
//                                             Expanded(
//                                                 child: Text(item.toString())),
//                                           ],
//                                         ),
//                                         onChanged: (checked) =>
//                                             handleItemChanged(item, checked),
//                                       );
//                                     }).toList(),
//                                   ],
//                                 ),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () =>
//                                       Navigator.pop(context, state.value),
//                                   child: const Text('Cancel'),
//                                 ),
//                                 CustomGradientButton(
//                                   text: 'Save',
//                                   gradientColors: AppColors.greenGradient,
//                                   onPressed: () {
//                                     Navigator.pop(
//                                       context,
//                                       tempSelected,
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 );
//                 if (selected != null) {
//                   state.didChange(selected);
//                   onChanged(selected);
//                 }
//               },
//               child: InputDecorator(
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   errorText: state.errorText,
//                   border: const OutlineInputBorder(),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: label,
//                             style: const TextStyle(color: Colors.black87),
//                           ),
//                           if (isRequired)
//                             const TextSpan(
//                               text: ' *',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       (state.value == null || state.value!.isEmpty)
//                           ? 'Select'
//                           : state.value!.length == items.length
//                               ? 'All'
//                               : state.value!
//                                   .map((e) => e.toString())
//                                   .join(', '),
//                       style: const TextStyle(color: Colors.black87),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
// }