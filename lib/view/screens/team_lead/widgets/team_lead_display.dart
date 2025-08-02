import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../../../controller/officers_controller/officers_controller.dart';
import '../../../../controller/team_lead/team_lead_controller.dart';
import '../../../widgets/widgets.dart';

class TeamLeadDisplay extends StatefulWidget {
  TeamLeadDisplay({
    super.key,
    required this.officerId,
  });

  final String officerId;

  @override
  State<TeamLeadDisplay> createState() => _TeamLeadDisplayState();
}

class _TeamLeadDisplayState extends State<TeamLeadDisplay> {
  final TeamLeadController controller = Get.put(TeamLeadController());
  List<OfficerModel> _selectedOfficers = [];
  final allOfficers = Get.find<OfficersController>();
  final OfficersController officersController = Get.put(OfficersController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5, // Reduced from default
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Enhanced Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                gradient: AppColors.buttonGraidentColour,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.groups, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CustomText(
                      text: 'Team Management',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: CustomOfficersFromList(
                        buttonText: 'Add Officers',
                        buttonIcon: Icons.people_alt,
                        selectedOfficers:
                            _selectedOfficers, // Your list of selected officers
                        allOfficers: allOfficers
                            .officersList, // Your complete list of officers
                        onOfficersSelected: (selectedOfficers) {
                          setState(() {
                            _selectedOfficers = selectedOfficers;
                          });
                        },
                        onSubmitted: () {
                          if (_selectedOfficers.isNotEmpty) {
                            controller.addOfficerToLead(
                              context,
                              widget.officerId,
                              List<OfficerModel>.from(_selectedOfficers),
                            );
                            _selectedOfficers.clear();
                          } else {
                            CustomToast.showToast(
                              message:
                                  'Please select at least one officer to add.',
                              context: context,
                            );
                          }
                        },
                        showSelectedCount: true,
                        buttonColor: AppColors
                            .blueSecondaryColor, // Optional custom color
                        buttonWidth: 200, // Optional custom width
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 8),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(Icons.add,
                      //           size: 16, color: Colors.blue.shade600),
                      //       const SizedBox(width: 4),
                      //       CustomText(
                      //         text: 'Add',
                      //         color: Colors.blue.shade600,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Enhanced Employee List
            Expanded(
              child: Obx(() {
                final teamLead = controller.teamLeadListData.firstWhere(
                  (element) => element.id == widget.officerId,
                  orElse: () => OfficerModel(),
                );

                if (teamLead.name == null ||
                    teamLead.officers?.isEmpty == true) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: teamLead.officers?.length ?? 0,
                  itemBuilder: (context, index) {
                    final officer = teamLead.officers?.elementAtOrNull(index);
                    return _buildEmployeeCard(context, officer);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          const CustomText(
            text: 'No employees assigned',
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          const CustomText(
            text: 'Add employees to start building your team',
            fontSize: 14,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(BuildContext context, dynamic officer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomText(
                  text: (officer?.name?[0] ?? "").toUpperCase(),
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Employee Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: officer?.name ?? "",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: CustomText(
                      text: officer?.officerId ?? "",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            // Delete Button
            Container(
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(Icons.delete_outline,
                    color: Colors.red.shade400, size: 18),
                tooltip: 'Remove Employee',
                onPressed: () =>
                    _showRemoveConfirmation(context, officer, widget.officerId),
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRemoveConfirmation(
      BuildContext context, dynamic officer, String teamOfficerId) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange.shade400, size: 24),
            const SizedBox(width: 8),
            const Text('Remove Employee'),
          ],
        ),
        content: Text(
          'Are you sure you want to remove "${officer?.name}" from this team?',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteOfficerFromLead(
                context,
                leadOfficerId: widget.officerId,
                officerId: officer?.id ?? "",
              );
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
