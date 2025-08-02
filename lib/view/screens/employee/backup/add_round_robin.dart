// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/view/widgets/custom_dropdown_field.dart';
// import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';
// import 'package:provider/provider.dart';

// import '../../../../controller/config/config_provider.dart';
// import '../../../../controller/lead/round_robin_controller.dart';
// import '../../../../controller/officers_controller/officers_controller.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_action_button.dart';
// import '../../../widgets/custom_multi_selection_dropdown_field.dart';
// import '../../../widgets/custom_text.dart';
// import '../../../widgets/custom_text_form_field.dart';

// class AddRoundRobinDialog extends StatefulWidget {
//   const AddRoundRobinDialog({super.key, this.roundRobinId});
//   final String? roundRobinId;

//   @override
//   State<AddRoundRobinDialog> createState() => _AddRoundRobinDialogState();
// }

// class _AddRoundRobinDialogState extends State<AddRoundRobinDialog> {
//   @override
//   void initState() {
//     Provider.of<ConfigProvider>(context, listen: false).fetchConfigData();
//     Provider.of<OfficersControllerProvider>(context, listen: false)
//         .fetchOfficersList(context);
//     Provider.of<OfficersControllerProvider>(context, listen: false)
//         .fetchOfficersList(
//       context,
//     );
//     // TODO: implement initState
//     super.initState();
//   }

//   String _nameController = '';
//   String _selectedCountry = 'GCC';
//   List<String> _selectedOfficerIds = [];
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Container(
//         width: 450,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CustomText(
//                   text: 'Add Round Robin',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18),
//               const SizedBox(height: 16),
//               Consumer<ConfigProvider>(builder: (context, name, child) {
//                 return CustomDropdownField(
//                     isRequired: true,
//                     label: "Round Robin Name",
//                     value: _nameController,
//                     items: name.configModelList?.serviceType
//                             ?.map((e) => e.name ?? '')
//                             .toList() ??
//                         [],
//                     onChanged: (value) {
//                       setState(() {
//                         _nameController = value ?? '';
//                       });
//                     });
//               }),
//               // CustomTextFormField(
//               //   controller: _nameController,
//               //   label: 'Round Robin Name',
//               //   isRequired: true,
//               // ),
//               const SizedBox(height: 16),
//               Consumer<ConfigProvider>(builder: (context, country, child) {
//                 return CustomDropdownField(
//                     isRequired: true,
//                     label: "Country",
//                     value: _selectedCountry,
//                     items: country.configModelList?.country
//                             ?.map((e) => e.name ?? '')
//                             .toList() ??
//                         [],
//                     onChanged: (value) {
//                       _selectedCountry = value ?? '';
//                     });
//               }),
//               const SizedBox(height: 16),
//               Consumer<OfficersControllerProvider>(
//                 builder: (context, officers, child) {
//                   return CustomMultiSelectDropdownField(
//                     isRequired: true,
//                     isSplit: true,
//                     label: 'Add Officers',
//                     selectedItems: _selectedOfficerIds,
//                     items: officers.officersListModel
//                             ?.map((e) => "${e.name},${e.sId}")
//                             .toList() ??
//                         [],
//                     onChanged: (selectedIds) {
//                       setState(() {
//                         _selectedOfficerIds = selectedIds;
//                         print("........................");
//                         print(_selectedOfficerIds);
//                       });
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomActionButton(
//                       text: 'Cancel',
//                       icon: Icons.close,
//                       onPressed: () => Navigator.pop(context),
//                       isFilled: false,
//                       textColor: Colors.blue.shade600,
//                       borderColor: Colors.blue.shade100,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Consumer<RoundRobinProvider>(
//                       builder: (context, provider, child) {
//                         return CustomActionButton(
//                           text: 'ADD',
//                           icon: Icons.check,
//                           onPressed: () async {
//                             print('PRESSED');
//                             if ((_formKey.currentState?.validate() ?? false) &&
//                                 _selectedOfficerIds.isNotEmpty) {
//                               // add(provider);
//                               final name = _nameController.trim();
//                               bool result = await provider.createRoundRobin(
//                                 context,
//                                 name: name,
//                                 country: _selectedCountry,
//                                 officerIds: _selectedOfficerIds,
//                               );
//                               if (result) {
//                                 SnackBar(
//                                     content: Text(
//                                         'Round Robin Created Successfully'));

//                                 if (context.mounted) Navigator.pop(context);
//                               } else {
//                                 SnackBar(content: Text('Failed to create'));
//                               }
//                             }
//                           },
//                           isFilled: true,
//                           gradient: AppColors.orangeGradient,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void add(RoundRobinProvider provider) async {
//     print("------------validate----------");
//   }
// }
