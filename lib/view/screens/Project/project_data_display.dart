import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/screens/Project/widget/add_edit_project.dart';
import '../../../controller/project/project_controller.dart';
import '../../../utils/style/colors/colors.dart';
import '../../../utils/style/colors/dimension.dart';
import '../../widgets/widgets.dart';
import 'widget/projec_user_list_table.dart';

class ProjectDataDisplay extends StatefulWidget {
  const ProjectDataDisplay({super.key});
  @override
  State<ProjectDataDisplay> createState() => _ProjectDataDisplayState();
}

class _ProjectDataDisplayState extends State<ProjectDataDisplay> {
  String selectedFilter = 'all';
  TextEditingController searchController = TextEditingController();
  final _projectController = Get.find<ProjectController>();

  @override
  void initState() {
    _projectController.fetchProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                            text: "Project Management Dashboard",
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
                            color:
                                AppColors.violetPrimaryColor.withOpacity(0.4),
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
                              builder: (context) => AddEditProject(
                                isEditMode: false,
                              ),
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
                                  text: 'New Project',
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
                            _buildFilterChip(
                              icon: Icons.all_inclusive,
                              text: 'All',
                              count: 128,
                              color: AppColors.primaryColor,
                              isSelected: selectedFilter == 'all',
                              onTap: () {
                                setState(() {
                                  selectedFilter = 'all';
                                });
                                _projectController.searchProjects();
                              },
                            ),
                            _buildFilterChip(
                              icon: Icons.fiber_new,
                              text: 'Government',
                              count: 10,
                              color: AppColors.blueSecondaryColor,
                              isSelected: selectedFilter == 'GOV',
                              onTap: () {
                                setState(() {
                                  selectedFilter = 'GOV';
                                });
                                _projectController.searchProjects(
                                    filter: 'GOV');
                              },
                            ),
                            _buildFilterChip(
                              icon: Icons.today,
                              text: 'Private',
                              count: 24,
                              color: AppColors.greenSecondaryColor,
                              isSelected: selectedFilter == 'PRIVATE',
                              onTap: () {
                                setState(() {
                                  selectedFilter = 'PRIVATE';
                                });
                                _projectController.searchProjects(
                                    filter: 'PRIVATE');
                              },
                            ),
                            // _buildFilterChip(
                            //   icon: Icons.today,
                            //   text: 'Upcoming',
                            //   count: 24,
                            //   color: AppColors.orangeSecondaryColor,
                            //   isSelected: selectedFilter == 'upcoming',
                            //   onTap: () {
                            //     setState(() {
                            //       selectedFilter = 'upcoming';
                            //     });
                            //   },
                            // ),
                            // _buildFilterChip(
                            //   icon: Icons.schedule,
                            //   text: 'Pending',
                            //   count: 8,
                            //   color: AppColors.redSecondaryColor,
                            //   isSelected: selectedFilter == 'pending',
                            //   onTap: () {
                            //     setState(() {
                            //       selectedFilter = 'pending';
                            //     });
                            //   },
                            // ),
                            // _buildFilterChip(
                            //   icon: Icons.history,
                            //   text: 'Upcoming',
                            //   count: 156,
                            //   color: AppColors.skyBlueSecondaryColor,
                            //   isSelected: selectedFilter == 'upcoming',
                            //   onTap: () {
                            //     setState(() {
                            //       selectedFilter = 'upcoming';
                            //     });
                            //   },
                            // ),
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
                            // _buildFilterChip(
                            //   icon: Icons.trending_up,
                            //   text: 'UnAssigned',
                            //   count: 15,
                            //   color: AppColors.textGrayColour,
                            //   isSelected: selectedFilter == 'unassigned',
                            //   onTap: () {
                            //     setState(() {
                            //       selectedFilter = 'unassigned';
                            //     });
                            //   },
                            // ),
                            // _buildFilterChip(
                            //   icon: Icons.history,
                            //   text: 'History',
                            //   count: 156,
                            //   color: AppColors.skyBlueSecondaryColor,
                            //   isSelected: selectedFilter == 'history',
                            //   onTap: () {
                            //     setState(() {
                            //       selectedFilter = 'history';
                            //     });
                            //   },
                            // ),
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
                  Flexible(
                    child: SizedBox(
                      width: 300,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: TextField(
                          onChanged: (value) {
                            _projectController.searchProjects(
                                filter: selectedFilter, query: value);
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Projects...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 15,
                            ),
                            hoverColor: Colors.white,
                            fillColor: AppColors.whiteMainColor,
                            filled: true,
                            suffixIcon: const Icon(Icons.search,
                                size: 20, color: Colors.grey),
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
                child: Obx(
                  () => Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ProjectUserListTable(
                            userlist: _projectController.filteredProjects),
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
                                          "${_projectController.filteredProjects.length} Projects",
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:overseas_front_end/view/screens/Project/widget/add_edit_project.dart';
// import 'package:overseas_front_end/view/screens/project/widget/add_client_screen.dart';
// import '../../../controller/project/project_controller.dart';
// import '../../../utils/style/colors/colors.dart';
// import '../../widgets/custom_text.dart';
// import 'widget/client_user_table_list.dart';
// import 'widget/projec_user_list_table.dart';

// class ProjectDataDisplay extends StatefulWidget {
//   const ProjectDataDisplay({super.key});

//   @override
//   State<ProjectDataDisplay> createState() => _ProjectDataDisplayState();
// }

// class _ProjectDataDisplayState extends State<ProjectDataDisplay> {
//   final TextEditingController _searchController = TextEditingController();
//   final _projectController = Get.find<ProjectController>();
//   DateTimeRange? selectedRange;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _projectController.fetchProjects();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.sizeOf(context).height,
//         decoration: const BoxDecoration(
//           gradient: AppColors.backgroundGraident,
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Enhanced Header Section
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 12),
//                     decoration: BoxDecoration(
//                       gradient: AppColors.blackGradient,
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.primaryColor.withOpacity(0.3),
//                           blurRadius: 20,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                               width: 1,
//                             ),
//                           ),
//                           child: const Icon(
//                             Icons.analytics_outlined,
//                             color: AppColors.textWhiteColour,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(width: 24),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomText(
//                                 text: "Project Management Dashboard",
//                                 color: AppColors.textWhiteColour,
//                                 // fontSize: Dimension.isMobile ? 13 : 19,
//                                 fontSize: 19,
//                                 maxLines: 2,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             gradient: AppColors.buttonGraidentColour,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.violetPrimaryColor
//                                     .withOpacity(0.4),
//                                 blurRadius: 12,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(20),
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AddEditProject(
//                                     isEditMode: false,
//                                   ),
//                                 );
//                               },
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 10),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.add_circle_outline,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                     SizedBox(width: 12),
//                                     CustomText(
//                                       text: 'New Project',
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: SizedBox(
//                           width: 300,
//                           height: 40,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: TextField(
//                               onChanged: (value) {
//                                 _projectController.searchClients(value);
//                               },
//                               controller: _searchController,
//                               decoration: InputDecoration(
//                                 hintText: "Search projects...",
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey.shade500,
//                                   fontSize: 15,
//                                 ),
//                                 hoverColor: Colors.white,
//                                 fillColor: AppColors.whiteMainColor,
//                                 filled: true,
//                                 suffixIcon: IconButton(
//                                   icon: const Icon(Icons.search,
//                                       size: 20, color: Colors.grey),
//                                   onPressed: () {
//                                     _projectController
//                                         .searchClients(_searchController.text);
//                                   },
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide: const BorderSide(
//                                     color: Colors.black,
//                                     width: 0.3,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide: const BorderSide(
//                                     color: AppColors.primaryColor,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 15,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // _buildFilterPanel(context),

//                   Obx(() {
//                     final projectList = _projectController.filteredProjects;
//                     if (_projectController.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (projectList.isEmpty) {
//                       return const Center(child: Text("No Projects are found"));
//                     }
//                     return Container(
//                       width: double.maxFinite,
//                       margin: const EdgeInsets.only(top: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 20,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: ProjectUserListTable(userlist: projectList),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF8FAFC),
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 bottomRight: Radius.circular(20),
//                               ),
//                               border: Border(
//                                 top: BorderSide(
//                                   color:
//                                       AppColors.textGrayColour.withOpacity(0.1),
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         gradient: AppColors.blackGradient,
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: const Icon(
//                                         Icons.analytics_outlined,
//                                         color: Colors.white,
//                                         size: 18,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         CustomText(
//                                           text:
//                                               "${projectList.length.toString()} Projects",
//                                           color: AppColors.primaryColor,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 15,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildFilterChip({
//   //   required IconData icon,
//   //   required String text,
//   //   required int count,
//   //   required Color color,
//   //   required bool isSelected,
//   //   required VoidCallback onTap,
//   // }) {
//   //   return Container(
//   //     margin: const EdgeInsets.only(right: 12),
//   //     child: Material(
//   //       color: Colors.transparent,
//   //       child: InkWell(
//   //         borderRadius: BorderRadius.circular(16),
//   //         onTap: onTap,
//   //         child: AnimatedContainer(
//   //           duration: const Duration(milliseconds: 200),
//   //           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//   //           decoration: BoxDecoration(
//   //             color: isSelected ? color : Colors.transparent,
//   //             borderRadius: BorderRadius.circular(16),
//   //             border: Border.all(
//   //               color: isSelected ? color : color.withOpacity(0.3),
//   //               width: 1.5,
//   //             ),
//   //             boxShadow: isSelected
//   //                 ? [
//   //               BoxShadow(
//   //                 color: color.withOpacity(0.3),
//   //                 blurRadius: 12,
//   //                 offset: const Offset(0, 4),
//   //               ),
//   //             ]
//   //                 : null,
//   //           ),
//   //           child: Row(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               Icon(
//   //                 icon,
//   //                 color: isSelected ? Colors.white : color,
//   //                 size: 16,
//   //               ),
//   //               const SizedBox(width: 8),
//   //               CustomText(
//   //                 text: text,
//   //                 fontWeight: FontWeight.w600,
//   //                 fontSize: 14,
//   //                 color: isSelected ? Colors.white : AppColors.primaryColor,
//   //               ),
//   //               const SizedBox(width: 12),
//   //               Container(
//   //                 padding:
//   //                 const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//   //                 decoration: BoxDecoration(
//   //                   color: isSelected
//   //                       ? Colors.white.withOpacity(0.2)
//   //                       : color.withOpacity(0.1),
//   //                   borderRadius: BorderRadius.circular(12),
//   //                 ),
//   //                 child: CustomText(
//   //                   text: count.toString(),
//   //                   color: isSelected ? Colors.white : color,
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.w700,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // void applyFilters() {
//   //   isFilterActive.value = true;
//   //   // controller.fetchLeadsWithFilters(selectedFilters);
//   // }
//   //
//   // Widget _buildFilterPanel(BuildContext context) {
//   //   return Obx(() => AnimatedContainer(
//   //     duration: const Duration(milliseconds: 300),
//   //     height: showFilters.value ? null : 0,
//   //     child: Container(
//   //       margin: const EdgeInsets.only(bottom: 12, top: 12),
//   //       padding: const EdgeInsets.all(15),
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         borderRadius: BorderRadius.circular(20),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black.withOpacity(0.05),
//   //             blurRadius: 10,
//   //             offset: const Offset(0, 4),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           // Filter Header
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Row(
//   //                 children: [
//   //                   Container(
//   //                     padding: const EdgeInsets.all(10),
//   //                     decoration: BoxDecoration(
//   //                       color: AppColors.primaryColor.withOpacity(0.1),
//   //                       borderRadius: BorderRadius.circular(12),
//   //                     ),
//   //                     child: const Icon(
//   //                       Icons.filter_list,
//   //                       color: AppColors.primaryColor,
//   //                       size: 18,
//   //                     ),
//   //                   ),
//   //                   const SizedBox(width: 12),
//   //                   const CustomText(
//   //                     text: "Advanced Filters",
//   //                     fontWeight: FontWeight.w700,
//   //                     fontSize: 16,
//   //                   ),
//   //                 ],
//   //               ),
//   //               IconButton(
//   //                 icon: const Icon(Icons.close, size: 20),
//   //                 onPressed: () => showFilters.value = false,
//   //               ),
//   //             ],
//   //           ),
//   //           const SizedBox(height: 10),
//   //           Wrap(
//   //             spacing: 5,
//   //             runSpacing: 5,
//   //             children: [
//   //               // Extra Widget
//   //
//   //               // Spread dynamic dropdowns
//   //               ...filterCategories.map((category) {
//   //                 return SizedBox(
//   //                   width: 180,
//   //                   height: 50,
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Container(
//   //                         padding:
//   //                         const EdgeInsets.symmetric(horizontal: 5),
//   //                         decoration: BoxDecoration(
//   //                           border: Border.all(
//   //                             color: Colors.grey.shade300,
//   //                             width: 1,
//   //                           ),
//   //                           borderRadius: BorderRadius.circular(12),
//   //                         ),
//   //                         child: DropdownButtonHideUnderline(
//   //                           child: DropdownButton<String>(
//   //                             hint: CustomText(
//   //                               text: category,
//   //                               fontWeight: FontWeight.w600,
//   //                               color: AppColors.textColor,
//   //                               fontSize: 14,
//   //                             ),
//   //                             isExpanded: true,
//   //                             value: selectedFilters[category],
//   //                             items: filterOptions[category]
//   //                                 ?.toSet()
//   //                                 .map((option) => DropdownMenuItem<String>(
//   //                               value: option,
//   //                               child: CustomText(
//   //                                   text: option, fontSize: 14),
//   //                             ))
//   //                                 .toList(),
//   //                             onChanged: (value) {
//   //                               if (value != null) {
//   //                                 selectedFilters[category] = value;
//   //                               }
//   //                             },
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 );
//   //               }).toList(),
//   //               SizedBox(
//   //                 width: 180,
//   //                 child: CustomDateRangeField(
//   //                   label: 'From-To date',
//   //                   controller: dateController,
//   //                   isRequired: true,
//   //                   // onChanged: (range) {
//   //                   //   selectedRange = range;
//   //                   // },
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //
//   //           const SizedBox(height: 5),
//   //           // SizedBox(
//   //           //   width: 250,
//   //           //   height: 50,
//   //           //   child: CustomDateRangeField(
//   //           //     label: 'From-To date',
//   //           //     controller: dateController,
//   //           //     isRequired: true,
//   //           //     onChanged: (range){
//   //           //       selectedRange = range;
//   //           //     },
//   //           //   ),
//   //           // ),
//   //
//   //           const SizedBox(height: 10),
//   //
//   //           // Filter Actions
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.end,
//   //             children: [
//   //               OutlinedButton(
//   //                 onPressed: resetFilters,
//   //                 style: OutlinedButton.styleFrom(
//   //                   side: const BorderSide(color: AppColors.primaryColor),
//   //                   padding: const EdgeInsets.symmetric(
//   //                       horizontal: 16, vertical: 12),
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(12),
//   //                   ),
//   //                 ),
//   //                 child: const CustomText(
//   //                   text: "Reset",
//   //                   color: AppColors.primaryColor,
//   //                   fontWeight: FontWeight.w600,
//   //                 ),
//   //               ),
//   //               const SizedBox(width: 12),
//   //               ElevatedButton(
//   //                 onPressed: () {
//   //                   applyFilters();
//   //                   showFilters.value = false;
//   //                 },
//   //                 style: ElevatedButton.styleFrom(
//   //                   backgroundColor: AppColors.primaryColor,
//   //                   padding: const EdgeInsets.symmetric(
//   //                       horizontal: 16, vertical: 12),
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(12),
//   //                   ),
//   //                 ),
//   //                 child: const CustomText(
//   //                   text: "Apply Filters",
//   //                   color: Colors.white,
//   //                   fontWeight: FontWeight.w600,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   ));
//   // }
//   //
//   // Widget _buildFilterToggleButton() {
//   //   return Obx(() => GestureDetector(
//   //     onTap: () => showFilters.value = !showFilters.value,
//   //     child: Align(
//   //       alignment: Alignment.centerRight,
//   //       child: Container(
//   //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//   //         decoration: BoxDecoration(
//   //           color: isFilterActive.value
//   //               ? AppColors.primaryColor
//   //               : Colors.white,
//   //           borderRadius: BorderRadius.circular(16),
//   //           border: Border.all(
//   //             color: isFilterActive.value
//   //                 ? AppColors.primaryColor
//   //                 : Colors.grey.shade300,
//   //             width: 1.5,
//   //           ),
//   //           boxShadow: [
//   //             if (isFilterActive.value)
//   //               BoxShadow(
//   //                 color: AppColors.primaryColor.withOpacity(0.3),
//   //                 blurRadius: 8,
//   //                 offset: const Offset(0, 4),
//   //               ),
//   //           ],
//   //         ),
//   //         child: Row(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Icon(
//   //               Icons.filter_list,
//   //               color: isFilterActive.value
//   //                   ? Colors.white
//   //                   : AppColors.primaryColor,
//   //               size: 18,
//   //             ),
//   //             const SizedBox(width: 8),
//   //             CustomText(
//   //               text: "Filters",
//   //               fontWeight: FontWeight.w600,
//   //               fontSize: 14,
//   //               color: isFilterActive.value
//   //                   ? Colors.white
//   //                   : AppColors.primaryColor,
//   //             ),
//   //             if (isFilterActive.value) ...[
//   //               const SizedBox(width: 8),
//   //               Container(
//   //                 padding: const EdgeInsets.symmetric(
//   //                     horizontal: 8, vertical: 2),
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.white.withOpacity(0.2),
//   //                   borderRadius: BorderRadius.circular(10),
//   //                 ),
//   //                 child: const CustomText(
//   //                   text: "Active",
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.w600,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ],
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   ));
//   // }
//   //
//   // void resetFilters() {
//   //   isFilterActive.value = false;
//   //   for (var category in filterCategories) {
//   //     selectedFilters[category] = 'All';
//   //   }
//   //   // controller.fetchLeads();
//   // }
// }
