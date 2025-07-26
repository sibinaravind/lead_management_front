// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/lead/lead_provider.dart';
// import 'package:overseas_front_end/res/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/custom_text.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';

// import '../../../../controller/config/config_provider.dart';
// import '../../../../model/app_configs/config_model.dart';
// import '../../../../res/style/colors/dimension.dart';
// import '../../../widgets/custom_date_range_field.dart';
// import '../../../widgets/filter_chip.dart';
// import '../add_lead_screen.dart';
// import 'bulk_lead.dart';

// class MobileLeadView extends StatelessWidget {
//   final dateController = TextEditingController();

//   MobileLeadView({super.key});

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3), width: 1),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.w600,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.2), width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: color, size: 14),
//           const SizedBox(width: 6),
//           Flexible(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: color,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
//     if (!kIsWeb) {
//       return InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: color.withOpacity(0.3), width: 1),
//           ),
//           child: Icon(
//             icon,
//             color: color,
//             size: 20,
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFFF8FAFC),
//             Color(0xFFEFF6FF),
//             Color(0xFFF1F5F9),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: const Text(
//             'Leads',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 gradient: AppColors.buttonGraidentColour,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.violetPrimaryColor.withOpacity(0.4),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(20),
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => const AddLeadScreen(),
//                     );
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.add_circle_outline,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         SizedBox(width: 12),
//                         CustomText(
//                           text: 'New Lead',
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//           backgroundColor: const Color(0xFF222B45),
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF1E293B),
//                   Color(0xFF222B45),
//                   Color(0xFF3B82F6),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: Consumer2<LeadProvider, ConfigProvider>(
//           builder: (context, value, value2, child) => SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               children: [
//                 if (value.selectedIndex != 4)
//                   Container(
//                     width: double.maxFinite,
//                     padding: const EdgeInsets.only(
//                         top: 6, bottom: 8, left: 15, right: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 20,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 CustomFilterChip(
//                                   icon: Icons.all_inclusive,
//                                   text: 'All Leads',
//                                   count: 128,
//                                   color: AppColors.primaryColor,
//                                   isSelected: value.selectedFilter == 'all',
//                                   onTap: () {
//                                     value.setSelectedFilter('all');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.fiber_new,
//                                   text: 'New',
//                                   count: 10,
//                                   color: AppColors.blueSecondaryColor,
//                                   isSelected: value.selectedFilter == 'new',
//                                   onTap: () {
//                                     value.setSelectedFilter('new');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.today,
//                                   text: 'Today',
//                                   count: 24,
//                                   color: AppColors.greenSecondaryColor,
//                                   isSelected: value.selectedFilter == 'today',
//                                   onTap: () {
//                                     value.setSelectedFilter('today');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.today,
//                                   text: 'Tommorrow',
//                                   count: 24,
//                                   color: AppColors.orangeSecondaryColor,
//                                   isSelected:
//                                       value.selectedFilter == 'tomorrow',
//                                   onTap: () {
//                                     value.setSelectedFilter('tomorrow');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.schedule,
//                                   text: 'Pending',
//                                   count: 8,
//                                   color: AppColors.redSecondaryColor,
//                                   isSelected: value.selectedFilter == 'pending',
//                                   onTap: () {
//                                     value.setSelectedFilter('pending');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.history,
//                                   text: 'Upcoming',
//                                   count: 156,
//                                   color: AppColors.skyBlueSecondaryColor,
//                                   isSelected:
//                                       value.selectedFilter == 'upcoming',
//                                   onTap: () {
//                                     value.setSelectedFilter('upcoming');
//                                   },
//                                 ),
//                                 // _buildFilterChip(
//                                 //   icon: Icons.history,
//                                 //   text: 'Converted',
//                                 //   count: 156,
//                                 //   color: AppColors.viloletSecondaryColor,
//                                 //   isSelected: selectedFilter == 'converted',
//                                 //   onTap: () {
//                                 //     setState(() {
//                                 //       selectedFilter = 'converted';
//                                 //     });
//                                 //   },
//                                 // ),
//                                 CustomFilterChip(
//                                   icon: Icons.trending_up,
//                                   text: 'UnAssigned',
//                                   count: 15,
//                                   color: AppColors.textGrayColour,
//                                   isSelected:
//                                       value.selectedFilter == 'unassigned',
//                                   onTap: () {
//                                     value.setSelectedFilter('unassigned');
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.history,
//                                   text: 'History',
//                                   count: 156,
//                                   color: AppColors.skyBlueSecondaryColor,
//                                   isSelected: value.selectedFilter == 'history',
//                                   onTap: () {
//                                     value.setSelectedFilter('history');
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildFilterToggleButton(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 _buildFilterPanel(context),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: value.allLeadModel.length,
//                     itemBuilder: (context, index) {
//                       final lead = value.allLeadModel[index];

//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.08),
//                               blurRadius: 15,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 left: BorderSide(
//                                   color: const Color(0xFF3B82F6),
//                                   width: 4,
//                                 ),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 6, horizontal: 8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Header with name and ID
//                                   Row(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(12),
//                                         decoration: BoxDecoration(
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Color(0xFF6366F1),
//                                               Color(0xFF8B5CF6),
//                                             ],
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         ),
//                                         child: const Icon(
//                                           Icons.person,
//                                           color: Colors.white,
//                                           size: 24,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   lead.name ?? "Unnamed",
//                                                   style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color(0xFF222B45),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 4),
//                                                   decoration: BoxDecoration(
//                                                     color:
//                                                         getColorBasedOnStatus(
//                                                             lead.status ?? '',
//                                                             value2),
//                                                     // gradient: AppColors.blueGradient,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12),
//                                                   ),
//                                                   child: Text(
//                                                     " ${lead.status ?? 'N/A'}",
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       fontSize: 12,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 // Container(
//                                                 //   padding: const EdgeInsets.symmetric(
//                                                 //       horizontal: 6, vertical: 4),
//                                                 //   decoration: BoxDecoration(
//                                                 //     gradient: const LinearGradient(
//                                                 //       colors: [
//                                                 //         Color(0xFFF59E0B),
//                                                 //         Color(0xFFEAB308),
//                                                 //       ],
//                                                 //     ),
//                                                 //     borderRadius:
//                                                 //         BorderRadius.circular(12),
//                                                 //   ),
//                                                 //   child:
//                                                 CustomText(
//                                                   text:
//                                                       " ${lead.clientId ?? 'N/A'}",
//                                                   color: AppColors
//                                                       .orangeSecondaryColor,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 12,
//                                                 ),
//                                                 // ),
//                                                 Flexible(
//                                                   child: Text(
//                                                     lead.phone ??
//                                                         "No phone number",
//                                                     style: TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.grey[700],
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 5),
//                                   // Status chips
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Wrap(
//                                           spacing: 8,
//                                           runSpacing: 8,
//                                           children: [
//                                             _buildStatusChip(
//                                               'Migration',
//                                               AppColors.redSecondaryColor,
//                                             ),
//                                             _buildStatusChip(
//                                               DateFormat("dd MMM yyyy").format(
//                                                 DateTime.tryParse(
//                                                         lead.createdAt ?? '') ??
//                                                     DateTime.now(),
//                                               ),
//                                               AppColors.blueSecondaryColor,
//                                             ),
//                                             _buildInfoChip(
//                                               Icons.email,
//                                               lead.email ?? '',
//                                               AppColors.greenSecondaryColor,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       _buildActionButton(
//                                         Icons.call,
//                                         const Color(0xFF10B981),
//                                         () async {
//                                           final uri = Uri(
//                                               scheme: 'tel',
//                                               path: lead.phone ?? '');
//                                           if (await canLaunchUrl(uri)) {
//                                             await launchUrl(uri);
//                                           }
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterPanel(BuildContext context) {
//     return Consumer<LeadProvider>(
//       builder: (context, value, child) => AnimatedContainer(
//         height: value.showFilters ? null : 0,
//         duration: const Duration(milliseconds: 300),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 12, top: 12),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Filter Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(
//                           Icons.filter_list,
//                           color: AppColors.primaryColor,
//                           size: 18,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const CustomText(
//                         text: "Advanced Filters",
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16,
//                       ),
//                     ],
//                   ),
//                   // IconButton(
//                   //   icon: const Icon(Icons.close, size: 20),
//                   //   onPressed: () => showFilters.value = false,
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Wrap(
//                 spacing: 5,
//                 runSpacing: 5,
//                 children: [
//                   // ...filterOptions.keys.map((category) {
//                   //   // print("0000000000000000000000000000000000000000000");
//                   //   // print(category);
//                   //   // print("0000000000000000000000000000000000000000000");

//                   //   return SizedBox(
//                   //     width: 180,
//                   //     height: 50,
//                   //     child: Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Container(
//                   //           padding: const EdgeInsets.symmetric(horizontal: 5),
//                   //           decoration: BoxDecoration(
//                   //             border: Border.all(
//                   //               color: Colors.grey.shade300,
//                   //               width: 1,
//                   //             ),
//                   //             borderRadius: BorderRadius.circular(12),
//                   //           ),
//                   //           child: DropdownButtonHideUnderline(
//                   //             child: DropdownButton<String>(
//                   //               hint: CustomText(
//                   //                 text: category,
//                   //                 fontWeight: FontWeight.w600,
//                   //                 color: AppColors.textColor,
//                   //                 fontSize: 14,
//                   //               ),
//                   //               isExpanded: true,
//                   //               value: selectedFilters[category],
//                   //               items: filterOptions[category]
//                   //                   ?.toSet()
//                   //                   .map((option) => DropdownMenuItem<String>(
//                   //                         value: option,
//                   //                         child: CustomText(
//                   //                             text: option, fontSize: 14),
//                   //                       ))
//                   //                   .toList(),
//                   //               onChanged: (value) {
//                   //                 if (value != null) {
//                   //                   // selectedFilters[category] = value;
//                   //                 }
//                   //               },
//                   //             ),
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   );
//                   // }).toList(),
//                   SizedBox(
//                     width: 180,
//                     child: CustomDateRangeField(
//                       label: 'From-To date',
//                       controller: dateController,
//                       isRequired: true,
//                       // onChanged: (range) {
//                       //   selectedRange = range;
//                       // },
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 5),
//               // SizedBox(
//               //   width: 250,
//               //   height: 50,
//               //   child: CustomDateRangeField(
//               //     label: 'From-To date',
//               //     controller: dateController,
//               //     isRequired: true,
//               //     onChanged: (range){
//               //       selectedRange = range;
//               //     },
//               //   ),
//               // ),

//               const SizedBox(height: 10),

//               // Filter Actions
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Consumer<LeadProvider>(
//                     builder: (context, value, child) => OutlinedButton(
//                       onPressed: () {
//                         value.setFilterActive(false);
//                         // resetFilters;
//                       },
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: AppColors.primaryColor),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const CustomText(
//                         text: "Reset",
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Consumer<LeadProvider>(
//                     builder: (context, value, child) => ElevatedButton(
//                       onPressed: () {
//                         value.setFilterActive(true);
//                         // applyFilters();
//                         value.setShowFilter(false);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const CustomText(
//                         text: "Apply Filters",
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
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

//   Widget _buildFilterToggleButton() {
//     return Consumer<LeadProvider>(
//       builder: (context, value, child) => GestureDetector(
//         onTap: () => value.setShowFilter(!value.showFilters),
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color:
//                   value.isFilterActive ? AppColors.primaryColor : Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: value.isFilterActive
//                     ? AppColors.primaryColor
//                     : Colors.grey.shade300,
//                 width: 1.5,
//               ),
//               boxShadow: [
//                 if (value.isFilterActive)
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.filter_list,
//                   color: value.isFilterActive
//                       ? Colors.white
//                       : AppColors.primaryColor,
//                   size: 18,
//                 ),
//                 const SizedBox(width: 8),
//                 CustomText(
//                   text: "Filters",
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: value.isFilterActive
//                       ? Colors.white
//                       : AppColors.primaryColor,
//                 ),
//                 if (value.isFilterActive) ...[
//                   const SizedBox(width: 8),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const CustomText(
//                       text: "Active",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color hexToColorWithAlpha(String hexString) {
//     hexString = hexString.replaceFirst('0X', '');
//     return Color(int.parse(hexString, radix: 16));
//   }

//   Color? getColorBasedOnStatus(String status, ConfigProvider configVal) {
//     String? value = configVal.configModelList?.clientStatus
//             ?.firstWhere(
//               (element) =>
//                   element.name?.toLowerCase() ==
//                   status.toString().toLowerCase(),
//               orElse: () => ConfigModel(colour: "0Xffffffff"),
//             )
//             .colour ??
//         "0Xffffffff";
//     return hexToColorWithAlpha(value ?? "0Xffffffff");
//   }
// }
