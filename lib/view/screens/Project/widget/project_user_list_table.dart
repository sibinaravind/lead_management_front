import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/view/widgets/custom_popup.dart';
import 'package:provider/provider.dart';

import '../../../../controller/config_provider.dart';
import '../../../../controller/project/project_provider_controller.dart';
import '../../../../model/app_configs/config_model.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';
import '../flavour/customer_project_flavour.dart';
import 'project_details_tab.dart';

class ProjectUserListTable extends StatelessWidget {
  final List<ProjectModel> userlist;
  const ProjectUserListTable({super.key, required this.userlist});

  @override
  Widget build(BuildContext context) {
    final horizontalController = ScrollController();
    final verticalController = ScrollController();
    final columnsData = CustomerProjectFlavour.userTableList();

    return Consumer<ProjectProvider>(
      builder: (context, provider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scrollbar(
              thumbVisibility: true,
              controller: horizontalController,
              child: SingleChildScrollView(
                controller: horizontalController,
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: verticalController,
                    child: SingleChildScrollView(
                      controller: verticalController,
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.primaryColor),
                        columnSpacing: 16.0,
                        columns: columnsData.map((column) {
                          return DataColumn(
                            label: CustomText(
                              text: column['name'],
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhiteColour,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                        rows: provider.filterProjects.map((listUser) {
                          return DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>(
                                (_) => Colors.white),
                            cells: columnsData.map((column) {
                              final extractor = column['extractor'] as Function;
                              final value = (column['name'] == 'Offer' ||
                                      column['name'] == 'Offer Amount' ||
                                      column['name'] == 'Eligibility Date')
                                  ? extractor(listUser, null)
                                  : extractor(listUser);

                              return DataCell(
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  child: Builder(
                                    builder: (context) {
                                      switch (column['name']) {
                                        case 'Project Name':
                                        case 'Job Position':
                                          return CustomText(
                                            text: value,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textColor,
                                          );
                                        case 'ID':
                                          return CustomText(
                                            text: value,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor,
                                          );
                                        case 'Status':
                                          return Consumer<ConfigProvider>(
                                            builder:
                                                (context, configVal, child) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: getColorBasedOnStatus(
                                                            value, configVal)
                                                        ?.withOpacity(0.5) ??
                                                    Colors.white,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: CustomText(
                                                text: value,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.w600,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          );
                                        case 'Action':
                                          return PopupMenuButton<int>(
                                              color: Colors.white,
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                        onTap: () => showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  DeleteConfirmationDialog(
                                                                      title:
                                                                          "Delete",
                                                                      message:
                                                                          "Are you sure?",
                                                                      onConfirm:
                                                                          () {
                                                                        Provider.of<ProjectProvider>(context, listen: false).deleteProject(
                                                                            listUser.sId ??
                                                                                '',
                                                                            context);
                                                                      }),
                                                            ),
                                                        value: 1,
                                                        child: const Row(
                                                          spacing: 5,
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color: AppColors
                                                                  .redSecondaryColor,
                                                            ),
                                                            Text("Delete"),
                                                          ],
                                                        )),
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
                                ),
                                onTap: () {
                                  print(column['name']);
                                  if (column['name'] == 'Project Name') {
                                    print('project name');
                                    showDialog(
                                      context: context,
                                      builder: (context) => ProjectDetailsTab(
                                        project: listUser,
                                      ),
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Color hexToColorWithAlpha(String hexString) {
  hexString = hexString.replaceFirst('0X', '');
  return Color(int.parse(hexString, radix: 16));
}

Color? getColorBasedOnStatus(String status, ConfigProvider configVal) {
  String? value = configVal.configModelList?.clientStatus
          ?.firstWhere(
            (element) =>
                element.name?.toLowerCase() == status.toString().toLowerCase(),
            orElse: () => ConfigModel(colour: "0Xffffffff"),
          )
          .colour ??
      "0Xffffffff";
  return hexToColorWithAlpha(value ?? "0Xffffffff");
}

// Color getColorBasedOnStatus(String status) {
//   switch (status.toLowerCase()) {
//     case 'registered':
//       return AppColors.greenSecondaryColor;
//     case 'not registered':
//       return AppColors.redSecondaryColor;
//     // case 'registered' || 'qualified':
//     //   return AppColors.blueSecondaryColor;
//     // case 'interview':
//     //   return AppColors.pinkSecondaryColor;
//     // case 'onHold':
//     //   return AppColors.orangeSecondaryColor;
//     // case 'blocked':
//     //   return Colors.red.withOpacity(0.1);
//     default:
//       return Colors.grey.withOpacity(0.1);
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController scrollController = ScrollController();
//     final List<Map<String, dynamic>> columnsData =
//         CustomerProjectFlavour.userTableList();

//     return Scrollbar(
//       thumbVisibility: true,
//       controller: scrollController,
//       child: SingleChildScrollView(
//         controller: scrollController,
//         scrollDirection: Axis.horizontal,
//         child: ConstrainedBox(
//           constraints:
//               BoxConstraints(minWidth: MediaQuery.of(context).size.width - 100),
//           child: DataTable(
//             headingRowColor:
//                 WidgetStateColor.resolveWith((Set<WidgetState> states) {
//               return Colors.black12;
//             }),
//             columns: columnsData.map((column) {
//               return DataColumn(
//                 label: Flexible(
//                   child: CustomText(
//                     text: column['name'],
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textColor,
//                     fontSize: 14,
//                   ),
//                 ),
//               );
//             }).toList(),
//             rows: userlist.expand((listUser) {
//               return [
//                 DataRow(
//                   cells: columnsData.map((column) {
//                     final extractor = column['extractor'] as Function;
//                     final value = (column['name'] == 'Offer' ||
//                             column['name'] == 'Offer Amount' ||
//                             column['name'] == 'Eligibility Date')
//                         ? extractor(listUser, null)
//                         : extractor(listUser);

//                     return DataCell(
//                       Builder(
//                         builder: (context) {
//                           switch (column['name']) {
//                             case 'Status':
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: getColorBasedOnStatus(
//                                       listUser.mobile ?? ''),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 6),
//                                 child: CustomText(
//                                   text: getTextBasedOnStatus(
//                                       listUser.mobile ?? ''),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                   color: getColorBasedOnStatus(
//                                           listUser.mobile ?? '')
//                                       .withOpacity(1.0),
//                                 ),
//                               );
//                             case 'Phone Number':
//                               return SelectionArea(
//                                   child: CustomText(
//                                 text: value,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: AppColors.textColor,
//                               ));
//                             case 'ID':
//                               return CustomText(
//                                 text: value,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.primaryColor,
//                               );

//                             default:
//                               return CustomText(
//                                 text: value,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: AppColors.textColor,
//                               );
//                           }
//                         },
//                       ),
//                       onTap: () {
//                         if (column['name'] == 'ID') {
//                           showDialog(
//                             context: context,
//                             builder: (context) =>
//                                 const ProjectClientManagementScreen(),
//                           );
//                         }
//                       },
//                     );
//                   }).toList(),
//                 )
//               ];
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Color getColorBasedOnStatus(String status) {
//   switch (status.toLowerCase()) {
//     case 'blocked':
//       return Colors.red.withOpacity(0.1);
//     case 'unblocked' || 'reviewed':
//       return Colors.green.withOpacity(0.1);
//     case 'on_hold':
//       return Colors.orange.withOpacity(0.1);
//     default:
//       return Colors.grey.withOpacity(0.1);
//   }
// }

// String getTextBasedOnStatus(String status) {
//   switch (status.toLowerCase()) {
//     case 'blocked':
//       return 'Blocked';
//     case 'unblocked':
//       return 'UnBlocked';
//     case 'on_hold':
//       return 'On Hold';
//     case 'not_reviewed':
//       return 'Not Reviewed';
//     case 'reviewed':
//       return 'Reviewed';
//     default:
//       return status;
//   }
// }
///-- before search
// return LayoutBuilder(
//   builder: (context, constraints) {
//     return Scrollbar(
//       thumbVisibility: true,
//       controller: horizontalController, // ✅ attach controller
//       child: SingleChildScrollView(
//         controller: horizontalController, // ✅ attach controller
//         scrollDirection: Axis.horizontal,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(minWidth: constraints.maxWidth),
//           child: Scrollbar(
//             thumbVisibility: true,
//             controller: verticalController, // ✅ attach controller
//             child: SingleChildScrollView(
//               controller: verticalController, // ✅ attach controller
//               scrollDirection: Axis.vertical,
//               child: DataTable(
//                 headingRowColor: WidgetStateColor.resolveWith(
//                     (states) => AppColors.primaryColor),
//                 columnSpacing: 16.0,
//                 columns: columnsData.map((column) {
//                   return DataColumn(
//                     label: CustomText(
//                       text: column['name'],
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textWhiteColour,
//                       fontSize: 14,
//                     ),
//                   );
//                 }).toList(),
//                 rows: userlist.map((listUser) {
//                   return DataRow(
//                     color: WidgetStateProperty.resolveWith<Color?>(
//                         (_) => Colors.white),
//                     cells: columnsData.map((column) {
//                       final extractor = column['extractor'] as Function;
//                       final value = (column['name'] == 'Offer' ||
//                               column['name'] == 'Offer Amount' ||
//                               column['name'] == 'Eligibility Date')
//                           ? extractor(listUser, null)
//                           : extractor(listUser);
//
//                       return DataCell(
//                         ConstrainedBox(
//                           constraints: const BoxConstraints(maxWidth: 200),
//                           child: Builder(
//                             builder: (context) {
//                               switch (column['name']) {
//                                 case 'Project Name':
//                                   return SelectionArea(
//                                     child: CustomText(
//                                       text: value,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: AppColors.textColor,
//                                     ),
//                                   );
//                                 case 'Job Position':
//                                   return SelectionArea(
//                                     child: CustomText(
//                                       text: value,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: AppColors.textColor,
//                                     ),
//                                   );
//                                 // case 'Action':
//                                 //   return Row(
//                                 //     children: [
//                                 //       IconButton(
//                                 //         color:
//                                 //             AppColors.greenSecondaryColor,
//                                 //         icon: const Icon(
//                                 //             Icons.app_registration_rounded),
//                                 //         onPressed: () {
//                                 //           showDialog(
//                                 //             context: context,
//                                 //             builder: (context) =>
//                                 //                 RegistrationAdd(),
//                                 //           );
//                                 //         },
//                                 //       ),
//                                 //       PopupMenuButton<int>(
//                                 //           color: Colors.white,
//                                 //           itemBuilder: (context) => [
//                                 //                 PopupMenuItem(
//                                 //                   value: 1,
//                                 //                   child: InkWell(
//                                 //                     onTap: () => showDialog(
//                                 //                       context: context,
//                                 //                       builder: (context) =>
//                                 //                           CallRecordPopup(),
//                                 //                     ),
//                                 //                     child: const Row(
//                                 //                       children: [
//                                 //                         Icon(
//                                 //                           Icons.call,
//                                 //                           color: AppColors
//                                 //                               .greenSecondaryColor,
//                                 //                         ),
//                                 //                         SizedBox(
//                                 //                           width: 10,
//                                 //                         ),
//                                 //                         Text("Call")
//                                 //                       ],
//                                 //                     ),
//                                 //                   ),
//                                 //                 ),
//                                 //               ]),
//                                 //     ],
//                                 //   );
//                                 case 'ID':
//                                   return CustomText(
//                                     text: value,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.primaryColor,
//                                   );
//                                 default:
//                                   return CustomText(
//                                     text: value,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                     color: AppColors.textColor,
//                                   );
//                               }
//                             },
//                           ),
//                         ),
//                         onTap: () {
//                           if (column['name'] == 'ID') {
//                             showDialog(
//                               context: context,
//                               builder: (context) => ProjectDetailsTab(),
//                             );
//                           }
//                         },
//                       );
//                     }).toList(),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   },
// );
