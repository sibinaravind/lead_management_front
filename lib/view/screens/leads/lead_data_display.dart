import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../widgets/custom_toast.dart';
import 'widgets/lead_user_list_table.dart';

class LeadDataDisplay extends StatefulWidget {
  const LeadDataDisplay({super.key});

  @override
  State<LeadDataDisplay> createState() => _LeadDataDisplayState();
}

class _LeadDataDisplayState extends State<LeadDataDisplay> {
  final leadController = Get.find<LeadController>();
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

  void resetFilters() {
    isFilterActive.value = false;
    selectedFilters.clear();
    searchController.clear();
    page = 1;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        onToggle: () => showFilters.value = !showFilters.value,
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
                          userlist:
                              leadController.customerMatchingList.value.leads ??
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
    );
  }
}
