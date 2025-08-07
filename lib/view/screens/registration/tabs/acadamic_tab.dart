import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/registration/registration_controller.dart';
// import 'package:provider/provider.dart';

import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/widgets.dart';

class AcademicRecord {
  final String qualification;
  final String institution;
  final String year;
  final String grade;
  final String percentage;

  AcademicRecord({
    required this.qualification,
    required this.institution,
    required this.year,
    required this.grade,
    required this.percentage,
  });

  factory AcademicRecord.fromJson(Map<String, dynamic> json) {
    return AcademicRecord(
      qualification: json['qualification'] ?? '',
      institution: json['institution'] ?? '',
      year: json['year'] ?? '',
      grade: json['grade'] ?? '',
      percentage: json['percentage'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'qualification': qualification,
      'institution': institution,
      'year': year,
      'grade': grade,
      'percentage': percentage,
    };
  }

  // Copy with method for creating modified copies
  AcademicRecord copyWith({
    String? qualification,
    String? institution,
    String? year,
    String? grade,
    String? percentage,
  }) {
    return AcademicRecord(
      qualification: qualification ?? this.qualification,
      institution: institution ?? this.institution,
      year: year ?? this.year,
      grade: grade ?? this.grade,
      percentage: percentage ?? this.percentage,
    );
  }
}

class AcadamicTab extends StatefulWidget {
  const AcadamicTab({super.key, required this.id});

  final String id;

  @override
  State<AcadamicTab> createState() => _AcadamicTabState();
}

class _AcadamicTabState extends State<AcadamicTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<AcademicRecord> _records = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academic Records List
          const CustomText(
              text: 'Academic Records',
              fontSize: 16,
              fontWeight: FontWeight.bold),

          const SizedBox(height: 16),

          // Academic Records Table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[200],
                  child: const Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: CustomText(
                              text: 'Qualification',
                              fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 3,
                          child: CustomText(
                              text: 'Institution',
                              fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 2,
                          child: CustomText(
                              text: 'Year', fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 2,
                          child: CustomText(
                              text: 'Grade/CGPA', fontWeight: FontWeight.bold)),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: 100,
                            child: CustomText(
                                text: 'Percentage',
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                          width: 100,
                          child: CustomText(
                              text: 'Actions', fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                if (_records.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Center(
                      child: CustomText(text: 'No academic records added yet'),
                    ),
                  )
                else
                  ..._records.asMap().entries.map((entry) {
                    final i = entry.key;
                    final record = entry.value;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: CustomText(text: record.qualification)),
                          Expanded(
                              flex: 3,
                              child: CustomText(text: record.institution)),
                          Expanded(
                              flex: 2, child: CustomText(text: record.year)),
                          Expanded(
                              flex: 2, child: CustomText(text: record.grade)),
                          Expanded(
                              flex: 2,
                              child: CustomText(text: record.percentage)),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: AppColors.blueSecondaryColor),
                                  tooltip: 'Edit',
                                  onPressed: () => _showRecordDialog(
                                    recordToEdit: record,
                                    editIndex: i,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: AppColors.redSecondaryColor),
                                  tooltip: 'Delete',
                                  onPressed: () => _showDeleteConfirmation(i),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
              onPressed: () => _showRecordDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(200, 48),
              ),
              child: const CustomText(
                text: 'Add Academic Record',
                color: AppColors.textWhiteColour,
              )),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const CustomText(text: 'Cancel')),
                const SizedBox(width: 16),
                CustomButton(
                  text: 'Save',
                  width: 100,
                  onTap: () {
                    // if (_formKey.currentState?.validate() ?? true) {
                    //   // Save form data and records
                    //   Provider.of<RegistrationController>(context,
                    //           listen: false)
                    //       .addAcademicRecords(context,
                    //           educationList:
                    //               _records.map((e) => e.toJson()).toList(),
                    //           leadId: widget.id);
                    //   Navigator.pop(context);
                    // }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRecordDialog({AcademicRecord? recordToEdit, int? editIndex}) {
    final isEditing = recordToEdit != null;
    // final qualificationController = TextEditingController(
    //   text: recordToEdit?.qualification ?? '',
    // );
    final institutionController = TextEditingController(
      text: recordToEdit?.institution ?? '',
    );
    final yearController = TextEditingController(
      text: recordToEdit?.year ?? '',
    );
    final gradeController = TextEditingController(
      text: recordToEdit?.grade ?? '',
    );
    final percentageController = TextEditingController(
      text: recordToEdit?.grade ?? '',
    );
    final dialogFormKey = GlobalKey<FormState>();
    String? qualification = 'MSc';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isEditing ? Icons.edit : Icons.add,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: isEditing
                                ? 'Edit Academic Record'
                                : 'Add Academic Record',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: isEditing
                                ? 'Update your academic information'
                                : 'Enter your academic details',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Form content with enhanced styling
                Form(
                  key: dialogFormKey,
                  child: Column(
                    children: [
                      PopupDropDownField(
                        label: 'Qualification',
                        value: qualification,
                        items: const ['MSc', 'MCA', 'BSc', 'BCA', 'MA', 'BA'],
                        onChanged: (value) {
                          setState(() {
                            qualification = value;
                          });
                        },
                      ),
                      // PopupTextField(
                      //   label: 'Qualification',
                      //   controller: qualificationController,
                      //   icon: Icons.school,
                      //   hint: 'e.g., Bachelor of Engineering',
                      // ),
                      const SizedBox(height: 16),
                      PopupTextField(
                        requiredField: false,
                        label: 'Institution',
                        controller: institutionController,
                        icon: Icons.business,
                        hint: 'e.g., University of Technology',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: PopupTextField(
                              requiredField: false,
                              label: 'Year',
                              controller: yearController,
                              icon: Icons.calendar_today,
                              hint: 'e.g., 2023',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: PopupTextField(
                              requiredField: false,
                              label: 'Grade/CGPA',
                              controller: gradeController,
                              icon: Icons.grade,
                              hint: 'e.g., 8.5',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: PopupTextField(
                              requiredField: false,
                              label: 'Percentage',
                              controller: percentageController,
                              icon: Icons.percent,
                              hint: 'e.g., 85',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Action buttons with enhanced styling
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: CustomText(
                        text: 'Cancel',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (dialogFormKey.currentState!.validate()) {
                          final newRecord = AcademicRecord(
                            percentage: percentageController.text.trim(),
                            qualification: qualification ?? '',
                            institution: institutionController.text.trim(),
                            year: yearController.text.trim(),
                            grade: gradeController.text.trim(),
                          );
                          setState(() {
                            if (isEditing && editIndex != null) {
                              _records[editIndex] = newRecord;
                            } else {
                              _records.add(newRecord);
                            }
                          });
                          Navigator.pop(context);

                          // Show success message
                          CustomSnackBar.show(
                              context,
                              isEditing
                                  ? 'Academic record updated successfully!'
                                  : 'Academic record added successfully!');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isEditing ? Icons.update : Icons.add,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            text: isEditing ? 'Update' : 'Add Record',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    final record = _records[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.warning,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const CustomText(
              text: 'Confirm Delete',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
                text: 'Are you sure you want to delete this academic record?',
                fontSize: 16),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: record.qualification,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: record.institution,
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                  CustomText(
                    text: '${record.year} • Grade: ${record.grade}',
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              text: 'This action cannot be undone.',
              color: Colors.red[600],
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: CustomText(
              text: 'Cancel',
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _records.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      CustomText(text: 'Academic record deleted successfully!'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete, size: 16),
                SizedBox(width: 6),
                CustomText(text: 'Delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
