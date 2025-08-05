import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../../utils/style/colors/colors.dart';
import '../shortlist_user_list_table.dart';

class ShortListedtab extends StatefulWidget {
  const ShortListedtab({super.key});

  @override
  State<ShortListedtab> createState() => _ShortListedtabState();
}

class _ShortListedtabState extends State<ShortListedtab> {
  final projectController = Get.find<ProjectController>();
  final isFilterActive = false.obs;
  final int page = 1;
  final int limit = 10;
  final showFilters = false.obs;

  TextEditingController dateController = TextEditingController();

  DateTimeRange? selectedRange;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchConfig();
    });
  }

  Future<void> fetchConfig() async {
    projectController.fetchShortListed();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
              ],
            ),
            Obx(() {
              final customerList = projectController.favouriteClients;
              if (customerList.isEmpty) {
                return const SizedBox(
                  height: double.maxFinite,
                );
              }
              return Container(
                height: double.maxFinite,
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
                    SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ShortlistUserListTable(
                            userlist: customerList ?? []),
                      ),
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
                                        "${projectController.favouriteClients.length} Leads",
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
