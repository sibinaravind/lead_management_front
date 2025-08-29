import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/view/screens/project/flavour/customer_project_flavour.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/delete_confirm_dialog.dart';
import 'add_edit_project.dart';

class ProjectUserListTable extends StatelessWidget {
  final List<ProjectModel> userlist;
  const ProjectUserListTable({super.key, required this.userlist});

  @override
  Widget build(BuildContext context) {
    final projectController = Get.find<ProjectController>();
    final horizontalController = ScrollController();
    final verticalController = ScrollController();
    final columnsData = ProjectFlavour.projectTableList();

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
                    rows: projectController.filteredProjects.map((listUser) {
                      return DataRow(
                        color: WidgetStateProperty.resolveWith<Color?>(
                            (_) => Colors.white),
                        cells: columnsData.map((column) {
                          final extractor = column['extractor'] as Function;
                          final value = extractor(listUser);

                          return DataCell(
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 200,
                              ),
                              child: Builder(
                                builder: (context) {
                                  switch (column['name']) {
                                    case 'Project Name':
                                    case 'Job Position':
                                      return CustomText(
                                        text: value,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.orangeSecondaryColor,
                                      );
                                    case 'Status':
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.primaryColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: CustomText(
                                            text: value,
                                            fontSize: 12,
                                            color: AppColors.whiteMainColor),
                                      );
                                    case 'Action':
                                      return PopupMenuButton<int>(
                                        color: Colors.white,
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AddEditProject(
                                                isEditMode: true,
                                                project: listUser,
                                              ),
                                            ),
                                            value: 1,
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: AppColors
                                                      .greenSecondaryColor,
                                                ),
                                                SizedBox(width: 5),
                                                Text("Edit"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DeleteConfirmationDialog(
                                                title: "Delete",
                                                message: "Are you sure?",
                                                onConfirm: () async {
                                                  showLoaderDialog(context);
                                                  await projectController
                                                      .deleteProject(
                                                    context,
                                                    listUser.sId ?? '',
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: AppColors
                                                      .redSecondaryColor,
                                                ),
                                                SizedBox(width: 5),
                                                Text("Delete"),
                                              ],
                                            ),
                                          ),
                                        ],
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
                              // if (column['name'] == 'Project Name') {
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => ProjectDetailsTab(
                              //       project: listUser,
                              //     ),
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
  }
}
