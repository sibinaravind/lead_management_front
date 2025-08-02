// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/view/widgets/custom_text.dart';
// import '../../../utils/style/colors/colors.dart';
// import 'tabs/acadamic_tab.dart';
// import 'tabs/document_tab.dart';
// import 'tabs/eligility_tab.dart';
// import 'tabs/personal_details_tab.dart';
// import 'tabs/travel_details.dart';
// import 'tabs/work_experience_tab.dart';

// class RegistrationAdd extends StatefulWidget {
//   const RegistrationAdd({super.key, required this.id, required this.name});

//   final String id;
//   final String name;

//   @override
//   State<RegistrationAdd> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationAdd>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _contactNumberController =
//       TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final ScrollController tabScrollController = ScrollController();
//   String? contactCountryCode = '';
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 8, vsync: this);
//     _nameController.text = widget.name;
//     _contactNumberController.text = '';
//     _emailController.text = '';
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _nameController.dispose();
//     _contactNumberController.dispose();
//     _emailController.dispose();
//     tabScrollController.dispose();
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
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.98,
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
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 20),
//                     decoration: BoxDecoration(
//                       gradient: AppColors.blackGradient,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.grey.shade200,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         // Header Title Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.orangeSecondaryColor
//                                         .withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: const Icon(
//                                     Icons.person_add,
//                                     color: AppColors.orangeSecondaryColor,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const CustomText(
//                                   text: 'Candidate Registration',
//                                   fontSize: 20,
//                                   color: AppColors.textWhiteColour,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                             Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(20),
//                                 onTap: () => Navigator.pop(context),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   child: const Icon(
//                                     Icons.close,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // User Profile Section
//                         Container(
//                           margin: const EdgeInsets.only(top: 10, bottom: 10),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color: Colors.grey.shade200,
//                               width: 1,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.02),
//                                 spreadRadius: 0,
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               // Profile Avatar
//                               Stack(
//                                 children: [
//                                   Container(
//                                     width: 60,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         colors: [
//                                           AppColors.primaryColor
//                                               .withOpacity(0.8),
//                                           AppColors.primaryColor,
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(16),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: AppColors.primaryColor
//                                               .withOpacity(0.3),
//                                           spreadRadius: 0,
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 4),
//                                         ),
//                                       ],
//                                     ),
//                                     child: const Icon(
//                                       Icons.person,
//                                       size: 28,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         // TODO: Implement image picker logic here
//                                       },
//                                       child: Container(
//                                         width: 24,
//                                         height: 24,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: AppColors.primaryColor,
//                                             width: 1.5,
//                                           ),
//                                         ),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           size: 16,
//                                           color: AppColors.primaryColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(width: 16),

