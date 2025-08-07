import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../utils/style/colors/colors.dart';
import '../../../utils/style/colors/dimension.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/customer_filter_chip.dart';
import 'add_lead_screen.dart';
import 'widgets/bulk_lead.dart';
import 'widgets/lead_user_list_table.dart';

class LeadDataDisplay extends StatefulWidget {
  const LeadDataDisplay({super.key});
  @override
  State<LeadDataDisplay> createState() => _LeadDataDisplayState();
}

class _LeadDataDisplayState extends State<LeadDataDisplay> {
  final leadController = Get.find<LeadController>();
  final officersController = Get.find<OfficersController>();
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

      fetchData();
    });
  }

  Future<void> fetchConfig() async {
    await configController.loadConfigData();
    await Get.find<OfficersController>().fetchOfficersList();
    filterOptions = {
      'Status': configController.configData.value.clientStatus
              ?.map((item) => "${item.name}")
              .toList() ??
          [],
      'Country': configController.configData.value.country
              ?.map((item) => "${item.name}")
              .toList() ??
          [],
      'Officers': officersController.officersList.value
              .map((item) => "${item.name}")
              .toList() ??
          [],
    };
    setState(() {});
  }

  Map<String, dynamic> buildQueryParams() {
    final params = {
      "page": page.toString(),
      "limit": limit.toString(),
    };

    if (leadController.selectedFilter.isNotEmpty) {
      params["filterCategory"] = leadController.selectedFilter.value;
    }
    if (searchController.text.trim().isNotEmpty) {
      params["searchString"] = searchController.text.trim();
    }

    selectedFilters.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        switch (key) {
          case "Status":
            params["status"] = value;
            break;
          case "Officers":
            params["employee"] = value;
            break;
          case "Country":
            params["country"] = value;
            break;
          case "startDate":
            params["startDate"] = value;
            break;
          case "endDate":
            params["endDate"] = value;
            break;
        }
      }
    });

    return params;
  }

  void fetchData() {
    final params = buildQueryParams();
    leadController.fetchMatchingClients(filterSelected: params);
  }

  void applyFilters() {
    isFilterActive.value = true;
    page = 1;
    fetchData();
    showFilters.value = false;
  }

  void cleardata() {
    leadController.selectedFilter.value = '';
    isFilterActive.value = false;
    selectedFilters.clear();
    searchController.clear();
    page = 1;
  }

  void resetFilters() {
    leadController.selectedFilter.value = '';
    isFilterActive.value = false;
    selectedFilters.clear();
    searchController.clear();
    page = 1;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
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
                              text: "Lead Management Dashboard",
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
                                builder: (context) => const BulkLeadScreen(),
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
                                builder: (context) => const AddLeadScreen(),
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
                                isSelected:
                                    leadController.selectedFilter.value == '',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value = '';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.fiber_new,
                                text: 'New',
                                count: 10,
                                color: AppColors.blueSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'NEW',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value = 'NEW';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.today,
                                text: 'Today',
                                count: 24,
                                color: AppColors.greenSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'TODAY',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'TODAY';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.today,
                                text: 'Tommorrow',
                                count: 24,
                                color: AppColors.orangeSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'TOMORROW',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'TOMORROW';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.schedule,
                                text: 'Pending',
                                count: 8,
                                color: AppColors.redSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'PENDING',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'PENDING';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.history,
                                text: 'Upcoming',
                                count: 156,
                                color: AppColors.skyBlueSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'UPCOMING',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'UPCOMING';
                                  });
                                  fetchData();
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
                                    leadController.selectedFilter.value ==
                                        'UNASSIGNED',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'UNASSIGNED';
                                  });
                                  fetchData();
                                },
                              ),
                              CustomFilterChip(
                                icon: Icons.history,
                                text: 'History',
                                count: 156,
                                color: AppColors.skyBlueSecondaryColor,
                                isSelected:
                                    leadController.selectedFilter.value ==
                                        'HISTORY',
                                onTap: () {
                                  cleardata();
                                  setState(() {
                                    leadController.selectedFilter.value =
                                        'HISTORY';
                                  });
                                  fetchData();
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
                    SearchBarWidget(
                      controller: searchController,
                      onSearch: () {
                        page = 1;
                        fetchData();
                      },
                    ),
                    Obx(() => FilterToggleButtonsWidget(
                          isFilterActive: isFilterActive.value,
                          onReset: () {
                            if (isFilterActive.value ||
                                searchController.text.isNotEmpty) {
                              resetFilters();
                            }
                          },
                          onToggle: () =>
                              showFilters.value = !showFilters.value,
                        )),
                  ],
                ),
                Obx(() => FilterPanelWidget(
                      showFilters: showFilters.value,
                      filterOptions: filterOptions,
                      selectedFilters: selectedFilters,
                      onFilterChange: (newFilters) {
                        selectedFilters.value = newFilters;
                      },
                      dateFilter: true,
                      onApply: () {
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
                      },
                      onClose: () => showFilters.value = false,
                    )),

                // 📊 Leads table + Pagination
                Obx(() {
                  final customerList =
                      leadController.customerMatchingList.value.leads;

                  if (customerList == null || customerList.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CustomText(text: "No matching leads found"),
                    );
                  }

                  return Container(
                    width: double.infinity,
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: LeadUserListTable(
                            userlist: leadController
                                    .customerMatchingList.value.leads ??
                                [],
                          ),
                        ),
                        PaginationFooterWidget(
                          currentPage: page,
                          totalPages: leadController
                                  .customerMatchingList.value.totalPages ??
                              1,
                          totalItems: leadController
                                  .customerMatchingList.value.totalMatch ??
                              0,
                          onPageSelected: (newPage) {
                            if (page != newPage) {
                              setState(() {
                                page = newPage;
                              });
                              fetchData();
                            }
                          },
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
