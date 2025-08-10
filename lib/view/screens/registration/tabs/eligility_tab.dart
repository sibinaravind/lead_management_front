import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';

import '../../../../model/lead/exam_record_model.dart';
import '../../../../model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/popup_date_field.dart';
import '../../../widgets/widgets.dart';

class EligibilityTab extends StatefulWidget {
  LeadModel? leadModel;
  EligibilityTab({super.key, this.leadModel});

  @override
  State<EligibilityTab> createState() => _AcadamicTabState();
}

class _AcadamicTabState extends State<EligibilityTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ExamRecordModel> _records = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academic Records List
          const CustomText(
              text: 'Eligibility Records',
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
                              text: 'Exam Name', fontWeight: FontWeight.bold)),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: 100,
                            child: CustomText(
                                text: 'status', fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          flex: 3,
                          child: CustomText(
                              text: 'Validity Date',
                              fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 2,
                          child: CustomText(
                              text: 'Exam Date', fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 2,
                          child: CustomText(
                              text: 'grade', fontWeight: FontWeight.bold)),
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
                      child: CustomText(text: 'No exams  added yet'),
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
                              child: CustomText(text: record.exam ?? '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(text: record.status ?? '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(
                                  text:
                                      formatDatetoString(record.validityDate) ??
                                          '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(
                                  text: formatDatetoString(record.examDate) ??
                                      '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(text: record.grade ?? '')),
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
                text: 'Add Exams',
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
                    if (_formKey.currentState?.validate() ?? true) {
                      // Save form data and records
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRecordDialog({ExamRecordModel? recordToEdit, int? editIndex}) {
    final isEditing = recordToEdit != null;
    // final qualificationController = TextEditingController(
    //   text: recordToEdit?.qualification ?? '',
    // );

    final examName = TextEditingController(
      text: recordToEdit?.exam ?? '',
    );
    // final status = TextEditingController(
    //   text: recordToEdit?.status ?? '',
    // );
    final validDate = TextEditingController(
      text: formatDatetoString(recordToEdit?.validityDate),
    );
    final examDate = TextEditingController(
      text: formatDatetoString(recordToEdit?.examDate),
    );
    final grade = TextEditingController(
      text: recordToEdit?.grade ?? '',
    );
    final dialogFormKey = GlobalKey<FormState>();
    String? exam = 'HRD';
    String? status = 'HRD';

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
                                ? 'Edit Exam Record'
                                : 'Add Exam Record',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: isEditing
                                ? 'Update your Exam information'
                                : 'Enter your Exam details',
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
                        label: 'Exam',
                        value: exam,
                        items: const [
                          'Data flow',
                          'Prometric',
                          'HRD',
                        ],
                        onChanged: (value) {
                          setState(() {
                            exam = value;
                          });
                        },
                      ),
                      PopupDropDownField(
                        label: 'Status',
                        value: status,
                        items: const [
                          'Pass',
                          'Failed',
                          'Applied for Exam',
                        ],
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                      PopupDateField(
                          label: "Validity Date", controller: validDate),
                      const SizedBox(height: 16),
                      PopupDateField(label: "Exam Date", controller: examDate),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Expanded(
                              child: Expanded(
                                child: PopupTextField(
                                  requiredField: false,
                                  label: 'Grade',
                                  controller: grade,
                                  icon: Icons.grade,
                                  hint: 'e.g., 8.5',
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(width: 16),
                          // Expanded(
                          //   child: _buildStyledTextFormField(
                          //     label: 'Grade/CGPA',
                          //     controller: gradeController,
                          //     icon: Icons.grade,
                          //     hint: 'e.g., 8.5',
                          //   ),
                          // ),
                          // const SizedBox(width: 16),
                          //
                          // Expanded(
                          //   child: _buildStyledTextFormField(
                          //     label: 'Percentage',
                          //     controller: percentageController,
                          //     icon: Icons.percent,
                          //     hint: 'e.g., 85',
                          //   ),
                          // ),
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
                          final newRecord = ExamRecordModel(
                            exam: exam.toString(),
                            validityDate: formatStringToDate(validDate.text),
                            examDate: formatStringToDate(examDate.text),
                            status: status.toString(),
                            grade: grade.text,
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

  Widget _buildStyledTextFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ],
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
                    text: record.exam ?? '',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: record.status ?? '',
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                  CustomText(
                    text: formatDatetoString(record.validityDate),
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  CustomText(
                    text: formatDatetoString(record.examDate),
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                  CustomText(
                    text: record.grade ?? '',
                    color: Colors.grey[700],
                    fontSize: 13,
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
