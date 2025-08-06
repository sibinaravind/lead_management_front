import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/registration/registration_controller.dart';
import '../../../utils/style/colors/colors.dart';
import '../../../utils/style/colors/dimension.dart';
import '../../widgets/custom_toast.dart';
import 'widgets/register_user_list_table.dart';

class RegisterDataDisplay extends StatefulWidget {
  const RegisterDataDisplay({super.key});
  @override
  State<RegisterDataDisplay> createState() => _RegisterDataDisplayState();
}

class _RegisterDataDisplayState extends State<RegisterDataDisplay> {
  final registrationController = Get.find<RegistrationController>();
  final officersController = Get.find<OfficersController>();
  final configController = Get.find<ConfigController>();

  var filterOptions = <String, List<String>>{};
  var selectedFilters = <String, dynamic>{}.obs;
  final isFilterActive = false.obs;
  final showFilters = false.obs;
  String selectedFilter = '';

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

    if (selectedFilter.isNotEmpty) {
      params["filterCategory"] = selectedFilter;
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
        }
      }
    });

    return params;
  }

  void fetchData() {
    final params = buildQueryParams();
    registrationController.fetchMatchingClients(filterSelected: params);
  }

  void applyFilters() {
    isFilterActive.value = true;
    page = 1;
    fetchData();
    showFilters.value = false;
  }

  void cleardata() {
    selectedFilter = '';
    isFilterActive.value = false;
    selectedFilters.clear();
    searchController.clear();
    page = 1;
  }

  void resetFilters() {
    selectedFilter = '';
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
      body: SafeArea(
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
                            text: "Registration Management Dashboard",
                            color: AppColors.textWhiteColour,
                            fontSize: Dimension().isMobile(context) ? 13 : 19,
                            maxLines: 2,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
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
                    registrationController.customerMatchingList.value.leads;

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
                        child: RegisterUserListTable(
                          userlist: registrationController
                                  .customerMatchingList.value.leads ??
                              [],
                        ),
                      ),
                      PaginationFooterWidget(
                        currentPage: page,
                        totalPages: registrationController
                                .customerMatchingList.value.totalPages ??
                            1,
                        totalItems: registrationController
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
