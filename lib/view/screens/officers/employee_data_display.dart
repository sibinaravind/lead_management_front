import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/screens/officers/widgets/employee_user_list_table.dart';
import '../../../controller/officers_controller/officers_controller.dart';
import '../../../utils/style/colors/colors.dart';
import '../../widgets/widgets.dart';
import 'employee_creation_screen.dart';

class EmployeeDataDisplay extends StatefulWidget {
  const EmployeeDataDisplay({super.key});

  @override
  State<EmployeeDataDisplay> createState() => _EmployeeDataDisplayState();
}

class _EmployeeDataDisplayState extends State<EmployeeDataDisplay> {
  final OfficersController controller = Get.put(OfficersController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOfficersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Header
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
                        child: CustomText(
                          text: "Employee Management Dashboard",
                          color: AppColors.textWhiteColour,
                          maxLines: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
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
                                builder: (context) =>
                                    const EmployeeCreationScreen(isEdit: false),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 12),
                                  CustomText(
                                    text: 'Add Employee',
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

                const SizedBox(height: 12),

                /// Search Field
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
                            onChanged: (value) =>
                                controller.setSearchQuery(value),
                            decoration: InputDecoration(
                              hintText: "Search Employees...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 15,
                              ),
                              fillColor: AppColors.whiteMainColor,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search,
                                    size: 20, color: Colors.grey),
                                onPressed: () => controller.setSearchQuery(''),
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

                /// Employee Table
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ));
                  }

                  if (controller.filteredOfficersList.isEmpty) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text("No employees found."),
                    ));
                  }

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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: EmployeeListTable(
                            userList: controller.filteredOfficersList,
                          ),
                        ),
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
                                color: Colors.grey.withOpacity(0.1),
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
                                  CustomText(
                                    text:
                                        "${controller.filteredOfficersList.length} Employees",
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
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
        ),
      ),
    );
  }
}
