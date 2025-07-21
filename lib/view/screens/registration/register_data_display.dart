import 'dart:math';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/registration/registration_controller.dart';
import 'package:provider/provider.dart';
import '../../../res/style/colors/colors.dart';
import '../../../res/style/colors/dimension.dart';
import '../../widgets/custom_date_range_field.dart';
import '../../widgets/widgets.dart';
import 'widgets/register_user_list_table.dart';

class RegisterDataDisplay extends StatefulWidget {
  RegisterDataDisplay({super.key});

  @override
  State<RegisterDataDisplay> createState() => _RegisterDataDisplayState();
}

class _RegisterDataDisplayState extends State<RegisterDataDisplay> {
  String selectedFilter = 'all';

  // Filter related variables
  final filterCategories = [
    'Status',
    'Source',
    'Priority',
    'Date Range',
    'Assigned To'
  ];

  TextEditingController dateController = TextEditingController();

  // final filterOptions = {
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

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RegistrationController>(context, listen: false)
        .fetchRegistration(context,);
    super.initState();
  }

  // Track selected filters
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Registration",
                  color: AppColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: AppColors.primaryColor,
                    backgroundColor: AppColors.blueGrayColour,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => RegistrationAdd(),
                    );
                  },
                  child: const CustomText(
                    text: 'Register',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 250,
                  child: CustomTextField(
                    controller: controller.searchController,
                    labelText: "Search...",
                    validator: (v) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: CustomButton(
                        text: "Search",
                        color: AppColors.darkVioletColour,
                        fontSize: 12,
                        onTap: () {
                          controller.searchController.text.isNotEmpty
                              ? controller.fetchData(
                                  search: controller.searchController.text,
                                )
                              : controller.fetchData();
                        }),
                  ),
                ),
              ],
            ), */

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                gradient: AppColors.blackGradient,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Registration Management Dashboard",
                          color: AppColors.textWhiteColour,
                          fontSize: Dimension().isMobile(context) ? 13 : 19,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: AppColors.buttonGraidentColour,
                  //     borderRadius: BorderRadius.circular(20),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: AppColors.violetPrimaryColor.withOpacity(0.4),
                  //         blurRadius: 12,
                  //         offset: const Offset(0, 6),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Material(
                  //     color: Colors.transparent,
                  //     child: InkWell(
                  //       borderRadius: BorderRadius.circular(20),
                  //       onTap: () {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) => RegistrationAdd(),
                  //         );
                  //       },
                  //       child: const Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 10, vertical: 10),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Icon(
                  //               Icons.add_circle_outline,
                  //               color: Colors.white,
                  //               size: 20,
                  //             ),
                  //             SizedBox(width: 12),
                  //             CustomText(
                  //               text: 'Register',
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 15,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            // Container(
            //   width: double.maxFinite,
            //   padding:
            //       const EdgeInsets.only(top: 6, bottom: 8, left: 15, right: 15),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: const BorderRadius.only(
            //         bottomLeft: Radius.circular(20),
            //         bottomRight: Radius.circular(20)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.05),
            //         blurRadius: 20,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: [
            //               _buildFilterChip(
            //                 icon: Icons.all_inclusive,
            //                 text: 'All Leads',
            //                 count: 128,
            //                 color: AppColors.primaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'all',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('all');

            //                   // setState(() => selectedFilter = 'all')
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.fiber_new,
            //                 text: 'New',
            //                 count: 10,
            //                 color: AppColors.blueSecondaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'new',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('new');

            //                   // setState(() => selectedFilter = 'all')
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.today,
            //                 text: 'Today',
            //                 count: 24,
            //                 color: AppColors.greenSecondaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'today',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('today');

            //                   // setState(() => selectedFilter = 'all')
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.schedule,
            //                 text: 'Pending',
            //                 count: 8,
            //                 color: AppColors.orangeSecondaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'pending',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('pending');

            //                   // setState(() => selectedFilter = 'all')
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.trending_up,
            //                 text: 'Hot Leads',
            //                 count: 15,
            //                 color: AppColors.redSecondaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'hot',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('hot');

            //                   // setState(() => selectedFilter = 'hot')
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.history,
            //                 text: 'Converted',
            //                 count: 156,
            //                 color: AppColors.viloletSecondaryColor,
            //                 isSelected:
            //                     Provider.of<RegistrationController>(context)
            //                             .selectedCategory ==
            //                         'converted',
            //                 onTap: () {
            //                   Provider.of<RegistrationController>(context,
            //                           listen: false)
            //                       .setSelectedCategory('converted');

            //                   // setState(() => selectedFilter = 'converted')
            //                 },
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        // controller: controller.searchController,
                        decoration: InputDecoration(
                          hintText: "Search Leads...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                          hoverColor: Colors.white,
                          fillColor: AppColors.whiteMainColor,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search,
                                size: 20, color: Colors.grey),
                            onPressed: () {
                              // print(
                              //     "Search query: ${_searchController.text}");
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 0.3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _buildFilterToggleButton(context),
              ],
            ),
            _buildFilterPanel(context),
            // Main content area

            // final userList = controller.userList.value;
            // if (userList == null || userList.data.isEmpty) {
            // return const SizedBox();
            // }
            Container(
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
                    child: RegisterUserListTable(
                        userlist:
                            Provider.of<RegistrationController>(context).leads),
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
                          color: AppColors.textGrayColour.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: AppColors.blackGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.analytics_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      "${Provider.of<RegistrationController>(context).leads.length} Leads",
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // CustomPager(
                        //   currentPage: controller.currentPage.value + 1,
                        //   totalPages: min(userList.totalItems, 100),
                        //   onPageSelected: (page) {
                        //     if (controller.currentPage.value != page - 1) {
                        //       controller.currentPage.value = page - 1;
                        //       controller.onPageSelected(page - 1);
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )

            /* Expanded(
              child: Obx(() {
                final userList = controller.userList.value;
                if (userList == null || userList.data.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: RegisterUserListTable(userlist: userList.data)),
                      // Footer
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "${userList.totalItems} Total",
                              color: Colors.black38,
                            ),
                            CustomPager(
                              currentPage: controller.currentPage.value + 1,
                              totalPages: min(userList.totalItems, 100),
                              onPageSelected: (page) {
                                if (controller.currentPage.value != page - 1) {
                                  controller.currentPage.value = page - 1;
                                  controller.onPageSelected(page - 1);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ), */
          ],
        ),
      ),
    );
  }

  void applyFilters(BuildContext context) {
    Provider.of<RegistrationController>(context, listen: false)
        .setIsFilterActive(true);
    // controller.fetchLeadsWithFilters(selectedFilters);
  }

  Widget _buildFilterPanel(BuildContext context) {
    // return Obx(() => AnimatedContainer(
    //       duration: const Duration(milliseconds: 300),
    //       height: showFilters.value ? null : 0,
    //       child: Container(
    //         margin: const EdgeInsets.only(bottom: 12, top: 12),
    //         padding: const EdgeInsets.all(15),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withOpacity(0.05),
    //               blurRadius: 10,
    //               offset: const Offset(0, 4),
    //             ),
    //           ],
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             // Filter Header
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Container(
    //                       padding: const EdgeInsets.all(10),
    //                       decoration: BoxDecoration(
    //                         color: AppColors.primaryColor.withOpacity(0.1),
    //                         borderRadius: BorderRadius.circular(12),
    //                       ),
    //                       child: const Icon(
    //                         Icons.filter_list,
    //                         color: AppColors.primaryColor,
    //                         size: 18,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 12),
    //                     const CustomText(
    //                       text: "Advanced Filters",
    //                       fontWeight: FontWeight.w700,
    //                       fontSize: 16,
    //                     ),
    //                   ],
    //                 ),
    //                 IconButton(
    //                   icon: const Icon(Icons.close, size: 20),
    //                   onPressed: () => showFilters.value = false,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 20),
    //
    //             // Filter Categories
    //             Wrap(
    //               spacing: 16,
    //               runSpacing: 20,
    //               children: filterCategories.map((category) {
    //                 return SizedBox(
    //                   width: 200,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       CustomText(
    //                         text: category,
    //                         fontWeight: FontWeight.w600,
    //                         color: AppColors.textColor,
    //                         fontSize: 14,
    //                       ),
    //                       const SizedBox(height: 8),
    //                       Container(
    //                         padding: const EdgeInsets.symmetric(horizontal: 12),
    //                         decoration: BoxDecoration(
    //                           border: Border.all(
    //                             color: Colors.grey.shade300,
    //                             width: 1,
    //                           ),
    //                           borderRadius: BorderRadius.circular(12),
    //                         ),
    //                         child: DropdownButtonHideUnderline(
    //                           child: DropdownButton<String>(
    //                             isExpanded: true,
    //                             value: selectedFilters[category],
    //                             items: filterOptions[category]?.map((option) {
    //                               return DropdownMenuItem<String>(
    //                                 value: option,
    //                                 child: CustomText(
    //                                   text: option,
    //                                   fontSize: 14,
    //                                 ),
    //                               );
    //                             }).toList(),
    //                             onChanged: (value) {
    //                               if (value != null) {
    //                                 selectedFilters[category] = value;
    //                               }
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               }).toList(),
    //             ),
    //
    //             const SizedBox(height: 24),
    //
    //             // Filter Actions
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 OutlinedButton(
    //                   onPressed: resetFilters,
    //                   style: OutlinedButton.styleFrom(
    //                     side: const BorderSide(color: AppColors.primaryColor),
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 16, vertical: 12),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(12),
    //                     ),
    //                   ),
    //                   child: const CustomText(
    //                     text: "Reset",
    //                     color: AppColors.primaryColor,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 12),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     applyFilters();
    //                     showFilters.value = false;
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: AppColors.primaryColor,
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 16, vertical: 12),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(12),
    //                     ),
    //                   ),
    //                   child: const CustomText(
    //                     text: "Apply Filters",
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height:
          Provider.of<RegistrationController>(context, listen: true).showFilters
              ? null
              : 0,
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
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Provider.of<RegistrationController>(context,
                          listen: false)
                      .setShowFilters(false),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                ...filterOptions.keys.map((category) {
                  // print("0000000000000000000000000000000000000000000");
                  // print(category);
                  // print("0000000000000000000000000000000000000000000");

                  return SizedBox(
                    width: 180,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: CustomText(
                                text: category,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor,
                                fontSize: 14,
                              ),
                              isExpanded: true,
                              value:
                                  Provider.of<RegistrationController>(context)
                                      .selectedCategory,
                              items: []
                                  ?.toSet()
                                  .map((option) => DropdownMenuItem<String>(
                                        value: option,
                                        child: CustomText(
                                            text: option, fontSize: 14),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  Provider.of<RegistrationController>(context)
                                      .setSelectedCategory(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
                OutlinedButton(
                  onPressed: () => resetFilters(context),
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
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    applyFilters(context);
                    // showFilters.value = false;
                    Provider.of<RegistrationController>(context)
                        .setShowFilters(true);
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterToggleButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<RegistrationController>(context, listen: false)
          .setShowFilters(
              !Provider.of<RegistrationController>(context, listen: false)
                  .showFilters),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Provider.of<RegistrationController>(context).isFilterActive
                ? AppColors.primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Provider.of<RegistrationController>(context).isFilterActive
                  ? AppColors.primaryColor
                  : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              if (Provider.of<RegistrationController>(context).isFilterActive)
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
                color:
                    Provider.of<RegistrationController>(context).isFilterActive
                        ? Colors.white
                        : AppColors.primaryColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              CustomText(
                text: "Filters",
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color:
                    Provider.of<RegistrationController>(context).isFilterActive
                        ? Colors.white
                        : AppColors.primaryColor,
              ),
              if (Provider.of<RegistrationController>(context)
                  .isFilterActive) ...[
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
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? color : color.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : color,
                  size: 16,
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: text,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.primaryColor,
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    text: count.toString(),
                    color: isSelected ? Colors.white : color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetFilters(BuildContext context) {
    Provider.of<RegistrationController>(context, listen: false)
        .setIsFilterActive(false);
    for (var category in filterCategories) {
      Provider.of<RegistrationController>(context, listen: false)
          .setSelectedCategory('all');
    }
    // controller.fetchLeads();
  }
}
