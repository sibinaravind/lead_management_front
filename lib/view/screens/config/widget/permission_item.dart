import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/enums.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';
import 'package:overseas_front_end/view/screens/config/widget/delete_dialogue.dart';
import 'package:provider/provider.dart';

import '../../../../controller/config_provider.dart';
import '../../../../res/style/colors/colors.dart';
import 'action_button.dart';
import 'show_dialogue_widget.dart';

class PermissionItem extends StatelessWidget {
  const PermissionItem({super.key, required this.category, required this.item});

  final String category;
  final ConfigModel item;

  @override
  Widget build(BuildContext context) {
    bool isActive = item.status == Status.ACTIVE;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [
                  AppColors.greenSecondaryColor.withOpacity(0.1),
                  AppColors.greenSecondaryColor.withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : LinearGradient(
                colors: [
                  AppColors.redSecondaryColor.withOpacity(0.1),
                  AppColors.redSecondaryColor.withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? AppColors.greenSecondaryColor.withOpacity(0.3)
              : AppColors.redSecondaryColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isActive
                ? AppColors.greenSecondaryColor.withOpacity(0.1)
                : AppColors.redSecondaryColor.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient:
                    isActive ? AppColors.greenGradient : AppColors.redGradient,
                boxShadow: [
                  BoxShadow(
                    color: isActive
                        ? AppColors.greenSecondaryColor.withOpacity(0.4)
                        : AppColors.redSecondaryColor.withOpacity(0.4),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isActive ? Icons.check : Icons.close,
                color: AppColors.whiteMainColor,
                size: 12,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  if (item.hasField('code') ||
                      item.hasField('country') ||
                      item.hasField('range'))
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.blueNeutralColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _buildSubtitle(item),
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textGrayColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionButton(
                  icon: isActive ? Icons.toggle_on : Icons.toggle_off,
                  gradient: isActive
                      ? AppColors.greenGradient
                      : AppColors.redGradient,
                  onTap: () {
                    Provider.of<ConfigProvider>(context, listen: false)
                        .toggleStatus(context, category, item);
                  },
                  tooltip: isActive ? 'Deactivate' : 'Activate',
                ),
                SizedBox(width: 8),
                if (category != "designation")
                  ActionButton(
                    icon: Icons.edit_rounded,
                    gradient: AppColors.buttonGraidentColour,
                    // onTap: () => _showEditDialog(category, item),
                    onTap: () => configEditDialog(context, category, item),
                    tooltip: 'Edit',
                  ),
                SizedBox(width: 8),
                if (category != "designation")
                  ActionButton(
                    icon: Icons.delete_rounded,
                    gradient: AppColors.redGradient,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) =>
                          DeleteDialogue(category: category, item: item),
                    ),
                    tooltip: 'Delete',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleStatus(String category, Map<String, dynamic> item) {
    // setState(() {
    item['status'] = item['status'] == 'active' ? 'inactive' : 'active';
    // });
  }

  String _buildSubtitle(ConfigModel item) {
    List<String> parts = [];
    if (item.code != null) parts.add('Code: ${item.code}');
    if (item.country != null) parts.add('Country: ${item.country}');
    if (item.province != null) {
      parts.add('Province: ${item.province}');
    }
    // if (item.hasField('range')) parts.add('Range: ${item.}');
    return parts.join(' • ');
  }
}
