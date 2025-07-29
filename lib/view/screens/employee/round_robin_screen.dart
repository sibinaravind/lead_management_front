import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/lead/round_robin_controller.dart';
import 'package:overseas_front_end/view/screens/config/widget/action_button.dart';
import 'package:overseas_front_end/view/screens/employee/widget/add_officers.dart';
import 'package:overseas_front_end/view/screens/employee/widget/add_round_robin.dart';
import 'package:overseas_front_end/view/screens/employee/widget/round_robin_officer_list.dart';
import 'package:overseas_front_end/view/widgets/custom_button.dart';
import 'package:overseas_front_end/view/widgets/custom_popup.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import '../../../res/style/colors/colors.dart';
import '../../widgets/custom_toast.dart';

class RoundRobinScreen extends StatefulWidget {
  const RoundRobinScreen({super.key});

  @override
  State<RoundRobinScreen> createState() => _RoundRobinScreenState();
}

class _RoundRobinScreenState extends State<RoundRobinScreen> {
  final RoundRobinController controller = Get.find<RoundRobinController>();
  final ConfigController configController = Get.find<ConfigController>();

  @override
  void initState() {
    super.initState();
    controller.fetchRoundRobinGroups();
    configController.loadConfigData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteMainColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.roundRobinGroups.isEmpty) {
          return const Center(child: Text('No Groups Available'));
        }
        return SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: 200,
                    child: CustomButton(
                      text: "Add RoundRobin",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AddRoundRobinDialog(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.backgroundGraident,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.roundRobinGroups.length,
                  itemBuilder: (context, index) {
                    final group = controller.roundRobinGroups[index];
                    final officersList = group.officerDetails;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      elevation: 8,
                      shadowColor: AppColors.primaryColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.whiteMainColor,
                              AppColors.whiteMainColor.withOpacity(0.9),
                            ],
                          ),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.all(8),
                            childrenPadding: const EdgeInsets.all(8),
                            collapsedBackgroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            title: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(index),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _getCategoryColor(index)
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.group_add,
                                    color: AppColors.whiteMainColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.name?.toUpperCase() ?? '',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomText(
                                        text: group.country ?? '',
                                        color: AppColors.textGrayColour,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    ActionButton(
                                      icon: Icons.delete,
                                      gradient: AppColors.redGradient,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                              DeleteConfirmationDialog(
                                            title: "Delete",
                                            message: 'You want to delete',
                                            onConfirm: () async {
                                              final success = await controller
                                                  .deleteRoundRobin(
                                                      group.id ?? '');
                                              if (success) {
                                                CustomToast.showToast(
                                                    context: context,
                                                    message:
                                                        'Round robin deleted successfully');
                                              } else {
                                                CustomToast.showToast(
                                                    context: context,
                                                    message: 'Delete failed');
                                              }
                                            },
                                          ),
                                        );
                                      },
                                      tooltip: 'Delete',
                                    ),
                                    ActionButton(
                                      icon: Icons.add,
                                      gradient: AppColors.buttonGraidentColour,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AddOfficerDialog(
                                            roundRobinId: group.id,
                                          ),
                                        );
                                      },
                                      tooltip: 'Add Officer',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: [
                              ...officersList.map((item) {
                                return RoundRobinOfficerList(
                                  roundrobinId: group.id ?? '',
                                  item: item,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Color _getCategoryColor(int index) {
    // Just an example, you can customize
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal
    ];
    return colors[index % colors.length];
  }
}
