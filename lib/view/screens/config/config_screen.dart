import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/config/config_controller.dart';
import 'widget/add_edit_dialog.dart';

class ConfigScreen extends StatelessWidget {
  final ConfigController controller = Get.put(ConfigController());

  ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Configuration'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.configData.value == null) {
          return const Center(child: Text('No data available'));
        }

        final categories = controller.configData.value!.keys.toList();

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
                              color: _getCategoryColor(index),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      _getCategoryColor(index).withOpacity(0.3),
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
                                  '${items.length} items • ${items.where((e) => e['status'] == 'ACTIVE').length} active',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildActionButton(
                            icon: Icons.add,
                            color: Colors.green,
                            onTap: () => _showAddEditDialog(context, category),
                            tooltip: 'Add New Item',
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
      BuildContext context, String category, Map<String, dynamic> item) {
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
              color: item['status'] == 'ACTIVE' ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? 'No Name',
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
              _buildActionButton(
                icon: Icons.edit,
                color: Colors.blue,
                onTap: () => _showAddEditDialog(context, category, item: item),
                tooltip: 'Edit Item',
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                icon: Icons.delete,
                color: Colors.red,
                onTap: () => _showDeleteConfirmation(context, category, item),
                tooltip: 'Delete Item',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  String _buildSubtitle(Map<String, dynamic> item) {
    List<String> parts = [];

    if (item.containsKey('program') &&
        item['program'] != null &&
        item['program'].toString().isNotEmpty) {
      parts.add('Program: ${item['program']}');
    }
    if (item.containsKey('address') &&
        item['address'] != null &&
        item['address'].toString().isNotEmpty) {
      parts.add('Address: ${item['address']}');
    }
    if (item.containsKey('phone') &&
        item['phone'] != null &&
        item['phone'].toString().isNotEmpty) {
      parts.add('Phone: ${item['phone']}');
    }
    if (item.containsKey('category') &&
        item['category'] != null &&
        item['category'].toString().isNotEmpty) {
      parts.add('Category: ${item['category']}');
    }
    if (item.containsKey('colour') &&
        item['colour'] != null &&
        item['colour'].toString().isNotEmpty) {
      parts.add('Color: ${item['colour']}');
    }

    return parts.join(' • ');
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'program_type':
        return Icons.school;
      case 'program':
        return Icons.book;
      case 'country':
        return Icons.public;
      case 'lead_source':
        return Icons.source;
      case 'service_type':
        return Icons.build;
      case 'call_type':
        return Icons.call;
      case 'call_status':
        return Icons.phone_callback;
      case 'client_status':
        return Icons.person;
      case 'test':
        return Icons.quiz;
      case 'branch':
        return Icons.location_on;
      case 'job_category':
        return Icons.work;
      case 'specialized':
        return Icons.medical_services;
      case 'closed_status':
        return Icons.close;
      default:
        return Icons.category;
    }
  }

  void _showAddEditDialog(BuildContext context, String category,
      {Map<String, dynamic>? item}) {
    print("hello");
    showDialog(
      context: context,
      builder: (context) => AddEditDialog(
        category: category,
        item: item,
        onSave: (data) {
          if (item == null) {
            controller.addItem(category, data);
          } else {
            controller.updateItem(category, item['_id'], data);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, String category, Map<String, dynamic> item) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${item['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteItem(category, item['_id']);
              Get.back();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
