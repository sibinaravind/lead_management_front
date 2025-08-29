import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/screens/team_lead/widgets/team_lead_display.dart';
import '../../../widgets/custom_text.dart';
import '../flavour/employee_flavour.dart';

class TeamLeadListTable extends StatelessWidget {
  final List<OfficerModel> userList;
  const TeamLeadListTable({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final List<Map<String, dynamic>> columnsData =
        EmployeeFlavour.userTableList();
    // GetX Controllers

    return LayoutBuilder(
      builder: (context, constraints) => Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 16.0,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => AppColors.primaryColor),
              columns: columnsData.map((column) {
                return DataColumn(
                  label: Flexible(
                    child: CustomText(
                      text: column['name'],
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhiteColour,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              rows: userList.isNotEmpty
                  ? userList.expand((listUser) {
                      return [
                        DataRow(
                          cells: columnsData.map((column) {
                            final extractor = column['extractor'] as Function;
                            final value = extractor(listUser);

                            return DataCell(
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 200,
                                  minWidth: 50,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    switch (column['name']) {
                                      case 'Status':
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: getColorBasedOnStatus(
                                              listUser.status ?? '',
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: CustomText(
                                            text: getTextBasedOnStatus(
                                              listUser.status ?? "",
                                            ),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        );
                                      case 'Phone Number':
                                        return SelectionArea(
                                          child: CustomText(
                                            text: value,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textColor,
                                          ),
                                        );
                                      case 'ID':
                                        return CustomText(
                                          text: value,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        );
                                      default:
                                        return CustomText(
                                          text: value,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.textColor,
                                        );
                                    }
                                  },
                                ),
                              ),
                              onTap: () {
                                if (column['name'] == 'ID') {
                                  // teamLeadController.getAllRemainingEmployees(
                                  //   context,
                                  //   listUser.officerId ?? '',
                                  //   officersController.allOfficersListData,
                                  // );

                                  showDialog(
                                    context: context,
                                    builder: (context) => TeamLeadDisplay(
                                      officerId: listUser.id ?? "",
                                    ),
                                  );
                                }
                              },
                            );
                          }).toList(),
                        )
                      ];
                    }).toList()
                  : [],
            ),
          ),
        ),
      ),
    );
  }
}

Color getColorBasedOnStatus(String status) {
  switch (status.toLowerCase()) {
    case 'blocked':
      return Colors.red.withOpacity(0.1);
    case 'unblocked':
    case 'reviewed':
      return Colors.green.withOpacity(0.1);
    case 'on_hold':
      return Colors.orange.withOpacity(0.1);
    default:
      return Colors.grey.withOpacity(0.1);
  }
}

String getTextBasedOnStatus(String status) {
  switch (status.toLowerCase()) {
    case 'blocked':
      return 'Blocked';
    case 'unblocked':
      return 'UnBlocked';
    case 'on_hold':
      return 'On Hold';
    case 'not_reviewed':
      return 'Not Reviewed';
    case 'reviewed':
      return 'Reviewed';
    default:
      return status;
  }
}
