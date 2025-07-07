// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:overseas_front_end/controller/app_common/bloc/app_user_contoller.dart';
// import 'package:overseas_front_end/controller/officer/bloc/officer_controller.dart';
// import 'package:overseas_front_end/model/models.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/features/officers/widgets/profile_photo_upload_widget.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
//
// class EmployeeCreationScreen extends StatefulWidget {
//   const EmployeeCreationScreen({super.key});
//
//   @override
//   State<EmployeeCreationScreen> createState() => _EmployeeCreationScreenState();
// }
//
// class _EmployeeCreationScreenState extends State<EmployeeCreationScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   AppUserController appUserController = Get.find();
//   OfficerController officerController = Get.find();
//
//   List<dynamic>? _selectedBranch;
//   String? _selectedSalutation = "Mr";
//   List<dynamic>? _selectedDesignation;
//   String? _selectedNationality = 'India';
//   String? _selectedMaritalStatus;
//   String? _selectedGender;
//   Uint8List? imageBytes;
//
//   // Phone/Tele codes
//   String? _mobileTeleCode = '91';
//   String? _whatsmobileTeleCode = '91';
//   String? _alterselectedTeleCode = '91';
//   String? _emerselectedTeleCode = '91';
//
//   // Controllers
//   final TextEditingController _joiningDateController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _middleNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _whatsmobileController = TextEditingController();
//   final TextEditingController _alternatePhoneController =
//       TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _emergencyContactController =
//       TextEditingController();
//   final TextEditingController _emergencycontactPersonNumberController =
//       TextEditingController();
//   final TextEditingController _emergencycontactPersonRelationshipController =
//       TextEditingController();
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _city = TextEditingController();
//   final TextEditingController _state = TextEditingController();
//   final TextEditingController _pin = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _joiningDateController.text = DateTime.now().toString().substring(0, 10);
//   }
//
//   @override
//   void dispose() {
//     _joiningDateController.dispose();
//     _codeController.dispose();
//     _firstNameController.dispose();
//     _middleNameController.dispose();
//     _lastNameController.dispose();
//     _dobController.dispose();
//     _mobileController.dispose();
//     _whatsmobileController.dispose();
//     _emailController.dispose();
//     _emergencyContactController.dispose();
//     _emergencycontactPersonNumberController.dispose();
//     _emergencycontactPersonRelationshipController.dispose();
//     _address.dispose();
//     _city.dispose();
//     _state.dispose();
//     _pin.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;
//
//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }
//
//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1600,
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
//                   ),
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
//                             Icons.person_add_alt_1_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: 'Officer Registration',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text:
//                                     'Register new officer with complete details',
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
//
//                                               if (availableWidth > 1000) {
//                                                 columnsCount = 3;
//                                               } else if (availableWidth > 600) {
//                                                 columnsCount = 2;
//                                               }
//
//                                               return Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Basic Information',
//                                                       icon: Icons
//                                                           .info_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CutomCheckDropdown(
//                                                           label: 'Branch',
//                                                           values:
//                                                               _selectedBranch ??
//                                                                   [],
//                                                           items: (appUserController
//                                                                   .configList
//                                                                   .value
//                                                                   .branch
//                                                                   ?.map((branch) =>
//                                                                       branch
//                                                                           .name)
//                                                                   .whereType<
//                                                                       String>()
//                                                                   .toList()) ??
//                                                               [],
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedBranch =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         // CustomTextFormField(
//                                                         //   label: 'Officer Code',
//                                                         //   controller:
//                                                         //       _codeController,
//                                                         //   isRequired: true,
//                                                         // ),
//                                                         CustomTextFormField(
//                                                           label: 'Joining Date',
//                                                           controller:
//                                                               _joiningDateController,
//                                                           readOnly: true,
//                                                           isdate: true,
//                                                         ),
//                                                         CutomCheckDropdown(
//                                                           label: 'Designation',
//                                                           values:
//                                                               _selectedDesignation ??
//                                                                   [],
//                                                           items: (appUserController
//                                                                   .configList
//                                                                   .value
//                                                                   .designation
//                                                                   ?.map((designation) =>
//                                                                       designation
//                                                                           .name)
//                                                                   .whereType<
//                                                                       String>()
//                                                                   .toList()) ??
//                                                               [],
//                                                           onChanged: (selected) =>
//                                                               setState(() =>
//                                                                   _selectedDesignation =
//                                                                       selected),
//                                                           isRequired: true,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title: 'Personal Details',
//                                                       icon: Icons
//                                                           .person_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomDropdownField(
//                                                           label: 'Salutation',
//                                                           value:
//                                                               _selectedSalutation,
//                                                           items: const [
//                                                             'Mr',
//                                                             'Mrs',
//                                                             'Ms',
//                                                             'Dr'
//                                                           ],
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedSalutation =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'First Name',
//                                                           controller:
//                                                               _firstNameController,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Middle Name',
//                                                           controller:
//                                                               _middleNameController,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Last Name',
//                                                           controller:
//                                                               _lastNameController,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label:
//                                                               'Date of Birth',
//                                                           controller:
//                                                               _dobController,
//                                                           readOnly: true,
//                                                           isdate: true,
//                                                           isRequired: true,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 24),
//                                                   CustomGenderWidget(
//                                                     isRequired: true,
//                                                     selectedGender:
//                                                         _selectedGender,
//                                                     onGenderChanged: (value) =>
//                                                         setState(() =>
//                                                             _selectedGender =
//                                                                 value),
//                                                   ),
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Contact Information',
//                                                       icon: Icons
//                                                           .contact_phone_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'Mobile Number',
//                                                           controller:
//                                                               _mobileController,
//                                                           selectedCountry:
//                                                               _mobileTeleCode,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _mobileTeleCode =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'WhatsApp Number',
//                                                           controller:
//                                                               _whatsmobileController,
//                                                           selectedCountry:
//                                                               _whatsmobileTeleCode,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _whatsmobileTeleCode =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'Alternate Phone Number',
//                                                           controller:
//                                                               _alternatePhoneController,
//                                                           selectedCountry:
//                                                               _alterselectedTeleCode,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _alterselectedTeleCode =
//                                                                       val),
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Email ID',
//                                                           controller:
//                                                               _emailController,
//                                                           isRequired: true,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Address Information',
//                                                       icon: Icons
//                                                           .location_on_rounded),
//                                                   const SizedBox(height: 16),
//                                                   CustomTextFormField(
//                                                     label: 'Address',
//                                                     controller: _address,
//                                                     isRequired: true,
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomTextFormField(
//                                                           label: 'City',
//                                                           controller: _city,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'State',
//                                                           controller: _state,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'PIN Code',
//                                                           controller: _pin,
//                                                           isRequired: true,
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Additional Details',
//                                                       icon: Icons
//                                                           .more_horiz_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomDropdownField(
//                                                           label: 'Nationality',
//                                                           value:
//                                                               _selectedNationality,
//                                                           items: const [
//                                                             'India',
//                                                             'Other'
//                                                           ],
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedNationality =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         // CustomDropdownField(
//                                                         //   label: 'Religion',
//                                                         //   value:
//                                                         //       _selectedReligion,
//                                                         //   items: const [
//                                                         //     'Hindu',
//                                                         //     'Muslim',
//                                                         //     'Christian',
//                                                         //     'Sikh',
//                                                         //     'Buddhist',
//                                                         //     'Other'
//                                                         //   ],
//                                                         //   onChanged: (val) =>
//                                                         //       setState(() =>
//                                                         //           _selectedReligion =
//                                                         //               val),
//                                                         // ),
//                                                         CustomDropdownField(
//                                                           label:
//                                                               'Marital Status',
//                                                           value:
//                                                               _selectedMaritalStatus,
//                                                           items: const [
//                                                             'Single',
//                                                             'Married',
//                                                             'Divorced',
//                                                             'Widowed'
//                                                           ],
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _selectedMaritalStatus =
//                                                                       val),
//                                                         ),
//                                                       ]),
//                                                   const SizedBox(height: 32),
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Emergency Contact',
//                                                       icon: Icons
//                                                           .emergency_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         CustomTextFormField(
//                                                           label:
//                                                               'Emergency Contact Person',
//                                                           controller:
//                                                               _emergencyContactController,
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomPhoneField(
//                                                           label:
//                                                               'Contact Person Number',
//                                                           controller:
//                                                               _emergencycontactPersonNumberController,
//                                                           selectedCountry:
//                                                               _emerselectedTeleCode,
//                                                           onCountryChanged: (val) =>
//                                                               setState(() =>
//                                                                   _emerselectedTeleCode =
//                                                                       val),
//                                                           isRequired: true,
//                                                         ),
//                                                         CustomTextFormField(
//                                                           label: 'Relationship',
//                                                           controller:
//                                                               _emergencycontactPersonRelationshipController,
//                                                           isRequired: true,
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
//                                         // Expanded(
//                                         //   child: CustomActionButton(
//                                         //     text: 'Reset',
//                                         //     icon: Icons.refresh_rounded,
//                                         //     onPressed: () {
//                                         //       // Your reset logic
//                                         //     },
//                                         //     borderColor: Colors.grey.shade300,
//                                         //   ),
//                                         // ),
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
//                                             text: 'Save Officer',
//                                             icon: Icons.save_rounded,
//                                             isFilled: true,
//                                             gradient: const LinearGradient(
//                                               colors: [
//                                                 Color(0xFF7F00FF),
//                                                 Color(0xFFE100FF)
//                                               ],
//                                             ),
//                                             onPressed: () {
//                                               if (_formKey.currentState
//                                                       ?.validate() ??
//                                                   false) {
//                                                 showLoaderDialog(context);
//                                                 officerController
//                                                     .addOfficer(OfficerModel(
//                                                   branch: _selectedBranch ?? [],
//                                                   designation:
//                                                       _selectedDesignation ??
//                                                           [],
//                                                   joiningDate:
//                                                       _joiningDateController
//                                                           .text,
//                                                   salutation:
//                                                       _selectedSalutation,
//                                                   firstName:
//                                                       _firstNameController.text,
//                                                   middleName:
//                                                       _middleNameController
//                                                           .text,
//                                                   lastName:
//                                                       _lastNameController.text,
//                                                   dob: _dobController.text,
//                                                   address: _address.text,
//                                                   city: _city.text,
//                                                   state: _state.text,
//                                                   alternatePhone:
//                                                       _alterselectedTeleCode
//                                                               .toString() +
//                                                           _alternatePhoneController
//                                                               .text,
//                                                 ));
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
//                             const SizedBox(width: 24),
//                             Container(
//                               width: 280,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     AppColors.violetPrimaryColor
//                                         .withOpacity(0.08),
//                                     AppColors.blueSecondaryColor
//                                         .withOpacity(0.04),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(16),
//                                 border: Border.all(
//                                     color: AppColors.violetPrimaryColor
//                                         .withOpacity(0.15)),
//                               ),
//                               child: Column(
//                                 children: [
//                                   ProfilePhotoUploadWidget(
//                                     title:'Profile Photo',
//                                     onImageChanged: (bytes) {
//                                       setState(() {
//                                         imageBytes = bytes;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(height: 24),
//                                   // Container(
//                                   //   padding: const EdgeInsets.all(24),
//                                   //   child: Column(
//                                   //     crossAxisAlignment:
//                                   //         CrossAxisAlignment.start,
//                                   //     children: [
//                                   //       Row(
//                                   //         children: [
//                                   //           Container(
//                                   //             padding: const EdgeInsets.all(8),
//                                   //             decoration: BoxDecoration(
//                                   //               color: AppColors
//                                   //                   .violetPrimaryColor
//                                   //                   .withOpacity(0.1),
//                                   //               borderRadius:
//                                   //                   BorderRadius.circular(10),
//                                   //             ),
//                                   //             child: const Icon(
//                                   //                 Icons
//                                   //                     .notifications_active_rounded,
//                                   //                 size: 20,
//                                   //                 color: AppColors
//                                   //                     .violetPrimaryColor),
//                                   //           ),
//                                   //           const SizedBox(width: 12),
//                                   //           // const CustomText(
//                                   //           //   text: 'Notifications',
//                                   //           //   fontWeight: FontWeight.bold,
//                                   //           //   fontSize: 17,
//                                   //           //   color: AppColors.primaryColor,
//                                   //           // ),
//                                   //         ],
//                                   //       ),
//                                   //       const SizedBox(height: 20),
//                                   //       // Column(
//                                   //       //   children: [
//                                   //       //     EnhancedSwitchTile(
//                                   //       //       label: 'Email Notifications',
//                                   //       //       icon: Icons.email_rounded,
//                                   //       //       value: _emailSelected,
//                                   //       //       onChanged: (val) => setState(
//                                   //       //           () => _emailSelected = val),
//                                   //       //     ),
//                                   //       //     const SizedBox(height: 12),
//                                   //       //     EnhancedSwitchTile(
//                                   //       //       label: 'SMS Notifications',
//                                   //       //       icon: Icons.sms_rounded,
//                                   //       //       value: _smsSelected,
//                                   //       //       onChanged: (val) => setState(
//                                   //       //           () => _smsSelected = val),
//                                   //       //     ),
//                                   //       //   ],
//                                   //       // ),
//                                   //     ],
//                                   //   ),
//                                   // ),
//                                 ],
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
