// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:overseas_front_end/model/app_configs/config_model.dart';
// import 'package:overseas_front_end/view/widgets/custom_multi_selection_dropdown_field.dart';
// import 'package:provider/provider.dart';

// import '../../../../controller/lead/round_robin_provider.dart';
// import '../../../../controller/officers_controller/officers_controller.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_action_button.dart';
// import '../../../widgets/custom_snackbar.dart';
// import '../../../widgets/custom_text.dart';
// import '../../../widgets/custom_text_form_field.dart';
// import '../../../widgets/custom_toast.dart';

// class AddOfficerDialog extends StatefulWidget {
//   final String roundRobinId;

//   const AddOfficerDialog(
//       {super.key,
//       // required this.category,
//       required this.roundRobinId});

//   @override
//   State<AddOfficerDialog> createState() => _AddOfficerDialogState();
// }

// class _AddOfficerDialogState extends State<AddOfficerDialog> {
//   @override
//   void initState() {
//     Provider.of<OfficersControllerProvider>(context, listen: false)
//         .fetchOfficersList(context);
//     // TODO: implement initState
//     super.initState();
//   }

//   List<String> _employeeController = [];
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           width: 450,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//           ),
//           child: Form(
//               key: _formKey,
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 // Header with client info
//                 Row(
//                   children: [
//                     const SizedBox(height: 24),
//                     Consumer<OfficersControllerProvider>(
//                         builder: (context, officers, child) {
//                       return Expanded(
//                         child: CustomMultiSelectDropdownField(
//                           isRequired: true,
//                           label: 'Add Group',

//                           selectedItems: _employeeController,
//                           items: officers?.officersListModel
//                                   ?.map((e) => "${e.name},${e.sId}")
//                                   .toList() ??
//                               [],
//                           onChanged: (selectedIds) {
//                             setState(() {
//                               _employeeController = selectedIds;
//                             });
//                           },

//                           // isRequired: true,
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Action buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomActionButton(
//                         text: 'Cancel',
//                         icon: Icons.close,
//                         onPressed: () => Navigator.pop(context),
//                         isFilled: false,
//                         textColor: Colors.blue.shade600,
//                         borderColor: Colors.blue.shade100,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomActionButton(
//                         text: 'ADD',
//                         icon: Icons.check,
//                         onPressed: () async {
//                           if ((_formKey.currentState?.validate() ?? false) &&
//                               _employeeController.isNotEmpty) {
//                             print("===============>$_employeeController");
//                             print(_employeeController.toList());
//                             final provider = Provider.of<RoundRobinProvider>(
//                                 context,
//                                 listen: false);

//                             bool result =
//                                 await provider.addOfficersToRoundRobin(
//                               context,
//                               roundRobinId: widget.roundRobinId,
//                               officerIds: _employeeController,
//                             );

//                             if (result) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text(' added successfully!')),
//                               );
//                               Navigator.pop(context);
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(provider.error ??
//                                         'Failed to add officers')),
//                               );
//                             }
//                           }
//                         },
//                         isFilled: true,
//                         gradient: AppColors.orangeGradient,
//                       ),
//                     ),
//                   ],
//                 ),
//               ])),
//         ));
//   }
// }