//                               // User Details
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomText(
//                                       text: _nameController.text,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: Colors.grey.shade800,
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.phone,
//                                           size: 14,
//                                           color: Colors.grey.shade500,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         CustomText(
//                                           text:
//                                               '+$contactCountryCode ${_contactNumberController.text}',
//                                           fontSize: 13,
//                                           color: Colors.grey.shade600,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.email,
//                                           size: 14,
//                                           color: Colors.grey.shade500,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         CustomText(
//                                           text: _emailController.text.isEmpty
//                                               ? 'N/A'
//                                               : _emailController.text,
//                                           fontSize: 13,
//                                           color: Colors.grey.shade600,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Registration Status Badge
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.orange.shade100,
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.orange.shade300,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.pending,
//                                       size: 14,
//                                       color: Colors.orange.shade700,
//                                     ),
//                                     const SizedBox(width: 4),
//                                     CustomText(
//                                       text: 'Pending',
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.orange.shade700,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.grey.shade200,
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Scrollbar(
//                                 controller: tabScrollController,
//                                 trackVisibility: true,
//                                 thumbVisibility: true,
//                                 thickness: 5,
//                                 radius: const Radius.circular(4),
//                                 child: SingleChildScrollView(
//                                   controller: tabScrollController,
//                                   scrollDirection: Axis.horizontal,
//                                   padding:
//                                       const EdgeInsets.only(bottom: 10, top: 2),
//                                   child: AnimatedBuilder(
//                                     animation: _tabController,
//                                     builder: (context, _) {
//                                       return TabBar(
//                                         controller: _tabController,
//                                         isScrollable: true,
//                                         indicator: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: AppColors.primaryColor,
//                                         ),
//                                         indicatorSize:
//                                             TabBarIndicatorSize.label,
//                                         dividerColor: Colors.transparent,
//                                         labelPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 4),
//                                         tabs: [
//                                           _buildEnhancedTab(
//                                             'Personal Details',
//                                             Icons.person_outline,
//                                             _tabController.index == 0,
//                                           ),
//                                           // _buildEnhancedTab(
//                                           //   'Candidate Preference',
//                                           //   Icons.fact_check_outlined,
//                                           //   _tabController.index == 1,
//                                           // ),
//                                           _buildEnhancedTab(
//                                             'Academic Details',
//                                             Icons.school_outlined,
//                                             _tabController.index == 1,
//                                           ),
//                                           _buildEnhancedTab(
//                                             'Eligibility Test',
//                                             Icons.language_outlined,
//                                             _tabController.index == 2,
//                                           ),
//                                           _buildEnhancedTab(
//                                             'Work Experience',
//                                             Icons.work_outline,
//                                             _tabController.index == 3,
//                                           ),
//                                           _buildEnhancedTab(
//                                             'Travel Details',
//                                             Icons.flight_outlined,
//                                             _tabController.index == 4,
//                                           ),
//                                           _buildEnhancedTab(
//                                             'Documents',
//                                             Icons.description_outlined,
//                                             _tabController.index == 5,
//                                           ),
//                                           // _buildEnhancedTab(
//                                           //   'Application',
//                                           //   Icons.assignment_outlined,
//                                           //   _tabController.index == 6,
//                                           // ),
//                                           // _buildEnhancedTab(
//                                           //   'Payment',
//                                           //   Icons.payment_outlined,
//                                           //   _tabController.index == 7,
//                                           // ),
//                                         ],
//                                         // Remove setState from onTap, let TabController handle it
//                                         onTap: (int index) {},
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),

//                               // Optional: A small space for the scrollbar track to appear more clearly
//                             ],
//                           ),
//                         ),

//                         // Tab Content
//                         Expanded(
//                           child: TabBarView(
//                             controller: _tabController,
//                             physics:
//                                 const NeverScrollableScrollPhysics(), // Prevent swipe lag
//                             children: [
//                               PersonalDetailsTab(
//                                 nameStr: widget.name ?? '',
//                                 id: widget.id,
//                               ),
//                               // const CandidatePreferenceTab(),
//                               AcadamicTab(
//                                 id: widget.id,
//                               ),
//                               EligibilityTab(),
//                               WorkExperience(),
//                               TravelDetails(),
//                               DocumentTab(),
//                               // _buildApplicationTab(),
//                               // _buildPaymentTab(),
//                             ],
//                           ),
//                         ),
//                       ],
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

//   Widget _buildEnhancedTab(String title, IconData icon, bool isSlected) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 25,
//             color:
//                 isSlected ? AppColors.darkOrangeColour : Colors.grey.shade700,
//           ),
//           const SizedBox(width: 8),
//           CustomText(
//             text: title,
//             fontSize: 13,
//             color: isSlected ? Colors.white : Colors.grey.shade700,
//             fontStyle: FontStyle.italic,
//             fontWeight: FontWeight.w500,
//           ),
//           const SizedBox(width: 15),
//           const Icon(
//             Icons.check_circle,
//             size: 20,
//             color: Colors.green,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLanguageTestTab() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.language_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: 'Language Test Details',
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 8),
//             CustomText(
//               text: 'Coming Soon',
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkExperienceTab() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.work_outline,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: 'Work Experience Details',
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 8),
//             CustomText(
//               text: 'Coming Soon',
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVisaDetailsTab() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.flight_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: 'Visa Details',
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 8),
//             CustomText(
//               text: 'Coming Soon',
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildApplicationTab() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.assignment_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: 'Application Details',
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 8),
//             CustomText(
//               text: 'Coming Soon',
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentTab() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.payment_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: 'Payment Information',
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 8),
//             CustomText(
//               text: 'Coming Soon',
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
