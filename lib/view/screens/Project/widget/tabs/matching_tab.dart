import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../../utils/style/colors/colors.dart';
import '../../../../widgets/custom_toast.dart';
import '../matching_user_list_table.dart';

class MatchingTab extends StatefulWidget {
  const MatchingTab({super.key});

  @override
  State<MatchingTab> createState() => _MatchingTabState();
}

class _MatchingTabState extends State<MatchingTab> {
  final projectController = Get.find<ProjectController>();
  final configController = Get.find<ConfigController>();

  var filterOptions = <String, List<String>>{};
  var selectedFilters = <String, dynamic>{}.obs;
  final isFilterActive = false.obs;
  final showFilters = false.obs;

  int page = 1;
  int limit = 10;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchConfig();
      fetchData(); // Load first page initially
    });
  }

  Future<void> fetchConfig() async {
    await configController.loadConfigData();
    filterOptions = {
      'Qualification': configController.configData.value.program
              ?.map((item) => "${item.name}")
              .toList() ??
          [],
      'Country': configController.configData.value.country
              ?.map((item) => "${item.name}")
              .toList() ??
          [],
      'Specialization': configController.configData.value.specialized
              ?.map((item) => "${item.name}")
              .toList() ??
          [],
    };
    setState(() {});
  }

  /// Builds the filter + pagination params for API
  Map<String, dynamic> buildQueryParams() {
    final params = {
      "page": page.toString(),
      "limit": limit.toString(),
    };

    if (searchController.text.trim().isNotEmpty) {
      params["searchString"] = searchController.text.trim();
    }

    selectedFilters.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        switch (key) {
          case "Qualification":
            params["qualifications"] = value;
            break;
          case "Country":
            params["country"] = value;
            break;
          case "Specialization":
            params["specialization"] = value;
            break;
        }
      }
    });

    return params;
  }

  /// Fetches matching clients with current filters/pagination
  void fetchData() {
    final params = buildQueryParams();
    projectController.fetchMatchingClients(filterSelected: params);
  }

  void applyFilters() {
    isFilterActive.value = true;
    page = 1; // reset page when filtering
    fetchData();
    showFilters.value = false;
  }

  void resetFilters() {
    isFilterActive.value = false;
    selectedFilters.clear();
    searchController.clear();
    page = 1;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildSearchAndFilterRow(),
            _buildFilterPanel(context),
            Obx(() {
              final customerList =
                  projectController.customerMatchingList.value.leads;

              if (customerList == null || customerList.isEmpty) {
                return SizedBox(
                  height: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomText(text: "No matching leads found"),
                  ),
                );
              }

              return Container(
                width: double.infinity,
                height: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: 700,
                ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: MatchingUserListTable(
                        userlist: projectController
                                .customerMatchingList.value.leads ??
                            [],
                        // pass full LeadListModel
                      ),
                    ),
                    _buildPaginationFooter()
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Search bar + filter button
  Widget _buildSearchAndFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 300,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Leads...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, size: 20, color: Colors.grey),
                  onPressed: () {
                    page = 1;
                    fetchData();
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildFilterToggleButton(),
      ],
    );
  }

  Widget _buildFilterPanel(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: showFilters.value ? null : 0,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // OutlinedButton(
                        //   onPressed: resetFilters,
                        //   style: OutlinedButton.styleFrom(
                        //     side: const BorderSide(color: AppColors.primaryColor),
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 16, vertical: 12),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        //   child: const CustomText(
                        //     text: "Reset",
                        //     color: AppColors.primaryColor,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedFilters.isEmpty &&
                                searchController.text.trim().isEmpty) {
                              CustomToast.showToast(
                                context: context,
                                message:
                                    "Please select at least one filter or enter a search term",
                              );
                              return;
                            }
                            applyFilters();
                            showFilters.value = false;
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
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => showFilters.value = false,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    if (filterOptions != null)
                      ...filterOptions.keys.map((category) {
                        return SizedBox(
                          width: 180,
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                    value: selectedFilters[category],
                                    items: filterOptions[category]
                                        ?.toSet()
                                        .map((option) =>
                                            DropdownMenuItem<String>(
                                              value: option,
                                              child: CustomText(
                                                  text: option, fontSize: 14),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        selectedFilters[category] = value;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
              ],
            ),
          ),
        ));
  }

  /// Filter toggle button
  Widget _buildFilterToggleButton() {
    return Obx(() => Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isFilterActive.value || searchController.text.isNotEmpty) {
                  resetFilters();
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isFilterActive.value
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isFilterActive.value
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: isFilterActive.value
                          ? Colors.white
                          : AppColors.primaryColor,
                      size: 18,
                    ),
                    CustomText(
                      text: "Reset",
                      color: isFilterActive.value
                          ? Colors.white
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () => showFilters.value = !showFilters.value,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isFilterActive.value
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isFilterActive.value
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: isFilterActive.value
                          ? Colors.white
                          : AppColors.primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      text: "Filters",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isFilterActive.value
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  /// Pagination footer
  Widget _buildPaginationFooter() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text:
                "${projectController.customerMatchingList.value.totalMatch ?? 0} Leads",
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          CustomPager(
            currentPage: page,
            totalPages: min(
                projectController.customerMatchingList.value.totalPages ?? 1,
                100),
            onPageSelected: (newPage) {
              if (page != newPage) {
                setState(() {
                  page = newPage;
                });
                fetchData();
              }
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/project/project_controller.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import 'dart:math';
// import '../../../../../utils/style/colors/colors.dart';
// import '../matching_user_list_table.dart';

// class MatchingTab extends StatefulWidget {
//   const MatchingTab({super.key});

//   @override
//   State<MatchingTab> createState() => _MatchingTabState();
// }

// class _MatchingTabState extends State<MatchingTab> {
//   final projectController = Get.find<ProjectController>();
//   final configController = Get.find<ConfigController>();
//   var filterOptions = <String, List<String>>{};
//   var selectedFilters = <String, dynamic>{}.obs;
//   final isFilterActive = false.obs;
//   final int page = 1;
//   final int limit = 10;
//   final showFilters = false.obs;

//   TextEditingController dateController = TextEditingController();

//   DateTimeRange? selectedRange;

//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await fetchConfig();
//     });
//   }

//   Future<void> fetchConfig() async {
//     projectController.fetchMatchingClients();
//     await configController.loadConfigData();
//     filterOptions = {
//       'Qualification': configController.configData.value.program
//               ?.map((item) => "${item.name}")
//               .toList() ??
//           [],
//       'Country': configController.configData.value.country
//               ?.map((item) => "${item.name}")
//               .toList() ??
//           [],
//       'Specialization': configController.configData.value.specialized
//               ?.map((item) => "${item.name}")
//               .toList() ??
//           [],
//     };
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: SizedBox(
//                     width: 300,
//                     height: 40,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: TextField(
//                         // controller: controller.searchController,
//                         decoration: InputDecoration(
//                           hintText: "Search Leads...",
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade500,
//                             fontSize: 15,
//                           ),
//                           hoverColor: Colors.white,
//                           fillColor: AppColors.whiteMainColor,
//                           filled: true,
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.search,
//                                 size: 20, color: Colors.grey),
//                             onPressed: () {
//                               // print(
//                               //     "Search query: ${_searchController.text}");
//                             },
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(
//                               color: Colors.black,
//                               width: 0.3,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(
//                               color: AppColors.primaryColor,
//                               width: 1,
//                             ),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 _buildFilterToggleButton(),
//               ],
//             ),
//             _buildFilterPanel(context),
//             Obx(() {
//               final customerList =
//                   projectController.customerMatchingList.value.leads;
//               if (customerList == null || customerList.isEmpty ?? false) {
//                 return const SizedBox(
//                   height: double.maxFinite,
//                 );
//               }
//               return Container(
//                 width: double.maxFinite,
//                 margin: const EdgeInsets.only(top: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 20,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Table Header
//                     // Table Content
//                     SingleChildScrollView(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child:
//                             MatchingUserListTable(userlist: customerList ?? []),
//                       ),
//                     ),

//                     // Footer with Pagination
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF8FAFC),
//                         borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20),
//                         ),
//                         border: Border(
//                           top: BorderSide(
//                             color: AppColors.textGrayColour.withOpacity(0.1),
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   gradient: AppColors.blackGradient,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Icon(
//                                   Icons.analytics_outlined,
//                                   color: Colors.white,
//                                   size: 18,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text:
//                                         "${projectController.customerMatchingList.value.totalMatch} Leads",
//                                     color: AppColors.primaryColor,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 15,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           CustomPager(
//                             currentPage: projectController
//                                     .customerMatchingList.value.page ??
//                                 0,
//                             totalPages: min(
//                                 projectController.customerMatchingList.value
//                                         .totalPages ??
//                                     1,
//                                 100),
//                             onPageSelected: (page) {
//                               if (projectController.currentPage.value !=
//                                   page - 1) {
//                                 projectController.currentPage.value = page - 1;
//                                 // controller.onPageSelected(page - 1);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   void applyFilters() {
//     isFilterActive.value = true;
//     projectController.fetchMatchingClients(filterSelected: selectedFilters);
//   }

//   Widget _buildFilterPanel(BuildContext context) {
//     return Obx(() => AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           height: showFilters.value ? null : 0,
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 12, top: 12),
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Filter Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.filter_list,
//                             color: AppColors.primaryColor,
//                             size: 18,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         const CustomText(
//                           text: "Advanced Filters",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, size: 20),
//                       onPressed: () => showFilters.value = false,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Wrap(
//                   spacing: 5,
//                   runSpacing: 5,
//                   children: [
//                     if (filterOptions != null)
//                       ...filterOptions.keys.map((category) {
//                         return SizedBox(
//                           width: 180,
//                           height: 50,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 5),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.grey.shade300,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     hint: CustomText(
//                                       text: category,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textColor,
//                                       fontSize: 14,
//                                     ),
//                                     isExpanded: true,
//                                     value: selectedFilters[category],
//                                     items: filterOptions[category]
//                                         ?.toSet()
//                                         .map((option) =>
//                                             DropdownMenuItem<String>(
//                                               value: option,
//                                               child: CustomText(
//                                                   text: option, fontSize: 14),
//                                             ))
//                                         .toList(),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         selectedFilters[category] = value;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                   ],
//                 ),

//                 const SizedBox(height: 5),
//                 // SizedBox(
//                 //   width: 250,
//                 //   height: 50,
//                 //   child: CustomDateRangeField(
//                 //     label: 'From-To date',
//                 //     controller: dateController,
//                 //     isRequired: true,
//                 //     onChanged: (range){
//                 //       selectedRange = range;
//                 //     },
//                 //   ),
//                 // ),

//                 const SizedBox(height: 10),

//                 // Filter Actions
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     OutlinedButton(
//                       onPressed: resetFilters,
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
//                     const SizedBox(width: 12),
//                     ElevatedButton(
//                       onPressed: () {
//                         applyFilters();
//                         showFilters.value = false;
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
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   Widget _buildFilterToggleButton() {
//     return Obx(() => GestureDetector(
//           onTap: () => showFilters.value = !showFilters.value,
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isFilterActive.value
//                     ? AppColors.primaryColor
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: isFilterActive.value
//                       ? AppColors.primaryColor
//                       : Colors.grey.shade300,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   if (isFilterActive.value)
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.filter_list,
//                     color: isFilterActive.value
//                         ? Colors.white
//                         : AppColors.primaryColor,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 8),
//                   CustomText(
//                     text: "Filters",
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                     color: isFilterActive.value
//                         ? Colors.white
//                         : AppColors.primaryColor,
//                   ),
//                   if (isFilterActive.value) ...[
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const CustomText(
//                         text: "Active",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   void resetFilters() {
//     isFilterActive.value = false;
//     // for (var category in filterCategories) {
//     selectedFilters.value = {};
//     // }
//     projectController.fetchMatchingClients();
//   }
// }
