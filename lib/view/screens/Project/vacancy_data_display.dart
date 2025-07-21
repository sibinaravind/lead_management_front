import 'dart:math';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/screens/Project/widget/create_edit_vacancy_popup.dart';
import 'package:overseas_front_end/view/screens/project/widget/vacancy_user_list_table.dart';
import 'package:provider/provider.dart';

import '../../../controller/project/project_provider_controller.dart';
import '../../../res/style/colors/colors.dart';
import '../../../res/style/colors/dimension.dart';
import '../../widgets/widgets.dart';
import 'add_project_vacancy_screen.dart';
import 'widget/project_user_list_table.dart';

class VacancyDataDisplay extends StatefulWidget {
  VacancyDataDisplay({super.key});

  @override
  State<VacancyDataDisplay> createState() => _VacancyDataDisplayState();
}

class _VacancyDataDisplayState extends State<VacancyDataDisplay> {
  String selectedFilter = 'all';

  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false).fetchVacancies(
      context,
    );
    Provider.of<ProjectProvider>(context, listen: false).fetchClients(
      context,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
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
                          text: "Vacancy Management Dashboard",
                          color: AppColors.textWhiteColour,
                          fontSize: Dimension().isMobile(context) ? 13 : 19,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGraidentColour,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.violetPrimaryColor.withOpacity(0.4),
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
                                const CreateEditVacancyPopup(),
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
                                text: 'New Vacancy',
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
            //                 text: 'All',
            //                 count: 128,
            //                 color: AppColors.primaryColor,
            //                 isSelected: selectedFilter == 'all',
            //                 onTap: () {
            //                   setState(() {
            //                     selectedFilter = 'all';
            //                   });
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.fiber_new,
            //                 text: 'Government',
            //                 count: 10,
            //                 color: AppColors.blueSecondaryColor,
            //                 isSelected: selectedFilter == 'government',
            //                 onTap: () {
            //                   setState(() {
            //                     selectedFilter = 'government';
            //                   });
            //                 },
            //               ),
            //               _buildFilterChip(
            //                 icon: Icons.today,
            //                 text: 'Private',
            //                 count: 24,
            //                 color: AppColors.greenSecondaryColor,
            //                 isSelected: selectedFilter == 'private',
            //                 onTap: () {
            //                   setState(() {
            //                     selectedFilter = 'private';
            //                   });
            //                 },
            //               ),
            //               // _buildFilterChip(
            //               //   icon: Icons.today,
            //               //   text: 'Upcoming',
            //               //   count: 24,
            //               //   color: AppColors.orangeSecondaryColor,
            //               //   isSelected: selectedFilter == 'upcoming',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'upcoming';
            //               //     });
            //               //   },
            //               // ),
            //               // _buildFilterChip(
            //               //   icon: Icons.schedule,
            //               //   text: 'Pending',
            //               //   count: 8,
            //               //   color: AppColors.redSecondaryColor,
            //               //   isSelected: selectedFilter == 'pending',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'pending';
            //               //     });
            //               //   },
            //               // ),
            //               // _buildFilterChip(
            //               //   icon: Icons.history,
            //               //   text: 'Upcoming',
            //               //   count: 156,
            //               //   color: AppColors.skyBlueSecondaryColor,
            //               //   isSelected: selectedFilter == 'upcoming',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'upcoming';
            //               //     });
            //               //   },
            //               // ),
            //               // _buildFilterChip(
            //               //   icon: Icons.history,
            //               //   text: 'Converted',
            //               //   count: 156,
            //               //   color: AppColors.viloletSecondaryColor,
            //               //   isSelected: selectedFilter == 'converted',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'converted';
            //               //     });
            //               //   },
            //               // ),
            //               // _buildFilterChip(
            //               //   icon: Icons.trending_up,
            //               //   text: 'UnAssigned',
            //               //   count: 15,
            //               //   color: AppColors.textGrayColour,
            //               //   isSelected: selectedFilter == 'unassigned',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'unassigned';
            //               //     });
            //               //   },
            //               // ),
            //               // _buildFilterChip(
            //               //   icon: Icons.history,
            //               //   text: 'History',
            //               //   count: 156,
            //               //   color: AppColors.skyBlueSecondaryColor,
            //               //   isSelected: selectedFilter == 'history',
            //               //   onTap: () {
            //               //     setState(() {
            //               //       selectedFilter = 'history';
            //               //     });
            //               //   },
            //               // ),
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
                          hintText: "Search Vacancies...",
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
                // _buildFilterToggleButton(),
              ],
            ),
            // _buildFilterPanel(context),

            // Main content area
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
              child: Consumer<ProjectProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    // Table Header
                    // Table Content
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: VacancyUserListTable(userlist: value.vacancies),
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
                                    text: "${value.projects.length} Leads",
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
                            totalPages: min(value.clients.length, 100),
                            onPageSelected: (page) {
                              if (value.currentPage != page - 1) {
                                value.currentPage = page - 1;
                                // value.onPageSelected(page - 1);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    //   return Padding(
    //     padding: const EdgeInsets.all(15.0),
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const CustomText(
    //               text: "Projects",
    //               color: AppColors.primaryColor,
    //               fontSize: 17,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 shadowColor: AppColors.primaryColor,
    //                 backgroundColor: AppColors.blueGrayColour,
    //                 foregroundColor: Colors.white,
    //                 padding:
    //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //               ),
    //               onPressed: () {
    //                 // showDialog(
    //                 //   context: context,
    //                 //   builder: (context) => RegistrationAdd(),
    //                 // );
    //               },
    //               child: const CustomText(
    //                 text: 'Add Project',
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             SizedBox(
    //               height: 35,
    //               width: 250,
    //               child: CustomTextField(
    //                 controller: controller.searchController,
    //                 labelText: "Search...",
    //                 validator: (v) {
    //                   return null;
    //                 },
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: SizedBox(
    //                 width: 100,
    //                 height: 40,
    //                 child: CustomButton(
    //                     text: "Search",
    //                     color: AppColors.darkVioletColour,
    //                     fontSize: 12,
    //                     onTap: () {
    //                       controller.searchController.text.isNotEmpty
    //                           ? controller.fetchData(
    //                               search: controller.searchController.text,
    //                             )
    //                           : controller.fetchData();
    //                     }),
    //               ),
    //             ),
    //           ],
    //         ),

    //         // Main content area
    //         Expanded(
    //           child: Obx(() {
    //             final userList = controller.userList.value;
    //             if (userList == null || userList.data.isEmpty) {
    //               return const Center(child: Text('No data available'));
    //             }

    //             return Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   ProjectUserListTable(userlist: userList.data),
    //                   // Footer
    //                   Padding(
    //                     padding: const EdgeInsets.all(10.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         CustomText(
    //                           text: "${userList.totalItems} Total",
    //                           color: Colors.black38,
    //                         ),
    //                         CustomPager(
    //                           currentPage: controller.currentPage.value + 1,
    //                           totalPages: min(userList.totalItems, 100),
    //                           onPageSelected: (page) {
    //                             if (controller.currentPage.value != page - 1) {
    //                               controller.currentPage.value = page - 1;
    //                               controller.onPageSelected(page - 1);
    //                             }
    //                           },
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           }),
    //         ),
    //       ],
    //     ),
    //   );
    // }
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
}
