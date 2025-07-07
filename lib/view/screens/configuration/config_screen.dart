import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/screens/configuration/widget/show_dialogue_widget.dart';
import 'package:overseas_front_end/view/widgets/custom_button.dart';

import '../../../res/style/colors/colors.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _SystemConfigState();
}

class _SystemConfigState extends State<ConfigScreen> {

  Map<String, List<Map<String, dynamic>>> permissionsData = {
    'Education Programs': [
      {'name': 'PG', 'status': 'active'},
      {'name': 'UG', 'status': 'active'},
      {'name': 'Diploma', 'status': 'active'},
      {'name': 'Pre Masters', 'status': 'active'},
      {'name': 'Masters by Taught', 'status': 'active'},
      {'name': 'Masters by Research', 'status': 'active'},
      {'name': 'Foundation', 'status': 'active'},
      {'name': '10th', 'status': 'active'},
      {'name': '12th', 'status': 'active'},
      {'name': 'PhD', 'status': 'active'},
    ],
    'Known Languages': [
      {'name': 'Malayalam', 'status': 'active'},
      {'name': 'English', 'status': 'active'},
      {'name': 'Hindi', 'status': 'active'},
    ],
    'Universities': [
      {
        'name': 'Cam',
        'code': '12',
        'country': 'Canada',
        'province': 'CAN',
        'status': 'active'
      },
      {
        'name': 'Oxford',
        'code': '13',
        'country': 'UK',
        'province': 'ENG',
        'status': 'inactive'
      },
      {
        'name': 'MIT',
        'code': '14',
        'country': 'USA',
        'province': 'MA',
        'status': 'active'
      },
      {
        'name': 'Stanford',
        'code': '15',
        'country': 'USA',
        'province': 'CA',
        'status': 'active'
      },
    ],
    'Job Type': [
      {'name': 'Full-time', 'status': 'active'},
      {'name': 'Part-time', 'status': 'active'},
      {'name': 'Contract', 'status': 'active'},
    ],
    'Salary': [
      {'name': 'Entry Level', 'range': '0-50K', 'status': 'active'},
      {'name': 'Mid Level', 'range': '50K-100K', 'status': 'active'},
      {'name': 'Senior Level', 'range': '100K+', 'status': 'active'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGraident,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: permissionsData.keys.length,
          itemBuilder: (context, index) {
            String category = permissionsData.keys.elementAt(index);
            List<Map<String, dynamic>> items = permissionsData[category]!;

            return Card(
              borderOnForeground: false,
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
                            gradient: _getCategoryGradient(category),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: _getCategoryColor(category)
                                    .withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            _getCategoryIcon(category),
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
                                category,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${items.length} items • ${items.where((item) => item['status'] == 'active').length} active',
                                style: const TextStyle(
                                  color: AppColors.textGrayColour,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildActionButton(
                          icon: Icons.add,
                          gradient: AppColors.buttonGraidentColour,
                          onTap: () => _showAddItemDialog(category),
                          tooltip: 'Add New Item',
                        ),
                      ],
                    ),
                    children: [
                      ...items.map((item) {
                        return _buildPermissionItem(category, item);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPermissionItem(String category, Map<String, dynamic> item) {
    bool isActive = item['status'] == 'active';

    return Container(
      margin:const  EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                    item['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  if (item.containsKey('code') ||
                      item.containsKey('country') ||
                      item.containsKey('range'))
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
                _buildActionButton(
                  icon: isActive ? Icons.toggle_on : Icons.toggle_off,
                  gradient: isActive
                      ? AppColors.greenGradient
                      : AppColors.redGradient,
                  onTap: () => _toggleStatus(category, item),
                  tooltip: isActive ? 'Deactivate' : 'Activate',
                ),
                SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.edit_rounded,
                  gradient: AppColors.buttonGraidentColour,
                  // onTap: () => _showEditDialog(category, item),
                  onTap: () => configEditDialog(context,category,item),
                  tooltip: 'Edit',
                ),
                SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete_rounded,
                  gradient: AppColors.redGradient,
                  onTap: () => _showDeleteDialog(category, item),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
    if (item.containsKey('province'))
      parts.add('Province: ${item['province']}');
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Education Programs':
        return AppColors.violetPrimaryColor;
      case 'Known Languages':
        return AppColors.orangeSecondaryColor;
      case 'Universities':
        return AppColors.greenSecondaryColor;
      case 'Job Type':
        return AppColors.pinkSecondaryColor;
      case 'Salary':
        return AppColors.blueSecondaryColor;
      default:
        return AppColors.primaryColor;
    }
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

  void _showEditDialog(String category, Map<String, dynamic> item) {
    TextEditingController nameController =
    TextEditingController(text: item['name']);
    TextEditingController codeController =
    TextEditingController(text: item['code'] ?? '');
    TextEditingController countryController =
    TextEditingController(text: item['country'] ?? '');
    TextEditingController provinceController =
    TextEditingController(text: item['province'] ?? '');
    TextEditingController rangeController =
    TextEditingController(text: item['range'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.whiteMainColor,
          title: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.buttonGraidentColour,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.edit_rounded, color: AppColors.whiteMainColor),
                SizedBox(width: 12),
                Text(
                  'Edit ${category.substring(0, category.length - 1)}',
                  style: TextStyle(
                    color: AppColors.whiteMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              gradient: AppColors.backgroundGraident,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStyledTextField(
                        nameController, 'Name', Icons.badge_rounded),
                    if (item.containsKey('code')) ...[
                      SizedBox(height: 16),
                      _buildStyledTextField(
                          codeController, 'Code', Icons.code_rounded),
                    ],
                    if (item.containsKey('country')) ...[
                      SizedBox(height: 16),
                      _buildStyledTextField(
                          countryController, 'Country', Icons.flag_rounded),
                    ],
                    if (item.containsKey('province')) ...[
                      SizedBox(height: 16),
                      _buildStyledTextField(provinceController, 'Province',
                          Icons.location_on_rounded),
                    ],
                    if (item.containsKey('range')) ...[
                      SizedBox(height: 16),
                      _buildStyledTextField(rangeController, 'Salary Range',
                          Icons.attach_money_rounded),
                    ],
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textGrayColour,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGraidentColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    item['name'] = nameController.text;
                    if (item.containsKey('code'))
                      item['code'] = codeController.text;
                    if (item.containsKey('country'))
                      item['country'] = countryController.text;
                    if (item.containsKey('province'))
                      item['province'] = provinceController.text;
                    if (item.containsKey('range'))
                      item['range'] = rangeController.text;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item['name']} updated successfully'),
                      backgroundColor: AppColors.greenSecondaryColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.whiteMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(String category, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${item['name']}'),
          content: Text(
              'Are you sure you want to delete this item? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  permissionsData[category]!.remove(item);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item['name']} deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(String category) {
    TextEditingController nameController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController provinceController = TextEditingController();
    TextEditingController rangeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.whiteMainColor,
          title: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.blackGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.add, color: AppColors.whiteMainColor),
                SizedBox(width: 12),
                Text(
                  'Add New ${category.substring(0, category.length - 1)}',
                  style: TextStyle(
                    color: AppColors.whiteMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              gradient: AppColors.backgroundGraident,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStyledTextField(
                      nameController, 'Name', Icons.badge_rounded, ),
                    if (category == 'Universities') ...[
                      SizedBox(height: 16),
                      _buildStyledTextField(
                          codeController, 'Code', Icons.code_rounded),
                      SizedBox(height: 16),
                      _buildStyledTextField(
                          countryController, 'Country', Icons.flag_rounded),
                      SizedBox(height: 16),
                      _buildStyledTextField(provinceController, 'Province',
                          Icons.location_on_rounded),
                    ],
                    // if (category == 'Salary') ...[
                    //   SizedBox(height: 16),
                    //   _buildStyledTextField(rangeController, 'Salary Range',
                    //       Icons.attach_money_rounded),
                    // ],
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:const  Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textGrayColour,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.blackGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    Map<String, dynamic> newItem = {
                      'name': nameController.text,
                      'status': 'active',
                    };

                    if (category == 'Universities') {
                      newItem['code'] = codeController.text;
                      newItem['country'] = countryController.text;
                      newItem['province'] = provinceController.text;
                    }
                    if (category == 'Salary') {
                      newItem['range'] = rangeController.text;
                    }

                    setState(() {
                      permissionsData[category]!.add(newItem);
                    });

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                        Text('${nameController.text} added successfully'),
                        backgroundColor: AppColors.greenSecondaryColor,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: AppColors.whiteMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddCategoryDialog() {
    TextEditingController categoryController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController rangeController = TextEditingController();
    bool isSalaryCategory = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColors.whiteMainColor,
              title: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGraidentColour,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.whiteMainColor),
                    SizedBox(width: 12),
                    Text(
                      'Add New Category',
                      style: TextStyle(
                        color: AppColors.whiteMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.backgroundGraident,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildStyledTextField(categoryController,
                            'Category Name', Icons.category_rounded),
                        SizedBox(height: 16),
                        _buildStyledTextField(
                            nameController, 'Item Name', Icons.badge_rounded),
                        SizedBox(height: 16),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: isSalaryCategory,
                        //       onChanged: (value) {
                        //         setDialogState(() {
                        //           isSalaryCategory = value!;
                        //         });
                        //       },
                        //     ),
                        //     Text('Is Salary Category (includes range)', style: TextStyle(color: AppColors.textGrayColour)),
                        //   ],
                        // ),
                        // if (isSalaryCategory) ...[
                        //   SizedBox(height: 16),
                        //   _buildStyledTextField(rangeController, 'Salary Range', Icons.attach_money_rounded),
                        // ],
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.textGrayColour,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGraidentColour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (categoryController.text.isNotEmpty &&
                          nameController.text.isNotEmpty) {
                        setState(() {
                          permissionsData[categoryController.text] = [
                            {
                              'name': nameController.text,
                              'status': 'active',
                              if (isSalaryCategory)
                                'range': rangeController.text,
                            }
                          ];
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Category ${categoryController.text} added successfully'),
                            backgroundColor: AppColors.greenSecondaryColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: AppColors.whiteMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStyledTextField(
      TextEditingController controller, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        gradient:
        LinearGradient(
          colors: [
            AppColors.whiteMainColor,
            AppColors.whiteMainColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: AppColors.textGrayColour,
            fontWeight: FontWeight.w500,
          ),
          // labelStyle: TextStyle(
          //   color: AppColors.textGrayColour,
          //   fontWeight: FontWeight.w500,
          // ),
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
    );
  }
}
