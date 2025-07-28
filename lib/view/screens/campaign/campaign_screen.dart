// Converted CampaignScreen using GetX
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/campaign/campaign_controller.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/functions/pick_image.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import '../../../../res/style/colors/colors.dart';
import '../../widgets/custom_toast.dart';
import 'widget/delete_dialogue.dart';

class CampaignScreen extends StatelessWidget {
  CampaignScreen({super.key});

  final CampaignController controller = Get.put(CampaignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: GetBuilder<CampaignController>(
                    builder: (_) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.add,
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    text: 'Add Campaign',
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    text: 'Enter your campaign details',
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        PopupTextField(
                          requiredField: false,
                          label: 'Title',
                          controller: controller.titleController,
                          icon: Icons.grade,
                          hint: 'e.g., Advertisement Campaign',
                        ),
                        const SizedBox(height: 16),
                        CustomDateField(
                          initialDate:
                              DateTime.now().subtract(Duration(days: 5)),
                          label: 'Start Date',
                          controller: controller.startDateController,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: controller.file64 != null
                              ? Image.memory(
                                  base64Decode(
                                      controller.file64!.split(",").last),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () async {
                            String? file64 = await FileUploadService()
                                .pickAndCompressFileAsBase64();
                            controller.file64 = file64;
                            controller.previewFile();
                          },
                          icon: const Icon(Icons.upload),
                          label: const CustomText(text: "Upload Image"),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: CustomText(
                                text: 'Cancel',
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () async {
                                if (controller.titleController.text.isEmpty ||
                                    controller
                                        .startDateController.text.isEmpty ||
                                    (controller.file64?.isEmpty ?? true)) {
                                  CustomToast.showToast(
                                      context: context,
                                      message:
                                          'All fields and image are required');
                                } else {
                                  final success =
                                      await controller.addCampaign(context);
                                  if (success) {
                                    controller.getCampaignList();
                                    Get.back();
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.add, size: 18),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: 'Add Campaign',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final campaigns = controller.campaignList;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          "${Constant().featureBaseUrl}${campaign.image}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: campaign.title ?? '',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 12),
                                const SizedBox(width: 6),
                                Text(
                                  campaign.startDate ?? '',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDeleteCampaignDialog(
                                      context,
                                      campaign.title ?? '',
                                      campaign?.sId ?? '');
                                  ;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
