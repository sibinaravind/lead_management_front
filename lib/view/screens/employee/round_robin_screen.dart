import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/controller/lead/round_robin_provider.dart';
import 'package:overseas_front_end/core/shared/enums.dart';
import 'package:overseas_front_end/view/screens/config/widget/action_button.dart';
import 'package:overseas_front_end/view/screens/config/widget/add_item_dialog.dart';
import 'package:overseas_front_end/view/screens/config/widget/permission_item.dart';
import 'package:overseas_front_end/view/screens/employee/widget/add_officers.dart';
import 'package:overseas_front_end/view/screens/employee/widget/add_round_robin.dart';
import 'package:overseas_front_end/view/screens/employee/widget/round_robin_officer_list.dart';
import 'package:overseas_front_end/view/widgets/custom_button.dart';
import 'package:overseas_front_end/view/widgets/custom_popup.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../model/app_configs/config_model.dart';
import '../../../model/lead/round_robin.dart';
import '../../../res/style/colors/colors.dart';

class RoundRobinScreen extends StatefulWidget {
  const RoundRobinScreen({super.key});

  @override
  State<RoundRobinScreen> createState() => _SystemConfigState();
}

class _SystemConfigState extends State<RoundRobinScreen> {
  @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     child: Consumer<RoundRobinProvider>(
  //       builder: (context, roundRobin, child) {
  //         if (roundRobin.isLoading == true) {
  //           return CircularProgressIndicator();
  //         }
  //         final roundRobinList = roundRobin.roundRobinGroups;
  //         if (roundRobinList.isEmpty) {
  //           return const Center(child: Text('No Groups Available'));
  //         }
  //
  //
  //         return Container(
  //           decoration: const BoxDecoration(
  //             gradient: AppColors.backgroundGraident,
  //           ),
  //           child: ListView.builder(
  //             padding: const EdgeInsets.all(16.0),
  //             itemCount: roundRobinList.length,
  //             itemBuilder: (context, index) {
  //               final group = roundRobinList[index];
  //
  //               return Card(
  //                 margin: const EdgeInsets.only(bottom: 20.0),
  //                 elevation: 8,
  //                 shadowColor: AppColors.primaryColor.withOpacity(0.1),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     gradient: LinearGradient(
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight,
  //                       colors: [
  //                         AppColors.whiteMainColor,
  //                         AppColors.whiteMainColor.withOpacity(0.9),
  //                       ],
  //                     ),
  //                   ),
  //                   child: Theme(
  //                     data: Theme.of(context)
  //                         .copyWith(dividerColor: Colors.transparent),
  //                     child: ExpansionTile(
  //                       tilePadding: const EdgeInsets.all(8),
  //                       childrenPadding: const EdgeInsets.all(8),
  //                       collapsedBackgroundColor: Colors.transparent,
  //                       backgroundColor: Colors.transparent,
  //                       title: Row(
  //                         children: [
  //                           Container(
  //                             padding: const EdgeInsets.all(12),
  //                             decoration: BoxDecoration(
  //                               color: _getCategoryColor(index),
  //                               // gradient: _getCategoryGradient(category),
  //                               borderRadius: BorderRadius.circular(15),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: _getCategoryColor(index)
  //                                       .withOpacity(0.3),
  //                                   blurRadius: 8,
  //                                   offset: const Offset(0, 4),
  //                                 ),
  //                               ],
  //                             ),
  //                             child: Icon(
  //                               _getCategoryIcon(category),
  //                               color: AppColors.whiteMainColor,
  //                               size: 24,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 16),
  //                           Expanded(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   category.replaceAll('_', ' ').toUpperCase(),
  //                                   style: const TextStyle(
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: AppColors.primaryColor,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(height: 4),
  //                                 CustomText(
  //                                   text:
  //                                   '${items.length} items • ${items.where((e) => e?.status == Status.ACTIVE).length} active',
  //                                   color: AppColors.textGrayColour,
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w500,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           ActionButton(
  //                             icon: Icons.add,
  //                             gradient: AppColors.buttonGraidentColour,
  //                             onTap: () {
  //                               showDialog(
  //                                 context: context,
  //                                 builder: (_) => AddItemDialog(
  //                                   category: category,
  //                                   item: items.elementAtOrNull(0) ??
  //                                       ConfigModel(
  //                                           code: "",
  //                                           colour: "",
  //                                           country: "",
  //                                           id: "",
  //                                           name: "",
  //                                           province: "",
  //                                           status: Status.INACTIVE),
  //                                 ),
  //                               );
  //                             },
  //                             tooltip: 'Add New Item',
  //                           ),
  //                         ],
  //                       ),
  //                       children: [
  //                         ...items.map((item) {
  //                           return PermissionItem(
  //                             category: category,
  //                             item: item ?? ConfigModel(),
  //                           );
  //                         }),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<RoundRobinProvider>(
        builder: (context, roundRobin, child) {
          if (roundRobin.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final roundRobinGroups = roundRobin.roundRobinGroups;

          if (roundRobinGroups.isEmpty) {
            return const Center(child: Text('No Groups Available'));
          }

          return Column(
            spacing: 5,
            children: [
              SizedBox(height: 5,),
              Align(
              alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: 200,
                    child: CustomButton(text: "Add RoundRobin",
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (_) => AddRoundRobinDialog(

                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),



              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.backgroundGraident,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: roundRobinGroups.length,
                    itemBuilder: (context, index) {
                      final group = roundRobinGroups[index];
                      List officersList=group.officerDetails;
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
                                      // gradient: _getCategoryGradient(category),
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
                                    child: Icon(
                                      Icons.group_add,

                                      color: AppColors.whiteMainColor,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          group.name.toUpperCase()??'',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          text:
                                          group.country??'',
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
                                            builder: (_) =>DeleteConfirmationDialog(title: "Delete", message: 'You want to delete', onConfirm: ()async{

                                              final success = await Provider.of<RoundRobinProvider>(context, listen: false).deleteRoundRobin(group.id??'');
                                              if ( success) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Round robin deleted successfully')),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text( 'Delete failed')),
                                                );
                                              }


                                            })
                                          );
                                        },
                                        tooltip: 'Add New Item',
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
                                        tooltip: 'Add New Item',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              children: [

                                ...officersList.map((item) {
                                  print(item);
                                  return RoundRobinOfficerList(
                                    roundrobinId: group.id??'',
                                    // category: item['name']??'',
                                    item: item ?? [],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      );

                      return Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Group Title Section
                              Row(
                                children: [
                                  Icon(Icons.group, color: AppColors.primaryColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      group.name.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Chip(
                                    label: Text(group.country ?? ''),
                                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Officers List
                              ...group.officerDetails.map((officer) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.primaryColor,
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                  title: Text(officer.name ?? ''),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Phone: ${officer.phone}'),
                                      Text('Company Phone: ${officer.companyPhoneNumber}'),
                                      Text('Branch: ${officer.branch?.join(', ') ?? ''}'),
                                      Text('Designation: ${officer.designation?.join(', ') ?? ''}'),
                                    ],
                                  ),
                                );
                              }).toList() ?? [],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget _buildPermissionItem(String category, Map<String, dynamic> item) {
  //   bool isActive = item['status'] == 'active';

  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
  //     decoration: BoxDecoration(
  //       gradient: isActive
  //           ? LinearGradient(
  //               colors: [
  //                 AppColors.greenSecondaryColor.withOpacity(0.1),
  //                 AppColors.greenSecondaryColor.withOpacity(0.05),
  //               ],
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //             )
  //           : LinearGradient(
  //               colors: [
  //                 AppColors.redSecondaryColor.withOpacity(0.1),
  //                 AppColors.redSecondaryColor.withOpacity(0.05),
  //               ],
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //             ),
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(
  //         color: isActive
  //             ? AppColors.greenSecondaryColor.withOpacity(0.3)
  //             : AppColors.redSecondaryColor.withOpacity(0.3),
  //         width: 1.5,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: isActive
  //               ? AppColors.greenSecondaryColor.withOpacity(0.1)
  //               : AppColors.redSecondaryColor.withOpacity(0.1),
  //           blurRadius: 4,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Row(
  //         children: [
  //           Container(
  //             width: 20,
  //             height: 20,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               gradient:
  //                   isActive ? AppColors.greenGradient : AppColors.redGradient,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: isActive
  //                       ? AppColors.greenSecondaryColor.withOpacity(0.4)
  //                       : AppColors.redSecondaryColor.withOpacity(0.4),
  //                   blurRadius: 4,
  //                   offset: Offset(0, 2),
  //                 ),
  //               ],
  //             ),
  //             child: Icon(
  //               isActive ? Icons.check : Icons.close,
  //               color: AppColors.whiteMainColor,
  //               size: 12,
  //             ),
  //           ),
  //           SizedBox(width: 16),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   item['name'],
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: AppColors.primaryColor,
  //                   ),
  //                 ),
  //                 if (item.containsKey('code') ||
  //                     item.containsKey('country') ||
  //                     item.containsKey('range'))
  //                   Padding(
  //                     padding: EdgeInsets.only(top: 6),
  //                     child: Container(
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                       decoration: BoxDecoration(
  //                         color: AppColors.blueNeutralColor.withOpacity(0.5),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: Text(
  //                         _buildSubtitle(item),
  //                         style: TextStyle(
  //                           fontSize: 11,
  //                           color: AppColors.textGrayColour,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               ActionButton(
  //                 icon: isActive ? Icons.toggle_on : Icons.toggle_off,
  //                 gradient: isActive
  //                     ? AppColors.greenGradient
  //                     : AppColors.redGradient,
  //                 onTap: () => _toggleStatus(category, item),
  //                 tooltip: isActive ? 'Deactivate' : 'Activate',
  //               ),
  //               SizedBox(width: 8),
  //               ActionButton(
  //                 icon: Icons.edit_rounded,
  //                 gradient: AppColors.buttonGraidentColour,
  //                 // onTap: () => _showEditDialog(category, item),
  //                 onTap: () => configEditDialog(context, category, item),
  //                 tooltip: 'Edit',
  //               ),
  //               SizedBox(width: 8),
  //               ActionButton(
  //                 icon: Icons.delete_rounded,
  //                 gradient: AppColors.redGradient,
  //                 onTap: () => showDialog(
  //                   context: context,
  //                   builder: (context) =>
  //                       DeleteDialogue(category: category, item: item),
  //                 ),
  //                 tooltip: 'Delete',
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildActionButton({
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.whiteMainColor,
            size: 16,
          ),
        ),
      ),
    );
  }

  String _buildSubtitle(Map<String, dynamic> item) {
    List<String> parts = [];
    if (item.containsKey('code')) parts.add('Code: ${item['code']}');
    if (item.containsKey('country')) parts.add('Country: ${item['country']}');
    if (item.containsKey('province')) {
      parts.add('Province: ${item['province']}');
    }
    if (item.containsKey('range')) parts.add('Range: ${item['range']}');
    return parts.join(' • ');
  }

  LinearGradient _getCategoryGradient(String category) {
    switch (category) {
      case 'Education Programs':
        return AppColors.buttonGraidentColour;
      case 'Known Languages':
        return AppColors.orangeGradient;
      case 'Universities':
        return AppColors.greenGradient;
      case 'Job Type':
        return AppColors.pinkGradient;
      case 'Salary':
        return AppColors.blueGradient;
      default:
        return AppColors.blackGradient;
    }
  }

  Color _getCategoryColor(int index) {
    final indexList = List.generate(20, (index) {
      return index;
    });

    return AppColors.roleColors.elementAt(index % 10);

    // switch (indexList[index]) {
    //   case 1:
    //     return AppColors.violetPrimaryColor;
    //   case 2:
    //     return AppColors.orangeSecondaryColor;
    //   case 3:
    //     return AppColors.greenSecondaryColor;
    //   case 4:
    //     return AppColors.pinkSecondaryColor;
    //   case 5:
    //     return AppColors.blueSecondaryColor;
    //   case 6:
    //     return const Color.fromARGB(255, 59, 246, 174);
    //   case 7:
    //     return const Color.fromARGB(255, 143, 59, 246);
    //   case 8:
    //     return const Color.fromARGB(255, 96, 59, 246);
    //   case 9:
    //     return const Color.fromARGB(255, 246, 168, 59);
    //   case 10:
    //     return const Color.fromARGB(255, 59, 246, 128);
    //   default:
    //     return AppColors.primaryColor;
    // }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Education Programs':
        return Icons.school_rounded;
      case 'Known Languages':
        return Icons.language_rounded;
      case 'Universities':
        return Icons.account_balance_rounded;
      case 'Job Type':
        return Icons.work_rounded;
      case 'Salary':
        return Icons.attach_money_rounded;
      default:
        return Icons.folder_rounded;
    }
  }

  void _toggleStatus(String category, Map<String, dynamic> item) {
    setState(() {
      item['status'] = item['status'] == 'active' ? 'inactive' : 'active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.whiteMainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['status'] == 'active'
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: AppColors.whiteMainColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${item['name']} ${item['status'] == 'active' ? 'activated' : 'deactivated'}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: item['status'] == 'active'
            ? AppColors.greenSecondaryColor
            : AppColors.redSecondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(16),
      ),
    );
  }

// void _showEditDialog(String category, Map<String, dynamic> item) {
//   TextEditingController nameController =
//       TextEditingController(text: item['name']);
//   TextEditingController codeController =
//       TextEditingController(text: item['code'] ?? '');
//   TextEditingController countryController =
//       TextEditingController(text: item['country'] ?? '');
//   TextEditingController provinceController =
//       TextEditingController(text: item['province'] ?? '');
//   TextEditingController rangeController =
//       TextEditingController(text: item['range'] ?? '');

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: AppColors.whiteMainColor,
//         title: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: AppColors.buttonGraidentColour,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.edit_rounded, color: AppColors.whiteMainColor),
//               SizedBox(width: 12),
//               CustomText(
//                 text: 'Edit ${category.substring(0, category.length - 1)}',
//                 color: AppColors.whiteMainColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ],
//           ),
//         ),
//         content: Container(
//           decoration: BoxDecoration(
//             gradient: AppColors.backgroundGraident,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildStyledTextField(
//                       nameController, 'Name', Icons.badge_rounded),
//                   if (item.containsKey('code')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(
//                         codeController, 'Code', Icons.code_rounded),
//                   ],
//                   if (item.containsKey('country')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(
//                         countryController, 'Country', Icons.flag_rounded),
//                   ],
//                   if (item.containsKey('province')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(provinceController, 'Province',
//                         Icons.location_on_rounded),
//                   ],
//                   if (item.containsKey('range')) ...[
//                     SizedBox(height: 16),
//                     _buildStyledTextField(rangeController, 'Salary Range',
//                         Icons.attach_money_rounded),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: AppColors.textGrayColour,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: AppColors.buttonGraidentColour,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   item['name'] = nameController.text;
//                   if (item.containsKey('code')) {
//                     item['code'] = codeController.text;
//                   }
//                   if (item.containsKey('country')) {
//                     item['country'] = countryController.text;
//                   }
//                   if (item.containsKey('province')) {
//                     item['province'] = provinceController.text;
//                   }
//                   if (item.containsKey('range')) {
//                     item['range'] = rangeController.text;
//                   }
//                 });
//                 Navigator.of(context).pop();
//                 CustomSnackBar.show(
//                     context, '${item['name']} updated successfully');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   color: AppColors.whiteMainColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showDeleteDialog(String category, Map<String, dynamic> item) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: CustomText(text: 'Delete ${item['name']}'),
//         content: CustomText(
//             text:
//                 'Are you sure you want to delete this item? This action cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           Consumer<ConfigProvider>(
//             builder: (context, value, child) => ElevatedButton(
//               onPressed: () {
//                 value.removeItem(category, item);
//                 // setState(() {
//                 //   value.permissionsData[category]!.remove(item);
//                 // });
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('${item['name']} deleted successfully'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               child: CustomText(text: 'Delete', color: Colors.white),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showAddItemDialog(String category, Map<String, dynamic> item) {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController codeController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController provinceController = TextEditingController();
//   TextEditingController rangeController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (context) => Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Container(
//         width: 450,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//         ),
//         child: Form(
//           // key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header with client info
//               Row(
//                 children: [
//                   CustomText(
//                     text: "Add ${category}",
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                     fontSize: 18,
//                   ),
//                   const SizedBox(width: 16),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Form fields
//               CustomTextFormField(
//                 controller: nameController,
//                 label: 'Name',
//                 isRequired: true,
//                 // keyboardType: TextInputType.number,
//               ),
//               if (item.containsKey('code')) ...[
//                 SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: codeController,
//                   label: 'Code',
//                   isRequired: true,
//                   keyboardType: TextInputType.number,
//                 ),
//               ],
//               if (item.containsKey('country')) ...[
//                 SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: countryController,
//                   label: 'Country',
//                   isRequired: true,
//                   // keyboardType: TextInputType.number,
//                 ),
//               ],
//               if (item.containsKey('province')) ...[
//                 SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: provinceController,
//                   label: 'Province',
//                   isRequired: true,
//                   // keyboardType: TextInputType.number,
//                 ),
//               ],
//               if (item.containsKey('range')) ...[
//                 SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: rangeController,
//                   label: 'Range',
//                   isRequired: true,
//                   // keyboardType: TextInputType.number,
//                 ),
//               ],
//               SizedBox(height: 16),

//               // Action buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomActionButton(
//                       text: 'Cancel',
//                       icon: Icons.close,
//                       onPressed: () => Navigator.pop(context),
//                       isFilled: false,
//                       textColor: Colors.blue.shade600,
//                       borderColor: Colors.blue.shade100,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: CustomActionButton(
//                       text: 'Add $category',
//                       icon: Icons.check,
//                       onPressed: () {
//                         ///-- setstate
//                         item['name'] = nameController.text;
//                         if (item.containsKey('code')) {
//                           item['code'] = codeController.text;
//                         }
//                         if (item.containsKey('country')) {
//                           item['country'] = countryController.text;
//                         }
//                         if (item.containsKey('province')) {
//                           item['province'] = provinceController.text;
//                         }
//                         if (item.containsKey('range')) {
//                           item['range'] = rangeController.text;
//                         }

//                         Navigator.of(context).pop();
//                         CustomSnackBar.show(
//                             context, '${item['name']} updated successfully');
//                       },
//                       isFilled: true,
//                       gradient: AppColors.orangeGradient,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       backgroundColor: AppColors.whiteMainColor,
//       title: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: AppColors.blackGradient,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.add, color: AppColors.whiteMainColor),
//             SizedBox(width: 12),
//             Text(
//               'Add New ${category.substring(0, category.length - 1)}',
//               style: TextStyle(
//                 color: AppColors.whiteMainColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       content: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGraident,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildStyledTextField(
//                   nameController,
//                   'Name',
//                   Icons.badge_rounded,
//                 ),
//                 if (category == 'Universities') ...[
//                   SizedBox(height: 16),
//                   _buildStyledTextField(
//                       codeController, 'Code', Icons.code_rounded),
//                   SizedBox(height: 16),
//                   _buildStyledTextField(
//                       countryController, 'Country', Icons.flag_rounded),
//                   SizedBox(height: 16),
//                   _buildStyledTextField(provinceController, 'Province',
//                       Icons.location_on_rounded),
//                 ],
//                 // if (category == 'Salary') ...[
//                 //   SizedBox(height: 16),
//                 //   _buildStyledTextField(rangeController, 'Salary Range',
//                 //       Icons.attach_money_rounded),
//                 // ],
//               ],
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           style: TextButton.styleFrom(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: const Text(
//             'Cancel',
//             style: TextStyle(
//               color: AppColors.textGrayColour,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             gradient: AppColors.blackGradient,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: ElevatedButton(
//             onPressed: () {
//               if (nameController.text.isNotEmpty) {
//                 Map<String, dynamic> newItem = {
//                   'name': nameController.text,
//                   'status': 'active',
//                 };

//                 if (category == 'Universities') {
//                   newItem['code'] = codeController.text;
//                   newItem['country'] = countryController.text;
//                   newItem['province'] = provinceController.text;
//                 }
//                 if (category == 'Salary') {
//                   newItem['range'] = rangeController.text;
//                 }

//                 setState(() {
//                   permissionsData[category]!.add(newItem);
//                 });

//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content:
//                         Text('${nameController.text} added successfully'),
//                     backgroundColor: AppColors.greenSecondaryColor,
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Add',
//               style: TextStyle(
//                 color: AppColors.whiteMainColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   },
// );
}

// void _showAddCategoryDialog() {
//   TextEditingController categoryController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController rangeController = TextEditingController();
//   bool isSalaryCategory = false;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setDialogState) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             backgroundColor: AppColors.whiteMainColor,
//             title: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: AppColors.buttonGraidentColour,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.add, color: AppColors.whiteMainColor),
//                   SizedBox(width: 12),
//                   Text(
//                     'Add New Category',
//                     style: TextStyle(
//                       color: AppColors.whiteMainColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             content: Container(
//               decoration: BoxDecoration(
//                 gradient: AppColors.backgroundGraident,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _buildStyledTextField(categoryController,
//                           'Category Name', Icons.category_rounded),
//                       SizedBox(height: 16),
//                       _buildStyledTextField(
//                           nameController, 'Item Name', Icons.badge_rounded),
//                       SizedBox(height: 16),
//                       // Row(
//                       //   children: [
//                       //     Checkbox(
//                       //       value: isSalaryCategory,
//                       //       onChanged: (value) {
//                       //         setDialogState(() {
//                       //           isSalaryCategory = value!;
//                       //         });
//                       //       },
//                       //     ),
//                       //     Text('Is Salary Category (includes range)', style: TextStyle(color: AppColors.textGrayColour)),
//                       //   ],
//                       // ),
//                       // if (isSalaryCategory) ...[
//                       //   SizedBox(height: 16),
//                       //   _buildStyledTextField(rangeController, 'Salary Range', Icons.attach_money_rounded),
//                       // ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: AppColors.textGrayColour,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: AppColors.buttonGraidentColour,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (categoryController.text.isNotEmpty &&
//                         nameController.text.isNotEmpty) {
//                       setState(() {
//                         permissionsData[categoryController.text] = [
//                           {
//                             'name': nameController.text,
//                             'status': 'active',
//                             if (isSalaryCategory)
//                               'range': rangeController.text,
//                           }
//                         ];
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                               'Category ${categoryController.text} added successfully'),
//                           backgroundColor: AppColors.greenSecondaryColor,
//                           behavior: SnackBarBehavior.floating,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Add',
//                     style: TextStyle(
//                       color: AppColors.whiteMainColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }

// Widget _buildStyledTextField(
//     TextEditingController controller, String label, IconData icon) {
//   return Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           AppColors.whiteMainColor,
//           AppColors.whiteMainColor.withOpacity(0.8),
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: [
//         BoxShadow(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           blurRadius: 8,
//           offset: Offset(0, 2),
//         ),
//       ],
//     ),
//     child: TextField(
//       controller: controller,
//       style: const TextStyle(
//         color: AppColors.primaryColor,
//         fontWeight: FontWeight.w600,
//       ),
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(
//           color: AppColors.textGrayColour,
//           fontWeight: FontWeight.w500,
//         ),
//         // labelStyle: TextStyle(
//         //   color: AppColors.textGrayColour,
//         //   fontWeight: FontWeight.w500,
//         // ),
//         prefixIcon: Icon(icon, color: AppColors.primaryColor),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//       ),
//     ),
//   );
// }

