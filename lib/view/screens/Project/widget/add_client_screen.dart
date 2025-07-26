// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/client/client_model.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import 'package:provider/provider.dart';
// import '../../../../controller/project/project_provider_controller.dart';
// import '../../../widgets/custom_toast.dart';

// class AddClientScreen extends StatefulWidget {
//   final bool isEdit;
//   final ClientModel? clientList;
//   const AddClientScreen({super.key, required this.isEdit, this.clientList});

//   @override
//   State<AddClientScreen> createState() => _AddClientScreenState();
// }

// class _AddClientScreenState extends State<AddClientScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();

//   // Form fields

//   String? _selectedCountry = '+91';
//   String? _selectedAlternativeCountry = '+91';
//   String? _selectedBranch = 'AFFINIKIS';
//   String? _statusSelection = '';
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _mobileOptionalController =
//       TextEditingController();

//   @override
//   void initState() {
//     _nameController.text = widget.clientList?.name ?? '';
//     _mobileController.text = widget.clientList?.phone ?? '';
//     _emailController.text = widget.clientList?.email ?? '';
//     _cityController.text = widget.clientList?.city ?? '';
//     _stateController.text = widget.clientList?.state ?? '';
//     _countryController.text = widget.clientList?.country ?? '';
//     _addressController.text = widget.clientList?.address ?? '';
//     _mobileOptionalController.text = widget.clientList?.alternatePhone ?? '';
//     _statusSelection = widget.clientList?.status ?? '';
//     TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _mobileOptionalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 800,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.leaderboard_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: widget.isEdit
//                                     ? 'Edit Client'
//                                     : 'Add New client',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: widget.isEdit
//                                     ? 'Edit all Client details'
//                                     : 'Capture client details for follow up',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Scrollbar(
//                                         thumbVisibility: true,
//                                         child: SingleChildScrollView(
//                                           padding: const EdgeInsets.all(24),
//                                           child: LayoutBuilder(
//                                             builder: (context, constraints) {
//                                               final availableWidth =
//                                                   constraints.maxWidth;
//                                               int columnsCount = 1;

//                                               if (availableWidth > 1000) {
//                                                 columnsCount = 3;
//                                               } else if (availableWidth > 600) {
//                                                 columnsCount = 2;
//                                               }

//                                               return Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title: 'Client Details',
//                                                       icon: Icons
//                                                           .person_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomTextFormField(
//                                                           label: 'Client Name',
//                                                           controller:
//                                                               _nameController,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Email ID',
//                                                           controller:
//                                                               _emailController,
//                                                         ),
//                                                         CustomDropdownField(
//                                                             label: "Status",
//                                                             value:
//                                                                 _statusSelection,
//                                                             items: [
//                                                               'ACTIVE',
//                                                               'INACTIVE'
//                                                             ],
//                                                             onChanged: (value) {
//                                                               _statusSelection =
//                                                                   value ?? '';
//                                                             }),
//                                                         CustomTextFormField(
//                                                           label: 'Address',
//                                                           controller:
//                                                               _addressController,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'City',
//                                                           controller:
//                                                               _cityController,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'State',
//                                                           controller:
//                                                               _stateController,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Country',
//                                                           controller:
//                                                               _countryController,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 20),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'Contact Details',
//                                                           controller:
//                                                               _mobileController,
//                                                           selectedCountry:
//                                                               _selectedCountry,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedCountry =
//                                                                       val),
//                                                           isRequired:
//                                                               widget.isEdit
//                                                                   ? false
//                                                                   : true,
//                                                         ),
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'Alternate Mobile (Optional)',
//                                                           controller:
//                                                               _mobileOptionalController,
//                                                           selectedCountry:
//                                                               _selectedAlternativeCountry,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedAlternativeCountry =
//                                                                       val),
//                                                           isRequired: false,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 32),
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(width: 16),
//                                         Expanded(
//                                           child: CustomActionButton(
//                                             text: 'Cancel',
//                                             icon: Icons.close_rounded,
//                                             textColor: Colors.grey,
//                                             onPressed: () =>
//                                                 Navigator.pop(context),
//                                             borderColor: Colors.grey.shade300,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 16),
//                                         Expanded(
//                                           flex: 2,
//                                           child: CustomActionButton(
//                                             text: widget.isEdit
//                                                 ? 'Edit Client'
//                                                 : 'Save Client',
//                                             icon: Icons.save_rounded,
//                                             isFilled: true,
//                                             gradient: const LinearGradient(
//                                               colors: [
//                                                 Color(0xFF7F00FF),
//                                                 Color(0xFFE100FF)
//                                               ],
//                                             ),
//                                             onPressed: () async {
//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 if (widget.isEdit) {
//                                                   await Provider.of<
//                                                               ProjectProvider>(
//                                                           context,
//                                                           listen: false)
//                                                       .editClient(
//                                                     clientId: widget
//                                                             .clientList?.sId ??
//                                                         '',
//                                                     name:
//                                                         _nameController.text ??
//                                                             '',
//                                                     email:
//                                                         _emailController.text ??
//                                                             '',
//                                                     phone: _mobileController
//                                                             .text ??
//                                                         '',
//                                                     alternatePhone:
//                                                         _mobileOptionalController
//                                                                 .text ??
//                                                             '',
//                                                     address: _addressController
//                                                             .text ??
//                                                         '',
//                                                     city:
//                                                         _cityController.text ??
//                                                             '',
//                                                     state:
//                                                         _stateController.text ??
//                                                             '',
//                                                     country: _countryController
//                                                             .text ??
//                                                         '',
//                                                     status:
//                                                         _statusSelection ?? '',
//                                                     context: context,
//                                                   );
//                                                   Navigator.pop(context);
//                                                 } else {
//                                                   Provider.of<ProjectProvider>(
//                                                           context,
//                                                           listen: false)
//                                                       .createClient(
//                                                     status:
//                                                         _statusSelection ?? '',
//                                                     name:
//                                                         _nameController.text ??
//                                                             '',
//                                                     email:
//                                                         _emailController.text ??
//                                                             '',
//                                                     phone:
//                                                         "$_selectedCountry ${_mobileController.text}" ??
//                                                             '',
//                                                     alternatePhone:
//                                                         (_mobileOptionalController
//                                                                         .text ==
//                                                                     '' ||
//                                                                 _mobileOptionalController
//                                                                     .text
//                                                                     .isEmpty)
//                                                             ? ""
//                                                             : "$_selectedAlternativeCountry ${_mobileOptionalController.text}" ??
//                                                                 '',
//                                                     address: _addressController
//                                                             .text ??
//                                                         '',
//                                                     city:
//                                                         _cityController.text ??
//                                                             '',
//                                                     state:
//                                                         _stateController.text ??
//                                                             '',
//                                                     country: _countryController
//                                                             .text ??
//                                                         '',
//                                                     context: context,
//                                                   );
//                                                   CustomToast.showToast(
//                                                       context: context,
//                                                       message:
//                                                           'Client saved successfully');
//                                                   // ScaffoldMessenger.of(context)
//                                                   //     .showSnackBar(
//                                                   //   const SnackBar(
//                                                   //       content: Text(
//                                                   //           'Client saved successfully')),
//                                                   // );
//                                                   Navigator.pop(context);
//                                                 }
//                                               } else {
//                                                 return CustomSnackBar.show(
//                                                     context,
//                                                     "Enter required Fields");
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
