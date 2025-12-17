import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/view/widgets/upload_document_popup.dart';
import '../../../../controller/config/config_controller.dart';
import '../../../../core/shared/constants.dart';
import '../../../../model/lead/document_record_model.dart';
import '../../../../model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/view_doc_widget.dart';
import 'info_item.dart';
import 'info_section.dart';

class DocumentsTab extends StatelessWidget {
  final LeadModel lead;

  const DocumentsTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoSection(
              title: 'ID Information',
              icon: Icons.assignment_outlined,
              items: [
                InfoItem(
                    label: 'ID Proof Type',
                    value: lead.idProofType ?? 'N/A',
                    icon: Icons.badge,
                    iconColor: AppColors.orangeSecondaryColor),
                InfoItem(
                    label: 'ID Proof Number',
                    value: lead.idProofNumber?.toString() ?? 'N/A',
                    icon: Icons.confirmation_number,
                    iconColor: AppColors.blueSecondaryColor),
                InfoItem(
                    label: 'Passport Number',
                    value: lead.passportNumber?.toString() ?? 'N/A',
                    icon: Icons.book,
                    iconColor: AppColors.greenSecondaryColor),
                InfoItem(
                    label: 'Passport Expiry Date',
                    value: lead.passportExpiryDate ?? 'N/A',
                    icon: Icons.book_online,
                    iconColor: AppColors.viloletSecondaryColor),
                InfoItem(
                    label: 'PAN Card Number',
                    value: lead.panCardNumber?.toString() ?? 'N/A',
                    icon: Icons.credit_card,
                    iconColor: AppColors.redSecondaryColor),
                InfoItem(
                    label: 'GST Number',
                    value: lead.gstNumber?.toString() ?? 'N/A',
                    icon: Icons.g_mobiledata,
                    iconColor: AppColors.blueSecondaryColor),
              ],
            ),
            const SizedBox(height: 16),
            if (lead.workRecords != null && lead.workRecords!.isNotEmpty)
              InfoSection(
                title: 'Work Records',
                icon: Icons.work_outline,
                padding: const EdgeInsets.only(top: 2),
                items: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth:
                                width, // Ensures table expands to full width
                          ),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Color(0xFFEFF3F6)),
                            // Use minimal column spacing & responsive layout
                            columnSpacing: 20,
                            horizontalMargin: 12,
                            // 👇 Makes table clean & mobile-friendly
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 70,

                            columns: const [
                              DataColumn(label: Text("Company")),
                              DataColumn(label: Text("Position")),
                              DataColumn(label: Text("Start Date")),
                              DataColumn(label: Text("End Date")),
                              DataColumn(label: Text("Description")),
                            ],

                            rows: lead.workRecords!.map((work) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 160),
                                      child: Text(work.company ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 140),
                                      child: Text(work.position ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(Text(
                                      work.startDate?.substring(0, 10) ??
                                          'N/A')),
                                  DataCell(Text(
                                      work.endDate?.substring(0, 10) ?? 'N/A')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
                                      child: Text(
                                        work.description ?? '',
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            const SizedBox(height: 16),
            if (lead.academicRecords != null &&
                lead.academicRecords!.isNotEmpty)
              InfoSection(
                title: 'Academic Record',
                icon: Icons.work_outline,
                padding: const EdgeInsets.only(top: 2),
                items: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth:
                                width, // Ensures table expands to full width
                          ),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Color(0xFFEFF3F6)),
                            // Use minimal column spacing & responsive layout
                            columnSpacing: 20,
                            horizontalMargin: 12,
                            // 👇 Makes table clean & mobile-friendly
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 70,

                            columns: const [
                              DataColumn(label: Text("Qualification")),
                              DataColumn(label: Text("Institution")),
                              DataColumn(label: Text("Year of Passing")),
                              DataColumn(label: Text("Percentage")),
                              DataColumn(label: Text("Board")),
                              DataColumn(label: Text("Description")),
                            ],

                            rows: lead.academicRecords!.map((academic) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 160),
                                      child:
                                          Text(academic.qualification ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 140),
                                      child:
                                          Text(academic.institution ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(Text(
                                      academic.yearOfPassing?.toString() ??
                                          'N/A')),
                                  DataCell(Text(
                                      academic.percentage?.toString() ??
                                          'N/A')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
                                      child: Text(
                                        academic.board ?? '',
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
                                      child: Text(
                                        academic.description ?? '',
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            const SizedBox(height: 16),
            // Travel Records Section
            if (lead.travelRecords != null && lead.travelRecords!.isNotEmpty)
              InfoSection(
                title: 'Travel Records',
                icon: Icons.flight_takeoff,
                padding: const EdgeInsets.only(top: 2),
                items: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: width,
                          ),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Color(0xFFEFF3F6)),
                            columnSpacing: 20,
                            horizontalMargin: 12,
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 70,
                            columns: const [
                              DataColumn(label: Text("Country")),
                              DataColumn(label: Text("Purpose")),
                              DataColumn(label: Text("Duration")),
                              DataColumn(label: Text("Purpose")),
                              DataColumn(label: Text("Description")),
                            ],
                            rows: lead.travelRecords!.map((travel) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 160),
                                      child: Text(travel.country ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 140),
                                      child: Text(travel.purpose ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(Text(travel.duration ?? 'N/A')),
                                  DataCell(Text(travel.purpose ?? 'N/A')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
                                      child: Text(
                                        travel.description ?? '',
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            const SizedBox(height: 16),
            // Exam Records Section
            if (lead.examRecords != null && lead.examRecords!.isNotEmpty)
              InfoSection(
                title: 'Exam Records',
                icon: Icons.assignment_turned_in,
                padding: const EdgeInsets.only(top: 2),
                items: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: width,
                          ),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Color(0xFFEFF3F6)),
                            columnSpacing: 20,
                            horizontalMargin: 12,
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 70,
                            columns: const [
                              DataColumn(label: Text("Exam Name")),
                              DataColumn(label: Text("Test Date")),
                              DataColumn(label: Text("Score")),
                              DataColumn(label: Text("Validity")),
                              DataColumn(label: Text("Description")),
                            ],
                            rows: lead.examRecords!.map((exam) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 160),
                                      child: Text(exam.examName ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(Text(exam.testDate ?? 'N/A')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 140),
                                      child:
                                          Text(exam.score?.toString() ?? 'N/A'),
                                    ),
                                  ),
                                  DataCell(Text(exam.validity ?? 'N/A')),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
                                      child: Text(
                                        exam.description ?? '',
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonGraidentColour,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.description,
                              color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomText(
                            text: 'Documents',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                            width: 170,
                            // height: 35,
                            child: CustomActionButton(
                              text: 'Add Document',
                              textSize: 14,
                              icon: Icons.add_rounded,
                              textColor: AppColors.violetPrimaryColor,
                              // gradient: AppColors.greenGradient,
                              // backgroundColor: AppColors.blueSecondaryColor,
                              // isFilled: true,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return UploadDocumentPopup(
                                      // initialProducts:
                                      //     lead.productInterested ?? <ProductItem>[],
                                      onSave: (documents) {
                                        Get.find<CustomerProfileController>()
                                            .uploadDocument(
                                                clientId: lead.id,
                                                body: documents,
                                                context: context);
                                      },
                                      items: Get.find<ConfigController>()
                                              .configData
                                              .value
                                              .leadDocuments
                                              ?.map((e) => e.name ?? "")
                                              .toList() ??
                                          [
                                            "Passport",
                                            "ID Proof",
                                            "PAN Card",
                                            "GST Certificate"
                                          ],
                                    );
                                  },
                                );
                              },
                              // gradient: AppColors.greenGradient,
                            )),
                      ],
                    ),
                  ),

                  // Items
                  Obx(() {
                    return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: Get.find<CustomerProfileController>()
                                  .leadDetails
                                  .value
                                  .documents
                                  ?.map(
                                      (doc) => _buildDocumentCard(doc, context))
                                  .toList() ??
                              [].asMap().entries.map((entry) {
                                final isLast = entry.key ==
                                    (lead.documents
                                                    ?.map((doc) =>
                                                        _buildDocumentCard(
                                                            doc, context))
                                                    .toList() ??
                                                [])
                                            .length -
                                        1;
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: isLast ? 0 : 12),
                                  child: entry.value,
                                );
                              }).toList(),
                        ));
                  })
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Widget _buildDocumentCard(DocumentRecordModel document, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF34A853).withOpacity(0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF34A853).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.check_circle,
            color: const Color(0xFF34A853),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: document.docType?.toString().toUpperCase() ?? 'N/A',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF202124),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: "uploaded on:  ${document.uploadedAt ?? 'N/A'}",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF5F6368),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    content: ViewDocWidget(
                      fileUrl: Constant().featureBaseUrl + document.filePath!,
                      fileName: document.docType ?? 'Unknown',
                    ),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                    text: 'view',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF34A853)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
