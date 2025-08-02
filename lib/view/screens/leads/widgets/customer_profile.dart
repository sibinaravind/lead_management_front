// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/view/screens/leads/edit_lead_screen.dart';
// import 'package:overseas_front_end/view/screens/leads/widgets/lead_details_tab.dart';
// import 'package:provider/provider.dart';

// import '../../../../controller/lead/lead_provider.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/custom_gradient_button.dart';
// import '../../../widgets/custom_text.dart';
// import 'call_history_tab.dart';

// class CustomerProfileScreen extends StatefulWidget {
//   const CustomerProfileScreen(
//       {super.key,
//       required this.leadId,
//       required this.clientId,
//       required this.isRegistration});

//   final String leadId;
//   final String clientId;
//   final bool isRegistration;

//   @override
//   State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
// }

// class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
//   int _selectedTabIndex = 0;

//   List<Map<String, dynamic>> _tabs = [
//     // {
//     //   'icon': Icons.person_outline,
//     //   'label': 'Eligibility',
//     //   'widget': const EligibilityTab(),
//     //   'completed': true,
//     // },
//     // {
//     //   'icon': Icons.school_outlined,
//     //   'label': 'Education',
//     //   'widget': const AcademicTab(),
//     //   'completed': true,
//     // },
//     // {
//     //   'icon': Icons.work,
//     //   'label': 'Work Experience',
//     //   'widget': const JobDetailsTab(),
//     //   'completed': true,
//     // },
//     // {
//     //   'icon': Icons.airplanemode_on,
//     //   'label': 'Travel Details',
//     //   'widget': const JobDetailsTab(),
//     //   'completed': true,
//     // },
//     // {
//     //   'icon': Icons.document_scanner,
//     //   'label': 'Documents',
//     //   'widget': DocumentsTab(
//     //     size: 600,
//     //     documents: [
//     //       DocumentItem(name: "Passport", path: "path/to/passport.pdf"),
//     //       DocumentItem(name: "SSLC Certificate", path: ''),
//     //       DocumentItem(name: "Degree Certificate", path: "path/to/degree.pdf"),

//     //     ],
//     //   ),
//     //   'completed': true,
//     // },
//     // {
//     //   'icon': Icons.history,
//     //   'label': 'Candidate Activity',
//     //   'widget': const CandidateHistory(),
//     //   'completed': true,
//     // },
//   ];

