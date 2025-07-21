import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/lead/lead_provider.dart';
import 'package:overseas_front_end/view/screens/leads/widgets/bulk_lead.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../../res/style/colors/colors.dart';
import '../../../res/style/colors/dimension.dart';
import '../../widgets/custom_date_range_field.dart';
import '../../widgets/filter_chip.dart';
import 'add_lead_screen.dart';
import 'widgets/lead_user_list_table.dart';
import 'widgets/mobile_lead_view.dart';

class LeadDataDisplay extends StatefulWidget {
  const LeadDataDisplay({super.key});

  @override
  State<LeadDataDisplay> createState() => _LeadDataDisplayState();
}

class _LeadDataDisplayState extends State<LeadDataDisplay> {
  String selectedFilter = 'all';
  // final filterCategories = [
  //   'Service Type',
  //   'Designation',
  //   'Lead Status',
  //   'Call Status',
  //   'Agent',
  //   'Lead Country',
  //   'Lead Source',
  //   'Scheduled By',
  //   'Campaign',
  //   'Ad Set',
  //   'Ad',
  //   'Assigned To'
  //   // 'Status',
  //   // 'Source',
  //   // 'Priority',
  //   // 'Date Range',
  //   // 'Assigned To'
  // ];

  final filterOptions = {
    'Service Type': [' Migration'],
    'Branch': ["Branch1", "Branch2"],
    'Designation': ['Nurse'],
    'Employee': ['Alex', 'Mohan'],
    'Lead Status': ['Closed', 'OnHold', 'Interview'],
    'Call Status': ['Attended', 'NotAttended', 'Busy'],
    'Agent': ['Agent1', 'Agent2'],
    'Lead Country': ['Oman', 'Qatar', 'Kuwait', 'UAE'],
    'Status': ['Pending', 'Incomplete', 'ApplicationVerifiation'],
    'Lead Source': [
      'All',
      'Website',
      'Referral',
      'Social Media',
      'Email Campaign',
      'Event',
      'Other'
    ],
    'Scheduled By': ['Anas', 'Jiji'],
    'Campaign': ['fb lead', 'insta lead'],
    'Ad Set': [' depends fb'],
    'Ad': ['depends fb'],
    'Assigned To': ['All', 'Me', 'Unassigned']
    // final filterOptions = {
    //   'Service Type':[' Migration'],
    //   'Branch':[
    //     "Branch1",
    //     "Branch2"
    //   ],
    //   'Designation'
    //   'Status': [
    //     'All',
    //     'New',
    //     'Contacted',
    //     'Qualified',
    //     'Proposal',
    //     'Converted',
    //     'Lost'
    //   ],
    //   'Source': [
    //     'All',
    //     'Website',
    //     'Referral',
    //     'Social Media',
    //     'Email Campaign',
    //     'Event',
    //     'Other'
    //   ],
    //   'Priority': ['All', 'High', 'Medium', 'Low'],
    //   'Date Range': [
    //     'All',
    //     'Today',
    //     'This Week',
    //     'This Month',
    //     'Last Month',
    //     'Custom'
    //   ],
    //   'Assigned To': ['All', 'Me', 'Unassigned']
  };

  // Track selected filters

  TextEditingController dateController = TextEditingController();

  DateTimeRange? selectedRange;

