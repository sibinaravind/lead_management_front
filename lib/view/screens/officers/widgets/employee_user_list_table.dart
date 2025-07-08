import 'package:flutter/material.dart';
import '../../../../model/officer/officer_model.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';
import '../flavour/employee_flavour.dart';

class EmployeeListTable extends StatelessWidget {
  final List<OfficersModel> userList;
  const EmployeeListTable({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final List<Map<String, dynamic>> columnsData =
        EmployeeFlavour.userTableList();

    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width - 100),
          child: DataTable(
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
            rows: userList.expand((listUser) {
              return [
                DataRow(
                  cells: columnsData.map((column) {
                    final extractor = column['extractor'] as Function;
                    final value = extractor(listUser);
                    return DataCell(
                      Builder(
                        builder: (context) {
                          switch (column['name']) {
                            case 'Status':
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  ///---- status---------
                                  // color: getColorBasedOnStatus(
                                  //     Dimension.mobile ?? ''),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: CustomText(
                                  text: getTextBasedOnStatus(listUser.status),
                                  // text: getTextBasedOnStatus(
                                  //     listUser.mobile ?? ''),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  // color: getColorBasedOnStatus(
                                  //         listUser.mobile ?? '')
                                  //     .withOpacity(1.0),
                                ),
                              );
                            case 'Phone Number':
                              return SelectionArea(
                                  child: CustomText(
                                text: value,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.textColor,
                              ));
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
                      onTap: () {
                        if (column['name'] == 'ID') {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       const AddProjectVacancyScreen(),
                          // );
                        }
                      },
                    );
                  }).toList(),
                )
              ];
            }).toList(),
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
    case 'unblocked' || 'reviewed':
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
