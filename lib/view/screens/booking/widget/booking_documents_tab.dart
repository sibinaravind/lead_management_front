// widget/booking_documents_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';

import '../../../../controller/booking/booking_controller.dart';
import '../../../../controller/config/config_controller.dart';
import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../core/shared/constants.dart';
import '../../../../model/lead/document_record_model.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/upload_document_popup.dart';
import '../../../widgets/view_doc_widget.dart';
import '../../cutsomer_profile/widgets/info_item.dart';
import '../../cutsomer_profile/widgets/info_section.dart';
import '../../cutsomer_profile/widgets/product_intrested_popup.dart';

class BookingDocumentsTab extends StatelessWidget {
  final BookingModel booking;

  const BookingDocumentsTab({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // Mock document data - Replace with actual document list from your model

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document Status Overview
            InfoSection(
              title: 'Required Documents',
              icon: Icons.description_rounded,
              padding: const EdgeInsets.all(15),
              items: (booking.requiredDocuments ?? []).map((doc) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: InfoItem(
                    label: doc.docName ?? 'Document',
                    value: doc.mandatory == true ? 'Mandatory' : 'Optional',
                    icon: Icons.file_present_rounded,
                    iconColor: doc.mandatory == true
                        ? AppColors.redSecondaryColor
                        : AppColors.greenSecondaryColor,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            SectionTitle(
                title: "Booking Documents",
                icon: Icons.description_outlined,
                tail: SizedBox(
                  width: 180,
                  // height: 35,
                  child: CustomActionButton(
                    text: 'Add  Document',
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
                              Get.find<BookingController>().uploadDocument(
                                  bookingId: booking.id,
                                  body: documents,
                                  context: context);
                            },
                          );
                        },
                      );
                    },
                    // gradient: AppColors.greenGradient,
                  ),
                )),
            const SizedBox(height: 12),
            if (booking.documents == null ||
                (booking.documents?.isEmpty ?? false))
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CustomText(
                    text: 'No Booking documents uploaded.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            // Items
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: booking.documents
                          ?.map((doc) => buildDocumentCard(doc, context))
                          .toList() ??
                      [].asMap().entries.map((entry) {
                        final isLast = entry.key ==
                            (booking.documents
                                            ?.map((doc) => buildDocumentCard(
                                                  doc,
                                                  context,
                                                ))
                                            .toList() ??
                                        [])
                                    .length -
                                1;
                        return Padding(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                          child: entry.value,
                        );
                      }).toList(),
                )),

            const SizedBox(height: 24),

            SectionTitle(
              title: "Customer Documents",
              icon: Icons.description_outlined,
              tail: SizedBox(
                width: 180,
                // height: 35,
                child: CustomActionButton(
                  text: 'Add  Document',
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
                                    clientId: booking.customerId,
                                    body: documents,
                                    context: context);
                          },
                        );
                      },
                    );
                  },
                  // gradient: AppColors.greenGradient,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Items
            if (booking.customerDocuments == null ||
                booking.customerDocuments!.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CustomText(
                    text: 'No customer documents uploaded.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: booking.customerDocuments
                            ?.map((doc) => buildDocumentCard(doc, context))
                            .toList() ??
                        [].asMap().entries.map((entry) {
                          final isLast = entry.key ==
                              (booking.customerDocuments
                                              ?.map((doc) => buildDocumentCard(
                                                    doc,
                                                    context,
                                                  ))
                                              .toList() ??
                                          [])
                                      .length -
                                  1;
                          return Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                            child: entry.value,
                          );
                        }).toList(),
                  )),

            const SizedBox(height: 24),

            // const SectionTitle(
            //   title: "Required Documents",
            //   icon: Icons.description_outlined,
            // ),
            // const SizedBox(height: 12),

            // // ...documents
            // //     .map((doc) => _buildDocumentCard(context, doc))
            // //     .toList(),

            // const SizedBox(height: 24),

            // // Upload Section
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.blue.shade50,
            //     borderRadius: BorderRadius.circular(14),
            //     border: Border.all(color: Colors.blue.shade200, width: 1),
            //   ),
            //   child: Column(
            //     children: [
            //       Icon(Icons.cloud_upload,
            //           size: 48, color: Colors.blue.shade700),
            //       const SizedBox(height: 12),
            //       Text(
            //         'Upload New Document',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.blue.shade900,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         'Click below to upload additional documents',
            //         style: TextStyle(
            //           fontSize: 13,
            //           color: Colors.blue.shade700,
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //       ElevatedButton.icon(
            //         onPressed: () {
            //           // TODO: Implement file upload
            //         },
            //         icon: const Icon(Icons.upload_file),
            //         label: const Text('Choose File'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: AppColors.primaryColor,
            //           foregroundColor: Colors.white,
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 24, vertical: 12),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildDocumentCard(DocumentRecordModel document, BuildContext context) {
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
}