  void initState() {
    // for (var category in filterCategories) {
    //   selectedFilters[category] = 'Service Type';
    // }

    // for (var category in filterCategories) {
    //   final options = filterOptions[category];
    //   if (options != null && options.contains('All')) {
    //     selectedFilters[category] = 'All';
    //   } else if (options != null && options.isNotEmpty) {
    //     selectedFilters[category] = options.first;
    //   } else {
    //     selectedFilters[category] = '';
    //   }
    // }
    Provider.of<LeadProvider>(context, listen: false).getLeadList(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dimension().isMobile(context)
        ? MobileLeadView()

        // Scaffold(
        //     body: SingleChildScrollView(
        //       child: Consumer<LeadProvider>(
        //         builder: (context, value, child) => Column(
        //           children: value.allLeadModel
        //               .map((e) => Card(
        //                     color: Colors.white,
        //                     elevation: 4,
        //                     margin: EdgeInsets.symmetric(
        //                         horizontal: 8, vertical: 5),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(12),
        //                     ),
        //                     child: ListTile(
        //                       minVerticalPadding: 3,
        //                       dense: true,
        //                       contentPadding: EdgeInsets.symmetric(
        //                           horizontal: 8, vertical: 0),
        //                       title: Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.spaceBetween,
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 /// Name & Client ID
        //                                 Row(
        //                                   children: [
        //                                     const Icon(Icons.person,
        //                                         color: Color(0xFF384571),
        //                                         size: 20),
        //                                     const SizedBox(width: 10),
        //                                     Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.start,
        //                                       children: [
        //                                         Row(
        //                                           crossAxisAlignment:
        //                                               CrossAxisAlignment.end,
        //                                           children: [
        //                                             Text(
        //                                               e.name ?? "Unnamed",
        //                                               style: const TextStyle(
        //                                                 fontSize: 20,
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 color:
        //                                                     Color(0xFF384571),
        //                                               ),
        //                                             ),
        //                                             SizedBox(width: 10),
        //                                             Padding(
        //                                               padding:
        //                                                   const EdgeInsets.all(
        //                                                       5.0),
        //                                               child: Text(
        //                                                 "${e.clientId}" ??
        //                                                     "N/A",
        //                                                 style: TextStyle(
        //                                                   fontWeight:
        //                                                       FontWeight.w600,
        //                                                   color: Colors
        //                                                       .amberAccent,
        //                                                   fontSize: 14,
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ]),
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text(
        //                                 e.phone ?? "",
        //                                 style: TextStyle(
        //                                   fontSize: 14,
        //                                   color: Colors.grey[600],
        //                                 ),
        //                               ),
        //                               // Icon(
        //                               //   Icons.call,
        //                               //   color: AppColors.greenSecondaryColor,
        //                               // )
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.end,
        //                                 children: [
        //                                   InkWell(
        //                                     onTap: () {
        //                                       canLaunchUrl(Uri(
        //                                               scheme: 'tel',
        //                                               path: e.phone ?? ''))
        //                                           .then((bool result) {});
        //                                     },
        //                                     child: Container(
        //                                       margin: EdgeInsets.all(9),
        //                                       child: Icon(
        //                                         Icons.call,
        //                                         color: AppColors
        //                                             .greenSecondaryColor,
        //                                       ),
        //                                     ),
        //                                   )
        //                                 ],
        //                               )
        //                             ],
        //                           ),
        //                           // SizedBox(height: 4),
        //                           Wrap(spacing: 8, runSpacing: 4, children: [
        //                             _buildStatusChip(
        //                                 DateFormat("dd/MM/yyyy").format(
        //                                         DateTime.tryParse(
        //                                                 e.createdAt ?? '') ??
        //                                             DateTime.now()) ??
        //                                     '',
        //                                 AppColors.skyBlueSecondaryColor),
        //                             _buildStatusChip(e.status ?? '',
        //                                 AppColors.orangeSecondaryColor),
        //                             _buildInfoChip(Icons.email, e.email ?? '',
        //                                 AppColors.greenSecondaryColor),
        //                             // _buildInfoChip(
        //                             //     Icons.perm_identity,
        //                             //     e.assignedTo ?? '',
        //                             //     AppColors.orangeSecondaryColor),
        //                           ]),
        //                         ],
        //                       ),
        //                       // subtitle: Row(
        //                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       //   children: [
        //                       //     Padding(
        //                       //       padding: EdgeInsets.only(top: 8),
        //                       //       child: Container(
        //                       //         padding: EdgeInsets.symmetric(
        //                       //             horizontal: 8, vertical: 4),
        //                       //         decoration: BoxDecoration(
        //                       //           color: AppColors.greenSecondaryColor
        //                       //               .withOpacity(0.1),
        //                       //           borderRadius: BorderRadius.circular(8),
        //                       //         ),
        //                       //         child: Text(
        //                       //           e.leadStatus ?? "",
        //                       //           style: TextStyle(
        //                       //             color: getColorBasedOnStatus(
        //                       //                 e.leadStatus ?? ""),
        //                       //             fontWeight: FontWeight.w500,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //     ),
        //                       //     SizedBox(
        //                       //       width: 5,
        //                       //     ),
        //                       //     Padding(
        //                       //       padding: EdgeInsets.only(top: 8),
        //                       //       child: Container(
        //                       //         padding: EdgeInsets.symmetric(
        //                       //             horizontal: 8, vertical: 4),
        //                       //         decoration: BoxDecoration(
        //                       //           color: AppColors.greenSecondaryColor
        //                       //               .withOpacity(0.1),
        //                       //           borderRadius: BorderRadius.circular(8),
        //                       //         ),
        //                       //         child: Text(
        //                       //           e.status ?? "",
        //                       //           style: TextStyle(
        //                       //             color: e.status == "Attended"
        //                       //                 ? AppColors.greenSecondaryColor
        //                       //                 : AppColors.redSecondaryColor,
        //                       //             fontWeight: FontWeight.w500,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //     ),
        //                       //   ],
        //                       // ),
        //                       // trailing: FittedBox(
        //                       //   child: Column(
        //                       //     children: [
        //                       //       Icon(
        //                       //         e.type?.toLowerCase() == "incoming" &&
        //                       //                 e.status?.toLowerCase() != "missed call"
        //                       //             ? Icons.call_received
        //                       //             : e.status?.toLowerCase() == "missed call"
        //                       //                 ? Icons.call_missed
        //                       //                 : Icons.call_made,
        //                       //         color: e.type?.toLowerCase() == "incoming"
        //                       //             ? AppColors.redSecondaryColor
        //                       //             : AppColors.greenSecondaryColor,
        //                       //         size: 28,
        //                       //       ),
        //                       //       SizedBox(
        //                       //         height: 10,
        //                       //       ),
        //                       //       Icon(
        //                       //         Icons.call,
        //                       //         color: AppColors.greenSecondaryColor,
        //                       //       )
        //                       //     ],
        //                       //   ),
        //                       // ),
        //                     ),
        //                   ))
        //               .toList(),
        //         ),
        //       ),
        //     ),
        //   )
        : Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGraident,
            ),
            child: SafeArea(
              child: Consumer<AppUserProvider>(
                builder: (context, value, child) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (value.selectedIndex != 4)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                              gradient: AppColors.blackGradient,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.analytics_outlined,
                                    color: AppColors.textWhiteColour,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Lead Management Dashboard",
                                        color: AppColors.textWhiteColour,
                                        fontSize: Dimension().isMobile(context)
                                            ? 13
                                            : 19,
                                        maxLines: 2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: AppColors.orangeGradient,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.orangeSecondaryColor
                                            .withOpacity(0.4),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const BulkLeadScreen(),
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 12),
                                            CustomText(
                                              text: 'Bulk Lead',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: AppColors.buttonGraidentColour,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.violetPrimaryColor
                                            .withOpacity(0.4),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AddLeadScreen(),
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 12),
                                            CustomText(
                                              text: 'New Lead',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (value.selectedIndex != 4)
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 8, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomFilterChip(
                                          icon: Icons.all_inclusive,
                                          text: 'All Leads',
                                          count: 128,
                                          color: AppColors.primaryColor,
                                          isSelected: selectedFilter == 'all',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'all';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.fiber_new,
                                          text: 'New',
                                          count: 10,
                                          color: AppColors.blueSecondaryColor,
                                          isSelected: selectedFilter == 'new',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'new';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.today,
                                          text: 'Today',
                                          count: 24,
                                          color: AppColors.greenSecondaryColor,
                                          isSelected: selectedFilter == 'today',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'today';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.today,
                                          text: 'Tommorrow',
                                          count: 24,
                                          color: AppColors.orangeSecondaryColor,
                                          isSelected:
                                              selectedFilter == 'tomorrow',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'tomorrow';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.schedule,
                                          text: 'Pending',
                                          count: 8,
                                          color: AppColors.redSecondaryColor,
                                          isSelected:
                                              selectedFilter == 'pending',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'pending';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.history,
                                          text: 'Upcoming',
                                          count: 156,
                                          color:
                                              AppColors.skyBlueSecondaryColor,
                                          isSelected:
                                              selectedFilter == 'upcoming',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'upcoming';
                                            });
                                          },
                                        ),
                                        // _buildFilterChip(
                                        //   icon: Icons.history,
                                        //   text: 'Converted',
                                        //   count: 156,
                                        //   color: AppColors.viloletSecondaryColor,
                                        //   isSelected: selectedFilter == 'converted',
                                        //   onTap: () {
                                        //     setState(() {
                                        //       selectedFilter = 'converted';
                                        //     });
                                        //   },
                                        // ),
                                        CustomFilterChip(
                                          icon: Icons.trending_up,
                                          text: 'UnAssigned',
                                          count: 15,
                                          color: AppColors.textGrayColour,
                                          isSelected:
                                              selectedFilter == 'unassigned',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'unassigned';
                                            });
                                          },
                                        ),
                                        CustomFilterChip(
                                          icon: Icons.history,
                                          text: 'History',
                                          count: 156,
                                          color:
                                              AppColors.skyBlueSecondaryColor,
                                          isSelected:
                                              selectedFilter == 'history',
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = 'history';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Flexible(
                            //   child: SizedBox(
                            //     width: 300,
                            //     height: 40,
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(16),
                            //       child: Consumer<LeadProvider>(
                            //         builder: (context, valueLead, child) => TextField(
                            //           controller: valueLead.searchController,
                            //           onChanged: (value) {
                            //             valueLead.filterEmployees(value);
                            //           },
                            //           decoration: InputDecoration(
                            //             hintText: "Search Leads...",
                            //             hintStyle: TextStyle(
                            //               color: Colors.grey.shade500,
                            //               fontSize: 15,
                            //             ),
                            //             hoverColor: Colors.white,
                            //             fillColor: AppColors.whiteMainColor,
                            //             filled: true,
                            //             suffixIcon: IconButton(
                            //               icon: const Icon(Icons.search,
                            //                   size: 20, color: Colors.grey),
                            //               onPressed: () {
                            //                 //     "Search query: ${_searchController.text}");
                            //               },
                            //             ),
                            //             enabledBorder: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(16),
                            //               borderSide: const BorderSide(
                            //                 color: Colors.black,
                            //                 width: 0.3,
                            //               ),
                            //             ),
                            //             focusedBorder: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(16),
                            //               borderSide: const BorderSide(
                            //                 color: AppColors.primaryColor,
                            //                 width: 1,
                            //               ),
                            //             ),
                            //             contentPadding: const EdgeInsets.symmetric(
                            //               horizontal: 16,
                            //               vertical: 15,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            _buildFilterToggleButton(),
                          ],
                        ),
                        _buildFilterPanel(context),
                        Consumer<LeadProvider>(
                            builder: (context, value, child) {
                          return Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Table Header
                                // Table Content
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: LeadUserListTable(
                                      userlist: value.leadModel ?? []),
                                ),

                                // Footer with Pagination
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.textGrayColour
                                            .withOpacity(0.1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              gradient: AppColors.blackGradient,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.analytics_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: " Leads",
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      CustomPager(
                                        currentPage: value.currentPage + 1,
                                        totalPages: min(1, 100),
                                        onPageSelected: (page) {
                                          if (value.currentPage != page - 1) {
                                            value.currentPage = page - 1;
                                            value.onPageSelected(page - 1);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          CustomText(text: text, fontSize: 9, color: color),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String text,
    required int count,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return CustomFilterChip(
      icon: icon,
      text: text,
      count: count,
      color: color,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  void applyFilters() {
    // isFilterActive.value = true;
    // controller.fetchLeadsWithFilters(selectedFilters);
  }

  Widget _buildFilterPanel(BuildContext context) {
    return Consumer<LeadProvider>(
      builder: (context, value, child) => AnimatedContainer(
        height: value.showFilters ? null : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, top: 12),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: AppColors.primaryColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const CustomText(
                        text: "Advanced Filters",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.close, size: 20),
                  //   onPressed: () => showFilters.value = false,
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  // ...filterOptions.keys.map((category) {
                  //   // print("0000000000000000000000000000000000000000000");
                  //   // print(category);
                  //   // print("0000000000000000000000000000000000000000000");

                  //   return SizedBox(
                  //     width: 180,
                  //     height: 50,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(horizontal: 5),
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: Colors.grey.shade300,
                  //               width: 1,
                  //             ),
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //           child: DropdownButtonHideUnderline(
                  //             child: DropdownButton<String>(
                  //               hint: CustomText(
                  //                 text: category,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: AppColors.textColor,
                  //                 fontSize: 14,
                  //               ),
                  //               isExpanded: true,
                  //               value: selectedFilters[category],
                  //               items: filterOptions[category]
                  //                   ?.toSet()
                  //                   .map((option) => DropdownMenuItem<String>(
                  //                         value: option,
                  //                         child: CustomText(
                  //                             text: option, fontSize: 14),
                  //                       ))
                  //                   .toList(),
                  //               onChanged: (value) {
                  //                 if (value != null) {
                  //                   // selectedFilters[category] = value;
                  //                 }
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }).toList(),
                  SizedBox(
                    width: 180,
                    child: CustomDateRangeField(
                      label: 'From-To date',
                      controller: dateController,
                      isRequired: true,
                      // onChanged: (range) {
                      //   selectedRange = range;
                      // },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),
              // SizedBox(
              //   width: 250,
              //   height: 50,
              //   child: CustomDateRangeField(
              //     label: 'From-To date',
              //     controller: dateController,
              //     isRequired: true,
              //     onChanged: (range){
              //       selectedRange = range;
              //     },
              //   ),
              // ),

              const SizedBox(height: 10),

              // Filter Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<LeadProvider>(
                    builder: (context, value, child) => OutlinedButton(
                      onPressed: () {
                        value.setFilterActive(false);
                        // resetFilters;
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryColor),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const CustomText(
                        text: "Reset",
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Consumer<LeadProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () {
                        value.setFilterActive(true);
                        // applyFilters();
                        value.setShowFilter(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const CustomText(
                        text: "Apply Filters",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: CustomText(
        text: text,
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  Widget _buildFilterToggleButton() {
    return Consumer<LeadProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () => value.setShowFilter(!value.showFilters),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  value.isFilterActive ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: value.isFilterActive
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: [
                if (value.isFilterActive)
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.filter_list,
                  color: value.isFilterActive
                      ? Colors.white
                      : AppColors.primaryColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: "Filters",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: value.isFilterActive
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
                if (value.isFilterActive) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CustomText(
                      text: "Active",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void resetFilters() {
  //   isFilterActive.value = false;
  //   // for (var category in filterCategories) {
  //   //   selectedFilters[category] = 'All';
  //   // }
  //   // controller.fetchLeads();
  // }
}
