import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/project/project_provider_controller.dart';
import '../../../res/style/colors/colors.dart';
import '../../../res/style/colors/dimension.dart';
import '../../widgets/widgets.dart';
import 'add_project_vacancy_screen.dart';
import 'widget/project_user_list_table.dart';

class ProjectDataDisplay extends StatefulWidget {
  ProjectDataDisplay({super.key});

  @override
  State<ProjectDataDisplay> createState() => _ProjectDataDisplayState();
}

class _ProjectDataDisplayState extends State<ProjectDataDisplay> {
  String selectedFilter = 'all';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false).fetchProjects(
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
                            builder: (context) => AddNewProject(
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
              padding:
                  const EdgeInsets.only(top: 6, bottom: 8, left: 15, right: 15),
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
                              Provider.of<ProjectProvider>(context,
                                      listen: false)
                                  .searchProjects('');
                            },
                          ),
                          _buildFilterChip(
                            icon: Icons.fiber_new,
                            text: 'Government',
                            count: 10,
                            color: AppColors.blueSecondaryColor,
                            isSelected: selectedFilter == 'government',
                            onTap: () {
                              setState(() {
                                selectedFilter = 'government';
                              });
                              Provider.of<ProjectProvider>(context,
                                      listen: false)
                                  .searchProjects('GOV');
                            },
                          ),
                          _buildFilterChip(
                            icon: Icons.today,
                            text: 'Private',
                            count: 24,
                            color: AppColors.greenSecondaryColor,
                            isSelected: selectedFilter == 'private',
                            onTap: () {
                              setState(() {
                                selectedFilter = 'private';
                              });
                              Provider.of<ProjectProvider>(context,
                                      listen: false)
                                  .searchProjects('PRIVATE');
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
                          Provider.of<ProjectProvider>(context, listen: false)
                              .searchProjects(value);
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
              child: Consumer<ProjectProvider>(
                builder: (context, value, child) => Column(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ProjectUserListTable(userlist: value.projects),
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
