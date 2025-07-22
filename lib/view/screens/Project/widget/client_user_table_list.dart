import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/project/project_provider_controller.dart';
import 'package:overseas_front_end/model/client/client_model.dart';
import 'package:overseas_front_end/view/screens/project/flavour/customer_client_flavour.dart';
import 'package:overseas_front_end/view/screens/project/widget/add_client_screen.dart';
import 'package:provider/provider.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class ClientUserListTable extends StatelessWidget {
  final List<ClientModel> userlist;
  const ClientUserListTable({super.key, required this.userlist});

  @override
  Widget build(BuildContext context) {
    final horizontalController = ScrollController();
    final verticalController = ScrollController();
    final columnsData = CustomerClientFlavour.userTableList();

    return Consumer<ProjectProvider>(
      builder: (context,provider,child){
        return  LayoutBuilder(
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
                        rows: provider.filteredClients.map((listUser) {
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
                                  constraints: const BoxConstraints(
                                    maxWidth: 200,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      switch (column['name']) {
                                        case 'Status':
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color:AppColors.primaryColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: CustomText(
                                                text: value,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color:AppColors.whiteMainColor),
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
                                        case 'Action':
                                          return PopupMenuButton<int>(
                                              color: Colors.white,
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    onTap: () => showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AddClientScreen(
                                                              isEdit: true,
                                                              clientList: value,
                                                            )),
                                                    value: 1,
                                                    child: const Row(
                                                      spacing: 5,
                                                      children: [
                                                        Icon(
                                                          Icons.edit,
                                                          color: AppColors
                                                              .greenSecondaryColor,
                                                        ),
                                                        Text("Edit"),
                                                      ],
                                                    )),
                                                // PopupMenuItem(
                                                //     value: 1,
                                                //     onTap: () => showDialog(
                                                //         context: context,
                                                //         builder: (context) =>
                                                //             EmployeeEditScreen(
                                                //               officerId:
                                                //               listUser.id,
                                                //               isResetPassword:
                                                //               false,
                                                //             )),
                                                //     child: const Row(
                                                //       spacing: 5,
                                                //       children: [
                                                //         Icon(
                                                //           Icons.password,
                                                //           color: AppColors
                                                //               .redSecondaryColor,
                                                //         ),
                                                //         Text("Edit Password"),
                                                //       ],
                                                //     )),
                                                // PopupMenuItem(
                                                //     onTap: () async {
                                                //       bool confirmed =
                                                //       await showDialog(
                                                //         context: context,
                                                //         builder: (_) => AlertDialog(
                                                //           title: const Text(
                                                //               "Confirm Delete"),
                                                //           content: const Text(
                                                //               "Are you sure you want to delete this officer?"),
                                                //           actions: [
                                                //             TextButton(
                                                //                 onPressed: () =>
                                                //                     Navigator.pop(
                                                //                         context,
                                                //                         false),
                                                //                 child: const Text(
                                                //                     "Cancel")),
                                                //             TextButton(
                                                //                 onPressed: () =>
                                                //                     Navigator.pop(
                                                //                         context,
                                                //                         true),
                                                //                 child: const Text(
                                                //                     "Delete")),
                                                //           ],
                                                //         ),
                                                //       );
                                                //
                                                //       if (confirmed) {
                                                //         final provider = Provider
                                                //             .of<OfficersControllerProvider>(
                                                //             context,
                                                //             listen: false);
                                                //         bool success =
                                                //         await provider
                                                //             .deleteOfficer(
                                                //           listUser.id,
                                                //         );
                                                //
                                                //         if (success) {
                                                //           ScaffoldMessenger.of(
                                                //               context)
                                                //               .showSnackBar(SnackBar(
                                                //               content: Text(
                                                //                   "Officer deleted.")));
                                                //         } else {
                                                //           ScaffoldMessenger.of(
                                                //               context)
                                                //               .showSnackBar(SnackBar(
                                                //               content: Text(provider
                                                //                   .error ??
                                                //                   "Delete failed")));
                                                //         }
                                                //       }
                                                //     },
                                                //     value: 1,
                                                //     child: const Row(
                                                //       spacing: 5,
                                                //       children: [
                                                //         Icon(
                                                //           Icons.delete,
                                                //           color: AppColors
                                                //               .redSecondaryColor,
                                                //         ),
                                                //         Text("Delete"),
                                                //       ],
                                                //     )),
                                              ]);

                                      // return IconButton(
                                      //   color: AppColors.greenSecondaryColor,
                                      //   icon: const Icon(Icons.call),
                                      //   onPressed: () {
                                      //     showDialog(
                                      //       context: context,
                                      //       builder: (context) =>
                                      //           const CallRecordPopup(),
                                      //     );
                                      //   },
                                      // );
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
                                  // if (column['name'] == 'ID') {
                                  //   showDialog(
                                  //     context: context,
                                  //     builder: (context) =>
                                  //     const ClientDetailsTab(),
                                  //   );
                                  // }
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

// Color getColorBasedOnStatus(String status) {
//   switch (status.toLowerCase()) {
//     case 'hotlead':
//       return AppColors.greenSecondaryColor;
//     case 'noteligible' || 'closed':
//       return AppColors.redSecondaryColor;
//     case 'registered' || 'qualified':
//       return AppColors.blueSecondaryColor;
//     case 'interview':
//       return AppColors.pinkSecondaryColor;
//     case 'onHold':
//       return AppColors.orangeSecondaryColor;
//     case 'blocked':
//       return Colors.red.withOpacity(0.1);
//     default:
//       return Colors.grey.withOpacity(0.1);
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/client/client_lead_model.dart';
// import 'package:overseas_front_end/res/style/colors/dimension.dart';
// import '../../../../res/style/colors/colors.dart';
// import '../../../widgets/custom_text.dart';
// import '../flavour/customer_lead_flavour.dart';

// class LeadUserListTable extends StatefulWidget {
//   final List<ClientDataModel> userlist;
//   const LeadUserListTable({super.key, required this.userlist});

//   @override
//   State<LeadUserListTable> createState() => _LeadUserListTableState();
// }

// class _LeadUserListTableState extends State<LeadUserListTable> {
//   final Set<String> selectedIds = {};

//   // Toggle individual selection
//   void _toggleSelection(String id) {
//     setState(() {
//       if (selectedIds.contains(id)) {
//         selectedIds.remove(id);
//       } else {
//         selectedIds.add(id);
//       }
//     });
//   }

//   // Toggle select all
//   void _toggleSelectAll(bool? selectAll) {
//     setState(() {
//       if (selectAll == true) {
//         selectedIds.addAll(widget.userlist.map((user) => user.id.toString()));
//       } else {
//         selectedIds.clear();
//       }
//     });
//   }

//   // Perform bulk actions
//   void _performBulkAction(String action) {
//     if (selectedIds.isEmpty) return;

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("$action Selected Items"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("This will $action ${selectedIds.length} selected lead(s)."),
//             const SizedBox(height: 8),
//             Text("Selected IDs: ${selectedIds.join(', ')}"),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Add your actual bulk action logic here
//               setState(() {
//                 selectedIds.clear(); // Clear selection after action
//               });
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text(
//                         "$action completed for ${selectedIds.length} items")),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: action == "Delete" ? Colors.red : null,
//             ),
//             child: Text("Confirm $action"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final columnsData = CustomerLeadFlavour.userTableList();
//     final isAllSelected = selectedIds.length == widget.userlist.length &&
//         widget.userlist.isNotEmpty;

//     return Container(
//       height: 300,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: AppColors.textGrayColour.withOpacity(0.1),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           // Header with bulk actions
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: AppColors.blackGradient,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//               ),
//             ),
//             child: Row(
//               children: [
//                 // Select All Checkbox
//                 Checkbox(
//                   value: isAllSelected,
//                   onChanged: _toggleSelectAll,
//                   fillColor: WidgetStateProperty.all(Colors.white),
//                   checkColor: AppColors.primaryColor,
//                 ),
//                 const SizedBox(width: 8),
//                 const Icon(Icons.people_outline, color: Colors.white, size: 20),
//                 const SizedBox(width: 8),
//                 const CustomText(
//                   text: "Leads",
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//                 const Spacer(),
//                 CustomText(
//                   text: selectedIds.isNotEmpty
//                       ? "${selectedIds.length} selected"
//                       : "Total: ${widget.userlist.length}",
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                   fontSize: 14,
//                 ),
//               ],
//             ),
//           ),

//           // Bulk Actions Bar
//           if (selectedIds.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 border: Border(
//                   bottom: BorderSide(
//                     color: AppColors.textGrayColour.withOpacity(0.1),
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.check_circle,
//                     color: AppColors.primaryColor,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   CustomText(
//                     text: "${selectedIds.length} item(s) selected",
//                     color: AppColors.primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   const Spacer(),
//                   _buildBulkActionButton(
//                     icon: Icons.mark_email_read,
//                     text: "Mark Reviewed",
//                     onPressed: () => _performBulkAction("Mark Reviewed"),
//                   ),
//                   const SizedBox(width: 8),
//                   _buildBulkActionButton(
//                     icon: Icons.block,
//                     text: "Block",
//                     onPressed: () => _performBulkAction("Block"),
//                   ),
//                   const SizedBox(width: 8),
//                   _buildBulkActionButton(
//                     icon: Icons.delete,
//                     text: "Delete",
//                     color: Colors.red,
//                     onPressed: () => _performBulkAction("Delete"),
//                   ),
//                 ],
//               ),
//             ),

//           // Table Content
//           Expanded(
//             child: Dimension.isMobile
//                 ? _buildMobileList()
//                 : _buildDesktopTable(columnsData),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount: widget.userlist.length,
//       itemBuilder: (context, index) {
//         final user = widget.userlist[index];
//         final isSelected = selectedIds.contains(user.id.toString());

//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 4),
//           color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
//           child: ListTile(
//             leading: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Checkbox(
//                   value: isSelected,
//                   onChanged: (_) => _toggleSelection(user.id.toString()),
//                 ),
//                 CircleAvatar(
//                   backgroundColor:
//                       AppColors.violetPrimaryColor.withOpacity(0.1),
//                   child: Text(
//                     (user.name?.isNotEmpty == true)
//                         ? user.name![0].toUpperCase()
//                         : '?',
//                     style: TextStyle(
//                       color: AppColors.violetPrimaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             title: CustomText(
//               text: user.name ?? 'N/A',
//               fontWeight: FontWeight.w600,
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('ID: ${user.id ?? 'N/A'}'),
//                 Text('Phone: ${user.mobile ?? 'N/A'}'),
//               ],
//             ),
//             trailing: _buildStatusChip(user.mobile ?? ''),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDesktopTable(List<Map<String, dynamic>> columnsData) {
//     return SingleChildScrollView(
//       child: DataTable(
//         headingRowColor: MaterialStateProperty.all(
//           AppColors.textGrayColour.withOpacity(0.05),
//         ),
//         columns: [
//           const DataColumn(
//             label: SizedBox(
//               width: 40,
//               child: Text(''),
//             ),
//           ),
//           ...columnsData
//               .map((column) => DataColumn(
//                     label: Text(column['name']),
//                   ))
//               .toList(),
//           const DataColumn(label: Text('Actions')),
//         ],
//         rows: widget.userlist.map((user) {
//           final isSelected = selectedIds.contains(user.id.toString());

//           return DataRow(
//             selected: isSelected,
//             color: MaterialStateProperty.resolveWith<Color?>(
//               (states) =>
//                   isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
//             ),
//             cells: [
//               DataCell(
//                 Checkbox(
//                   value: isSelected,
//                   onChanged: (_) => _toggleSelection(user.id.toString()),
//                 ),
//               ),
//               ...columnsData.map((column) {
//                 final extractor = column['extractor'] as Function;
//                 final value = (column['name'] == 'Offer' ||
//                         column['name'] == 'Offer Amount' ||
//                         column['name'] == 'Eligibility Date')
//                     ? extractor(user, null)
//                     : extractor(user);

//                 return DataCell(_buildCellContent(column['name'], value, user));
//               }).toList(),
//               DataCell(
//                 IconButton(
//                   icon: const Icon(Icons.more_vert, size: 18),
//                   onPressed: () => _showActionMenu(context, user),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCellContent(
//       String columnName, String value, ClientDataModel user) {
//     switch (columnName) {
//       case 'Status':
//         return _buildStatusChip(user.mobile ?? '');
//       case 'ID':
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: AppColors.blueSecondaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(
//             '#${user.id ?? 'N/A'}',
//             style: TextStyle(
//               color: AppColors.blueSecondaryColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           ),
//         );
//       case 'Name':
//         return Row(
//           children: [
//             CircleAvatar(
//               radius: 12,
//               backgroundColor: AppColors.violetPrimaryColor.withOpacity(0.1),
//               child: Text(
//                 (user.name?.isNotEmpty == true)
//                     ? user.name![0].toUpperCase()
//                     : '?',
//                 style: const TextStyle(
//                   color: AppColors.violetPrimaryColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 10,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(user.name ?? 'N/A'),
//           ],
//         );
//       case 'Phone Number':
//         return Row(
//           children: [
//             const Icon(Icons.phone,
//                 size: 14, color: AppColors.greenSecondaryColor),
//             const SizedBox(width: 4),
//             Text(user.mobile ?? 'N/A'),
//           ],
//         );
//       default:
//         return Text(value);
//     }
//   }

//   Widget _buildBulkActionButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     Color? color,
//   }) {
//     final buttonColor = color ?? AppColors.primaryColor;
//     return Container(
//       decoration: BoxDecoration(
//         color: buttonColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(
//           color: buttonColor.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(6),
//           onTap: onPressed,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon, color: buttonColor, size: 16),
//                 const SizedBox(width: 6),
//                 Text(
//                   text,
//                   style: TextStyle(
//                     color: buttonColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusChip(String status) {
//     final statusInfo = _getStatusInfo(status);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: statusInfo['color'].withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: statusInfo['color'].withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Text(
//         statusInfo['text'],
//         style: TextStyle(
//           color: statusInfo['color'],
//           fontWeight: FontWeight.w600,
//           fontSize: 11,
//         ),
//       ),
//     );
//   }

//   void _showActionMenu(BuildContext context, ClientDataModel user) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.visibility),
//               title: const Text('View Details'),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Handle view action
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Edit Lead'),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Handle edit action
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.phone),
//               title: const Text('Call Lead'),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Handle call action
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete, color: Colors.red),
//               title: const Text('Delete', style: TextStyle(color: Colors.red)),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Handle delete action
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Map<String, dynamic> _getStatusInfo(String status) {
//     switch (status.toLowerCase()) {
//       case 'blocked':
//         return {
//           'color': AppColors.redSecondaryColor,
//           'text': 'Blocked',
//         };
//       case 'unblocked':
//       case 'reviewed':
//         return {
//           'color': AppColors.greenSecondaryColor,
//           'text': 'Active',
//         };
//       case 'on_hold':
//         return {
//           'color': AppColors.orangeSecondaryColor,
//           'text': 'On Hold',
//         };
//       default:
//         return {
//           'color': AppColors.blueSecondaryColor,
//           'text': 'Pending',
//         };
//     }
//   }
// }