//   @override
//   initState() {
//     super.initState();
//     _tabs = [
//       {
//         'icon': Icons.assignment_outlined,
//         'label': 'Candidate Details',
//         'widget': const LeadDetailsTab(),
//         'completed': true,
//       },
//       {
//         'icon': Icons.call_outlined,
//         'label': 'Call History',
//         'widget': CallHistoryTab(clientId: widget.clientId),
//         'completed': true,
//       },
//     ];
//     // Initialize the first tab as selected
//     Provider.of<LeadProvider>(context, listen: false)
//         .getLeadDetails(context, widget.leadId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding:
//           EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 16 : 8),
//       backgroundColor: Colors.white,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.9,
//           maxWidth:
//               MediaQuery.of(context).size.width > 600 ? 1200 : double.infinity,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header - Fixed height
//             Container(
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Flexible(
//                       child: CustomText(
//                         text: 'Candidate Profile',
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close,
//                           color: Colors.white, size: 24),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Profile Section - Fixed height
//             Consumer<LeadProvider>(
//               builder: (context, leadProvider, child) => Container(
//                 width: double.maxFinite,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                   border: Border.all(color: AppColors.iconWhiteColour),
//                 ),
//                 child: Column(
//                   children: [
//                     // Profile row - make it responsive
//                     LayoutBuilder(
//                       builder: (context, constraints) {
//                         final isSmallScreen = constraints.maxWidth < 400;
//                         return Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     gradient: AppColors.buttonGraidentColour,
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: const Icon(Icons.person,
//                                       color: Colors.white, size: 32),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           CustomText(
//                                             text: leadProvider
//                                                     .leadDetails?.name ??
//                                                 'N/A',
//                                             fontSize: isSmallScreen ? 20 : 24,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.textWhiteColour,
//                                           ),
//                                           const SizedBox(height: 4),
//                                           CustomText(
//                                             text: leadProvider
//                                                     .leadDetails?.clientId ??
//                                                 'N/A',
//                                             fontSize: 14,
//                                             color: AppColors.textGrayColour,
//                                           ),
//                                         ],
//                                       ),
//                                       if (isSmallScreen) ...[
//                                         const SizedBox(height: 16),
//                                         Align(
//                                           alignment: Alignment.centerRight,
//                                           child: CustomGradientButton(
//                                             text: 'Edit Profile',
//                                             gradientColors:
//                                                 AppColors.redGradient,
//                                             onPressed: () {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (context) =>
//                                                     EditLeadScreen(
//                                                   isRegistration:
//                                                       widget.isRegistration,
//                                                   selectedCountryPhoneCode:
//                                                       leadProvider.leadDetails
//                                                               ?.countryCode ??
//                                                           '',
//                                                   altMobileStr: leadProvider
//                                                           .leadDetails
//                                                           ?.alternatePhone ??
//                                                       '',
//                                                   leadId: leadProvider
//                                                           .leadDetails?.sId ??
//                                                       '',
//                                                   selectedService: leadProvider
//                                                           .leadDetails
//                                                           ?.serviceType ??
//                                                       '',
//                                                   selectedCountry: leadProvider
//                                                           .leadDetails
//                                                           ?.country ??
//                                                       '',
//                                                   selectedBranch: leadProvider
//                                                           .leadDetails
//                                                           ?.branch ??
//                                                       '',
//                                                   selectedGender: leadProvider
//                                                           .leadDetails
//                                                           ?.gender ??
//                                                       '',
//                                                   selectedMaritalStatus:
//                                                       leadProvider.leadDetails
//                                                               ?.maritalStatus ??
//                                                           '',
//                                                   selectedLeadSource:
//                                                       leadProvider.leadDetails
//                                                               ?.leadSource ??
//                                                           '',
//                                                   selectedLeadCategory:
//                                                       leadProvider.leadDetails
//                                                               ?.leadSource ??
//                                                           '',
//                                                   selectedStatus: leadProvider
//                                                           .leadDetails
//                                                           ?.status ??
//                                                       '',
//                                                   selectedServiceType:
//                                                       leadProvider.leadDetails
//                                                               ?.serviceType ??
//                                                           '',
//                                                   selectedQualification:
//                                                       leadProvider.leadDetails
//                                                               ?.qualification ??
//                                                           '',
//                                                   selectedDistrict: '',
//                                                   selectedAgent: '',
//                                                   sendGreetings: leadProvider
//                                                           .leadDetails
//                                                           ?.onCallCommunication ??
//                                                       false,
//                                                   sendEmail: leadProvider
//                                                           .leadDetails
//                                                           ?.onEmailCommunication ??
//                                                       false,
//                                                   sendWhatsapp: leadProvider
//                                                           .leadDetails
//                                                           ?.onWhatsappCommunication ??
//                                                       false,
//                                                   nameStr: leadProvider
//                                                           .leadDetails?.name ??
//                                                       '',
//                                                   mobileStr: leadProvider
//                                                           .leadDetails?.phone ??
//                                                       '',
//                                                   waMobileStr: leadProvider
//                                                           .leadDetails
//                                                           ?.whatsapp ??
//                                                       '',
//                                                   emailStr: leadProvider
//                                                           .leadDetails?.email ??
//                                                       '',
//                                                   leadDateStr: leadProvider
//                                                           .leadDetails
//                                                           ?.createdAt ??
//                                                       '',
//                                                   mobileOptionalStr: leadProvider
//                                                           .leadDetails
//                                                           ?.alternatePhone ??
//                                                       '',
//                                                   locationStr: leadProvider
//                                                           .leadDetails
//                                                           ?.address ??
//                                                       '',
//                                                   qualificationStr: leadProvider
//                                                           .leadDetails
//                                                           ?.qualification ??
//                                                       '',
//                                                   courseNameStr: '',
//                                                   remarksStr: leadProvider
//                                                           .leadDetails?.note ??
//                                                       '',
//                                                   dobStr: DateFormat(
//                                                               'dd/MM/yyyy')
//                                                           .format(DateTime.tryParse(
//                                                                   leadProvider
//                                                                           .leadDetails
//                                                                           ?.dob ??
//                                                                       '') ??
//                                                               DateTime.now()) ??
//                                                       '',
//                                                   cityStr: leadProvider
//                                                           .leadDetails?.city ??
//                                                       '',
//                                                   stateStr: leadProvider
//                                                           .leadDetails?.state ??
//                                                       '',
//                                                   countryStr: leadProvider
//                                                           .leadDetails
//                                                           ?.country ??
//                                                       '',
//                                                   selectedCountries: leadProvider
//                                                           .leadDetails
//                                                           ?.countryInterested ??
//                                                       [],
//                                                   selectedSpecialized:
//                                                       leadProvider.leadDetails
//                                                               ?.specializedIn ??
//                                                           [],
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ] else ...[
//                                         // Keep edit button inline for larger screens
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             CustomGradientButton(
//                                               text: 'Edit Profile',
//                                               gradientColors:
//                                                   AppColors.redGradient,
//                                               onPressed: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) =>
//                                                       EditLeadScreen(
//                                                     isRegistration:
//                                                         widget.isRegistration,
//                                                     selectedCountryPhoneCode:
//                                                         leadProvider.leadDetails
//                                                                 ?.countryCode ??
//                                                             '',
//                                                     altMobileStr: leadProvider
//                                                             .leadDetails
//                                                             ?.alternatePhone ??
//                                                         '',
//                                                     leadId: leadProvider
//                                                             .leadDetails?.sId ??
//                                                         '',
//                                                     selectedService:
//                                                         leadProvider.leadDetails
//                                                                 ?.serviceType ??
//                                                             '',
//                                                     selectedCountry:
//                                                         leadProvider.leadDetails
//                                                                 ?.country ??
//                                                             '',
//                                                     selectedBranch: leadProvider
//                                                             .leadDetails
//                                                             ?.branch ??
//                                                         '',
//                                                     selectedGender: leadProvider
//                                                             .leadDetails
//                                                             ?.gender ??
//                                                         '',
//                                                     selectedMaritalStatus:
//                                                         leadProvider.leadDetails
//                                                                 ?.maritalStatus ??
//                                                             '',
//                                                     selectedLeadSource:
//                                                         leadProvider.leadDetails
//                                                                 ?.leadSource ??
//                                                             '',
//                                                     selectedLeadCategory:
//                                                         leadProvider.leadDetails
//                                                                 ?.leadSource ??
//                                                             '',
//                                                     selectedStatus: leadProvider
//                                                             .leadDetails
//                                                             ?.status ??
//                                                         '',
//                                                     selectedServiceType:
//                                                         leadProvider.leadDetails
//                                                                 ?.serviceType ??
//                                                             '',
//                                                     selectedQualification:
//                                                         leadProvider.leadDetails
//                                                                 ?.qualification ??
//                                                             '',
//                                                     selectedDistrict: '',
//                                                     selectedAgent: '',
//                                                     sendGreetings: leadProvider
//                                                             .leadDetails
//                                                             ?.onCallCommunication ??
//                                                         false,
//                                                     sendEmail: leadProvider
//                                                             .leadDetails
//                                                             ?.onEmailCommunication ??
//                                                         false,
//                                                     sendWhatsapp: leadProvider
//                                                             .leadDetails
//                                                             ?.onWhatsappCommunication ??
//                                                         false,
//                                                     nameStr: leadProvider
//                                                             .leadDetails
//                                                             ?.name ??
//                                                         '',
//                                                     mobileStr: leadProvider
//                                                             .leadDetails
//                                                             ?.phone ??
//                                                         '',
//                                                     waMobileStr: leadProvider
//                                                             .leadDetails
//                                                             ?.whatsapp ??
//                                                         '',
//                                                     emailStr: leadProvider
//                                                             .leadDetails
//                                                             ?.email ??
//                                                         '',
//                                                     leadDateStr: leadProvider
//                                                             .leadDetails
//                                                             ?.createdAt ??
//                                                         '',
//                                                     mobileOptionalStr: leadProvider
//                                                             .leadDetails
//                                                             ?.alternatePhone ??
//                                                         '',
//                                                     locationStr: leadProvider
//                                                             .leadDetails
//                                                             ?.address ??
//                                                         '',
//                                                     qualificationStr: leadProvider
//                                                             .leadDetails
//                                                             ?.qualification ??
//                                                         '',
//                                                     courseNameStr: '',
//                                                     remarksStr: leadProvider
//                                                             .leadDetails
//                                                             ?.note ??
//                                                         '',
//                                                     dobStr: DateFormat(
//                                                                 'dd/MM/yyyy')
//                                                             .format(DateTime.tryParse(
//                                                                     leadProvider
//                                                                             .leadDetails
//                                                                             ?.dob ??
//                                                                         '') ??
//                                                                 DateTime
//                                                                     .now()) ??
//                                                         '',
//                                                     cityStr: leadProvider
//                                                             .leadDetails
//                                                             ?.city ??
//                                                         '',
//                                                     stateStr: leadProvider
//                                                             .leadDetails
//                                                             ?.state ??
//                                                         '',
//                                                     countryStr: leadProvider
//                                                             .leadDetails
//                                                             ?.country ??
//                                                         '',
//                                                     selectedCountries: leadProvider
//                                                             .leadDetails
//                                                             ?.countryInterested ??
//                                                         [],
//                                                     selectedSpecialized:
//                                                         leadProvider.leadDetails
//                                                                 ?.specializedIn ??
//                                                             [],
//                                                   ),
//                                                 );
//                                                 // Same onPressed logic as above
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Edit button - move to separate row on small screens
//                           ],
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     // Info chips - make them responsive
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: [
//                           _buildInfoChip(
//                               Icons.phone,
//                               leadProvider.leadDetails?.phone ?? 'N/A',
//                               AppColors.blueSecondaryColor),
//                           _buildInfoChip(
//                               Icons.email,
//                               leadProvider.leadDetails?.email ?? 'N/A',
//                               AppColors.greenSecondaryColor),
//                           _buildInfoChip(
//                               Icons.person_outline,
//                               'Counselor: ${leadProvider.leadDetails?.assignedTo ?? 'N/A'}',
//                               AppColors.viloletSecondaryColor),
//                           _buildInfoChip(
//                               Icons.location_on,
//                               'Location: ${leadProvider.leadDetails?.address ?? 'N/A'}',
//                               AppColors.orangeSecondaryColor),
//                         ],
//                       ),
//                     ),
//                     // const SizedBox(height: 16),
//                     // Row(
//                     //   children: [
//                     //     _buildStatusChip(
//                     //         leadProvider.leadDetails?.serviceType ?? 'N/A',
//                     //         AppColors.skyBlueSecondaryColor),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//             ),

//             // Tabs section - This is the main scrollable content
//             Expanded(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final isDesktop = MediaQuery.of(context).size.width > 1000;
//                   return isDesktop
//                       ? Expanded(
//                           child: Container(
//                             height: 420,
//                             // margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(12),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.white.withOpacity(0.1),
//                                   spreadRadius: 1,
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 // Left Tab List
//                                 Container(
//                                   width: 280,
//                                   decoration: const BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     borderRadius: BorderRadius.only(
//                                       // topLeft: Radius.circular(12),
//                                       bottomLeft: Radius.circular(12),
//                                     ),
//                                   ),
//                                   child: ListView.builder(
//                                     padding: const EdgeInsets.all(8),
//                                     itemCount: _tabs.length,
//                                     itemBuilder: (context, index) {
//                                       final tab = _tabs[index];
//                                       final isSelected =
//                                           _selectedTabIndex == index;
//                                       return Container(
//                                         margin:
//                                             const EdgeInsets.only(bottom: 4),
//                                         decoration: BoxDecoration(
//                                           gradient: isSelected
//                                               ? AppColors.buttonGraidentColour
//                                               : null,
//                                           color: isSelected
//                                               ? null
//                                               : Colors.transparent,
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         child: ListTile(
//                                           dense: true,
//                                           leading: Icon(
//                                             tab['icon'] as IconData,
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : AppColors.textGrayColour,
//                                             size: 22,
//                                           ),
//                                           title: CustomText(
//                                             text: tab['label'] as String,
//                                             fontSize: 14,
//                                             fontWeight: isSelected
//                                                 ? FontWeight.w600
//                                                 : FontWeight.w100,
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : Colors.white.withOpacity(0.5),
//                                           ),
//                                           trailing: tab['completed'] as bool
//                                               ? Icon(
//                                                   Icons.check_circle,
//                                                   color: isSelected
//                                                       ? Colors.white
//                                                       : AppColors
//                                                           .greenSecondaryColor,
//                                                   size: 18,
//                                                 )
//                                               : Icon(
//                                                   Icons.radio_button_unchecked,
//                                                   color: isSelected
//                                                       ? Colors.white70
//                                                       : AppColors
//                                                           .textGrayColour,
//                                                   size: 18,
//                                                 ),
//                                           onTap: () {
//                                             setState(() {
//                                               _selectedTabIndex = index;
//                                             });
//                                           },
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),

//                                 // Right content
//                                 Expanded(
//                                   child: Container(
//                                     padding: const EdgeInsets.all(24),
//                                     child: _tabs[_selectedTabIndex]['widget']
//                                         as Widget,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : // Mobile layout with tabs
//                       Column(
//                           children: [
//                             // Tab bar for mobile
//                             Container(
//                               height: 60,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.primaryColor,
//                               ),
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 itemCount: _tabs.length,
//                                 itemBuilder: (context, index) {
//                                   final tab = _tabs[index];
//                                   final isSelected = _selectedTabIndex == index;
//                                   return Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 4, vertical: 8),
//                                     decoration: BoxDecoration(
//                                       gradient: isSelected
//                                           ? AppColors.buttonGraidentColour
//                                           : null,
//                                       color: isSelected
//                                           ? null
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedTabIndex = index;
//                                         });
//                                       },
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 8),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Icon(
//                                               tab['icon'] as IconData,
//                                               color: isSelected
//                                                   ? Colors.white
//                                                   : Colors.white
//                                                       .withOpacity(0.7),
//                                               size: 20,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             CustomText(
//                                               text: tab['label'] as String,
//                                               fontSize: 12,
//                                               fontWeight: isSelected
//                                                   ? FontWeight.w600
//                                                   : FontWeight.w400,
//                                               color: isSelected
//                                                   ? Colors.white
//                                                   : Colors.white
//                                                       .withOpacity(0.7),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             // Tab content
//                             Expanded(
//                               child: Container(
//                                 padding: const EdgeInsets.all(16),
//                                 child: _tabs[_selectedTabIndex]['widget']
//                                     as Widget,
//                               ),
//                             ),
//                           ],
//                         );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 6),
//           CustomText(text: text, fontSize: 12, color: color),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: CustomText(
//         text: text,
//         fontSize: 11,
//         fontWeight: FontWeight.w600,
//         color: color,
//       ),
//     );
//   }
// }
