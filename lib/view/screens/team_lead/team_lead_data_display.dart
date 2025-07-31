import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../../controller/team_lead/team_lead_controller.dart';
import '../../../model/officer/officer_model.dart';
import '../../widgets/widgets.dart';
import 'widgets/team_lead_display.dart';
import 'widgets/team_lead_user_list_table.dart';

class TeamLeadDataDisplay extends StatefulWidget {
  const TeamLeadDataDisplay({super.key});
  @override
  State<TeamLeadDataDisplay> createState() => _TeamLeadDataDisplayState();
}

class _TeamLeadDataDisplayState extends State<TeamLeadDataDisplay> {
  String selectedNewTeamLead = '';
  final teamLeadController = Get.put(TeamLeadController());
  final officersController = Get.put(OfficersController());
  final List<OfficerModel> _selectedOfficers = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch officers and team lead list
    officersController.fetchOfficersList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teamLeadController.fetchTeamLeadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: AppColors.blackGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
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
                            text: "Team Lead Management Dashboard",
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
                                color: AppColors.violetPrimaryColor
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
                              onTap: () async {
                                teamLeadController.getAllRemainingEmployees(
                                  context,
                                  '',
                                  officersController.officersList,
                                );

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Form(
                                      key: formKey,
                                      child: SizedBox(
                                        height: 200,
                                        width: 500,
                                        child: Column(
                                          children: [
                                            CustomDropdownField(
                                              label: "Select Team Lead",
                                              value: selectedNewTeamLead,
                                              isSplit: true,
                                              items: <String>[
                                                ...officersController
                                                    .officersList
                                                    .map((e) =>
                                                        "${e.name},${e.id}")
                                                    .toList()
                                              ],
                                              onChanged: (p0) {
                                                selectedNewTeamLead =
                                                    p0?.split(",").last ?? "";
                                              },
                                            ),
                                            // OfficerSelectDropdown(
                                            //   label: 'Select Officer',
                                            //   value: selectedNewTeamLead,
                                            //   items: <String>[
                                            //     ...officersController
                                            //         .officersList
                                            //         .map((e) =>
                                            //             "${e.name},${e.id}")
                                            //         .toList()
                                            //   ],
                                            //   onChanged: (value) => {
                                            //     print(value),
                                            //     setState(() =>
                                            //         selectedNewTeamLead =
                                            //             value ?? '')
                                            //   },
                                            //   isRequired: true,
                                            //   isSplit: true,
                                            //   prefixIcon: Icons.person_outline,
                                            //   enableSearch: true,
                                            // ),
                                            SizedBox(height: 16),
                                            CustomMultiOfficerSelectDropdownField(
                                                label: 'Team Members',
                                                selectedItems:
                                                    _selectedOfficers,
                                                items: officersController
                                                    .officersList,
                                                onChanged: (selectedIds) {
                                                  setState(() {
                                                    _selectedOfficers.clear();
                                                    _selectedOfficers
                                                        .addAll(selectedIds);
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: CustomText(
                                          text: 'Cancel',
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (selectedNewTeamLead.isEmpty ||
                                                _selectedOfficers.isEmpty) {
                                              CustomToast.showToast(
                                                context: context,
                                                message:
                                                    "Please select a team lead and at least one officer.",
                                              );
                                              return;
                                            }
                                            teamLeadController.createOfficer(
                                              context,
                                              selectedNewTeamLead,
                                              _selectedOfficers,
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.add, size: 18),
                                            SizedBox(width: 8),
                                            Text('Add Lead'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      text: 'Add Team Lead',
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
                                teamLeadController.filterEmployees(value);
                              },
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
                                  onPressed: () {
                                    teamLeadController.filterEmployees('');
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 0.3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor, width: 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// ------------------- TEAM LEAD LIST -------------------
                  Obx(() {
                    if (teamLeadController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (teamLeadController.teamLeadListData.isEmpty) {
                      return const Center(child: Text("No employees found."));
                    }
                    return Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
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
                            child: TeamLeadListTable(
                              userList: teamLeadController.teamLeadListData,
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
      ),
    );
  }
}
