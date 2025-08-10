import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';
import 'package:overseas_front_end/view/widgets/popup_date_field.dart';

import '../../../../model/lead/travel_record_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/widgets.dart';

class TravelDetails extends StatefulWidget {
  final LeadModel leadModel;
  const TravelDetails({super.key, required this.leadModel});

  @override
  State<TravelDetails> createState() => _AcadamicTabState();
}

class _AcadamicTabState extends State<TravelDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TravelRecordModel> _records = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academic Records List
          const CustomText(
              text: 'Travel Records',
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
                              text: 'Country', fontWeight: FontWeight.bold)),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: 100,
                            child: CustomText(
                                text: 'Visa Category',
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          flex: 3,
                          child: CustomText(
                              text: 'Departure Date',
                              fontWeight: FontWeight.bold)),
                      Expanded(
                          flex: 2,
                          child: CustomText(
                              text: 'Return Date',
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          width: 100,
                          child: CustomText(
                              text: 'Validity', fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                if (_records.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Center(
                      child: CustomText(text: 'No travel details added yet'),
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
                              child: CustomText(text: record.country ?? '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(text: record.visaType ?? '')),
                          Expanded(
                              flex: 2,
                              child: CustomText(
                                  text: formatDatetoString(
                                      record.departureDate))),
                          Expanded(
                              flex: 2,
                              child: CustomText(
                                  text: formatDatetoString(record.returnDate))),
                          Expanded(
                              flex: 2,
                              child: CustomText(
                                  text: formatDatetoString(
                                      record.visaValidDate))),
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
                text: 'Add Travel Details',
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

  void _showRecordDialog({TravelRecordModel? recordToEdit, int? editIndex}) {
    final isEditing = recordToEdit != null;
    String? country = 'Choose ...';
    String? visaCategory = 'Choose ...';

    final departureController = TextEditingController(
      text: formatDatetoString(recordToEdit?.departureDate),
    );
    final returnController = TextEditingController(
      text: formatDatetoString(recordToEdit?.returnDate),
    );
    final validityController = TextEditingController(
      text: formatDatetoString(recordToEdit?.visaValidDate),
    );

    final dialogFormKey = GlobalKey<FormState>();

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
                                ? 'Edit Travel Record'
                                : 'Add Travel Record',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: isEditing
                                ? 'Update your Travel details'
                                : 'Enter your Travel details',
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
                      // _buildStyledTextFormField(label: '', controller: position, icon:, hint: ''),
                      PopupDropDownField(
                          label: 'Country',
                          value: country,
                          items: const [
                            'India',
                            'USA',
                            'UK',
                            'Australia',
                            'Canada',
                            'Other'
                          ],
                          onChanged: (value) {
                            country = value;
                          }),
                      const SizedBox(height: 16),
                      PopupDropDownField(
                          label: 'Visa Category',
                          value: visaCategory,
                          items: const [
                            'Company Visa',
                            'Students visa',
                            'Direct',
                            'Business'
                          ],
                          onChanged: (value) {
                            visaCategory = value;
                          }),
                      const SizedBox(height: 16),
                      Row(
                        //  spacing: 10,
                        children: [
                          Expanded(
                            child: PopupDateField(
                                label: "Departure Date",
                                controller: departureController),
                          ),
                          Expanded(
                            child: PopupDateField(
                                label: "Return Date",
                                controller: returnController),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      PopupTextField(
                          requiredField: true,
                          label: "Validity",
                          controller: validityController,
                          icon: Icons.verified_outlined,
                          hint: 'Validity Details'),
                      const SizedBox(height: 16),
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
                          final newRecord = TravelRecordModel(
                              country: country.toString(),
                              visaType: visaCategory.toString(),
                              departureDate:
                                  formatStringToDate(departureController.text),
                              returnDate:
                                  formatStringToDate(returnController.text),
                              visaValidDate:
                                  formatStringToDate(validityController.text));
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
                text: 'Are you sure you want to delete this Travel record?',
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
                    text: record.country ?? '',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: record.visaType ?? '',
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                  CustomText(
                    text: formatDatetoString(record.visaValidDate),
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  CustomText(
                    text: formatDatetoString(record.returnDate),
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                  CustomText(
                    text: formatDatetoString(record.visaValidDate),
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
                      CustomText(text: 'Visa details deleted successfully!'),
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
