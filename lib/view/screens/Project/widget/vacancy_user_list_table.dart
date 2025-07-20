import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/project/vacancy_model.dart';
import 'package:overseas_front_end/view/screens/project/flavour/customer_vacancy_flavour.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class VacancyUserListTable extends StatelessWidget {
  final List<VacancyModel> userlist;
  const VacancyUserListTable({super.key, required this.userlist});

  @override
  Widget build(BuildContext context) {
    final horizontalController = ScrollController();
    final verticalController = ScrollController();
    final columnsData = CustomerVacancyFlavour.userTableList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          thumbVisibility: true,
          controller: horizontalController, // ✅ attach controller
          child: SingleChildScrollView(
            controller: horizontalController, // ✅ attach controller
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Scrollbar(
                thumbVisibility: true,
                controller: verticalController, // ✅ attach controller
                child: SingleChildScrollView(
                  controller: verticalController, // ✅ attach controller
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
                    rows: userlist.map((listUser) {
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
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Builder(
                                builder: (context) {
                                  switch (column['name']) {
                                    case 'Project Name':
                                      return SelectionArea(
                                        child: CustomText(
                                          text: value,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.textColor,
                                        ),
                                      );
                                    case 'Job Position':
                                      return SelectionArea(
                                        child: CustomText(
                                          text: value,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.textColor,
                                        ),
                                      );
                                    // case 'Action':
                                    //   return Row(
                                    //     children: [
                                    //       IconButton(
                                    //         color:
                                    //             AppColors.greenSecondaryColor,
                                    //         icon: const Icon(
                                    //             Icons.app_registration_rounded),
                                    //         onPressed: () {
                                    //           showDialog(
                                    //             context: context,
                                    //             builder: (context) =>
                                    //                 RegistrationAdd(),
                                    //           );
                                    //         },
                                    //       ),
                                    //       PopupMenuButton<int>(
                                    //           color: Colors.white,
                                    //           itemBuilder: (context) => [
                                    //                 PopupMenuItem(
                                    //                   value: 1,
                                    //                   child: InkWell(
                                    //                     onTap: () => showDialog(
                                    //                       context: context,
                                    //                       builder: (context) =>
                                    //                           CallRecordPopup(),
                                    //                     ),
                                    //                     child: const Row(
                                    //                       children: [
                                    //                         Icon(
                                    //                           Icons.call,
                                    //                           color: AppColors
                                    //                               .greenSecondaryColor,
                                    //                         ),
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                         ),
                                    //                         Text("Call")
                                    //                       ],
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ]),
                                    //     ],
                                    //   );
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
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => ProjectDetailsTab(),
                                // );
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
  }
}

Color getColorBasedOnStatus(String status) {
  switch (status.toLowerCase()) {
    case 'registered':
      return AppColors.greenSecondaryColor;
    case 'not registered':
      return AppColors.redSecondaryColor;
    // case 'registered' || 'qualified':
    //   return AppColors.blueSecondaryColor;
    // case 'interview':
    //   return AppColors.pinkSecondaryColor;
    // case 'onHold':
    //   return AppColors.orangeSecondaryColor;
    // case 'blocked':
    //   return Colors.red.withOpacity(0.1);
    default:
      return Colors.grey.withOpacity(0.1);
  }
}

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
