import 'dart:math';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/screens/officers/employee_creation_screen.dart';
import 'package:overseas_front_end/view/screens/officers/widgets/reset_password.dart';
import 'package:provider/provider.dart';
import '../../../../controller/officers_controller/officers_controller.dart';
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
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 100),
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
          rows:userList.isNotEmpty? userList.expand((listUser) {

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
                          case 'Action':
                            return PopupMenuButton<int>(
                                color: Colors.white,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      onTap: ()=>      showDialog(
                                          context: context,
                                          builder:
                                              (context) =>EmployeeCreationScreen(
                                                isEdit: true,
                                                officer:value ,
                                              )

                                      ),
                                      value: 1,
                                      child:const Row(
                                        spacing: 5,
                                        children: [
                                          Icon(
                                            Icons
                                                .edit,
                                            color: AppColors
                                                .greenSecondaryColor,
                                          ),
                                          Text(
                                              "Edit"),

                                        ],
                                      )
                                  ),
                                  PopupMenuItem(
                                    value:1,
                                      onTap:()=> showDialog(
                                          context: context,
                                          builder:
                                              (context) => EmployeeEditScreen(officerId: listUser.id, isResetPassword: false,)


                                      ),

                                      child: const Row(
                                    spacing: 5,
                                    children: [
                                      Icon(
                                        Icons.password,
                                        color: AppColors
                                            .redSecondaryColor,
                                      ),
                                      Text(
                                          "Edit Password"),

                                    ],
                                  )),
                                  PopupMenuItem(
                                    onTap: ()async{
                                      bool confirmed = await showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Confirm Delete"),
                                          content: const Text("Are you sure you want to delete this officer?"),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
                                          ],
                                        ),
                                      );

                                      if (confirmed) {
                                        final provider = Provider.of<OfficersControllerProvider>(context, listen: false);
                                        bool success = await provider.deleteOfficer(listUser.id,);

                                        if (success) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Officer deleted.")));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error ?? "Delete failed")));
                                        }
                                      }

                                    },
                                    value: 1,
                                    child:const Row(
                                      spacing: 5,
                                      children: [
                                         Icon(
                                            Icons.delete,
                                            color: AppColors
                                                .redSecondaryColor,
                                          ),
                                         Text(
                                              "Delete"),

                                      ],
                                    )
                                  ),
                                ]);

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
          }).toList():[],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final List<Map<String, dynamic>> columnsData = EmployeeFlavour.userTableList();
  //
  //   return SingleChildScrollView(
  //     child: LayoutBuilder(
  //       builder: (context, constraints) {
  //         return DataTable(
  //           columnSpacing: constraints.maxWidth / 100, // Adjust spacing to fit columns
  //           dataRowMinHeight: 48,
  //           dataRowMaxHeight: 64,
  //           headingRowColor: WidgetStateColor.resolveWith(
  //                   (states) => AppColors.primaryColor),
  //           columns: columnsData.map((column) {
  //             return DataColumn(
  //               label: SizedBox(
  //                 width: constraints.maxWidth / columnsData.length, // Equal width
  //                 child: CustomText(
  //                   text: column['name'],
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.textWhiteColour,
  //                   fontSize: 13,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           rows: userList.map((listUser) {
  //             return DataRow(
  //               cells: columnsData.map((column) {
  //                 final extractor = column['extractor'] as Function;
  //                 final value = extractor(listUser);
  //                 return DataCell(
  //                   SizedBox(
  //                     width: constraints.maxWidth / columnsData.length,
  //                     child: Builder(
  //                       builder: (context) {
  //                         switch (column['name']) {
  //                           case 'Status':
  //                             return Container(
  //                               padding: const EdgeInsets.symmetric(horizontal: 4),
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(6),
  //                                 color: getColorBasedOnStatus(listUser.status),
  //                               ),
  //                               child: CustomText(
  //                                 text: getTextBasedOnStatus(listUser.status),
  //                                 fontWeight: FontWeight.w600,
  //                                 fontSize: 12,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                             );
  //                           default:
  //                             return CustomText(
  //                               text: value,
  //                               fontSize: 13,
  //                               overflow: TextOverflow.ellipsis,
  //                             );
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             );
  //           }).toList(),
  //         );
  //       },
  //     )
  //
  //   );
  // }

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
