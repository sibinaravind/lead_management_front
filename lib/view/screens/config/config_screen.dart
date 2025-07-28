import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';

import '../../../controller/config/config_controller.dart';
import '../../../model/app_configs/config_model.dart';
import 'widget/action_button.dart';
import 'widget/add_edit_dialog.dart';

class ConfigScreen extends StatelessWidget {
  final ConfigController controller = Get.put(ConfigController());
  ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.configData.value == null) {
          return const Center(child: Text('No data available'));
        }
        final categories = controller.getAvailableCategories();
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final items = controller.getItemsByCategory(category);

              return Card(
                margin: const EdgeInsets.only(bottom: 20.0),
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.1),
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
                        Colors.white,
                        Colors.white.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(16),
                      childrenPadding: const EdgeInsets.all(16),
                      collapsedBackgroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.roleColors[
                                  index % AppColors.roleColors.length],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.roleColors[
                                          index % AppColors.roleColors.length]
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _getCategoryIcon(category),
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.getCategoryDisplayName(category),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${items.length} items • ${items.where((e) => e.status == "ACTIVE").length} active',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ActionButton(
                            icon: Icons.add,
                            gradient: AppColors.greenGradient,
                            onTap: () => _showAddEditDialog(context, category),
                            tooltip: 'ADD Item',
                          ),
                        ],
                      ),
                      children: [
                        ...items.map(
                            (item) => _buildItemTile(context, category, item)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildItemTile(
      BuildContext context, String category, ConfigModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: item.status == "ACTIVE" ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Color indicator (if item has color)
          if (item.colour != null && item.colour!.isNotEmpty) ...[
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _parseColor(item.colour!),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (_buildSubtitle(item).isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    _buildSubtitle(item),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ActionButton(
                icon: Icons.edit,
                gradient: AppColors.blueGradient,
                onTap: () => _showAddEditDialog(context, category, item: item),
                tooltip: 'Edit Item',
              ),
              const SizedBox(width: 8),
              ActionButton(
                icon: Icons.delete,
                gradient: AppColors.redGradient,
                onTap: () => _showDeleteConfirmation(context, category, item),
                tooltip: 'Delete Item',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _buildSubtitle(ConfigModel item) {
    List<String> parts = [];

    if (item.code != null && item.code!.isNotEmpty) {
      parts.add('Code: ${item.code}');
    }
    if (item.country != null && item.country!.isNotEmpty) {
      parts.add('Country: ${item.country}');
    }
    if (item.province != null && item.province!.isNotEmpty) {
      parts.add('Province: ${item.province}');
    }

    return parts.join(' • ');
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('0X') || colorString.startsWith('0x')) {
        return Color(int.parse(colorString.substring(2), radix: 16));
      }
      return Colors.grey;
    } catch (e) {
      return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'branch':
        return Icons.location_on;
      case 'education_program':
        return Icons.school;
      case 'known_languages':
        return Icons.language;
      case 'call_status':
        return Icons.phone_callback;
      case 'university':
        return Icons.account_balance;
      case 'intake':
        return Icons.calendar_today;
      case 'country':
        return Icons.public;
      case 'lead_source':
        return Icons.source;
      case 'service_type':
        return Icons.build;
      case 'profession':
        return Icons.work;
      case 'medical_profession_category':
        return Icons.medical_services;
      case 'non_medical':
        return Icons.business;
      case 'call_type':
        return Icons.call;
      case 'client_status':
        return Icons.person;
      case 'designation':
        return Icons.badge;
      case 'specialized':
        return Icons.psychology;
      case 'qualification':
        return Icons.school_outlined;
      default:
        return Icons.category;
    }
  }

  void _showAddEditDialog(BuildContext context, String category,
      {ConfigModel? item}) {
    showDialog(
      context: context,
      builder: (context) => AddEditDialog(
        category: category,
        item: item != null ? controller.configModelToMap(item) : null,
        onSave: (data) {
          if (item == null) {
            controller.addItem(category, data);
          } else {
            controller.updateItem(category, item.id!, data);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, String category, ConfigModel item) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('Confirm Delete'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete the following item?'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color:
                          item.status == "ACTIVE" ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.name ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This action cannot be undone.',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteItem(category, item.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
