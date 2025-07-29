// Enhanced Responsive CampaignScreen using GetX
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

  // Responsive grid count based on screen width
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  // Responsive dialog width
  double _getDialogWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 600;
    if (width > 600) return width * 0.8;
    return width * 0.95;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1000;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCampaignDialog(context),
        icon: const Icon(
          Icons.add,
          color: AppColors.textWhiteColour,
        ),
        label: const CustomText(
          text: 'Add Campaign',
          color: AppColors.textWhiteColour,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerGrid(context);
        }

        final campaigns = controller.campaignList;

        if (campaigns.isEmpty) {
          return _buildEmptyState(context);
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.getCampaignList();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: isDesktop ? 24.0 : 16.0,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF123456),
                          Color(0xFF2196F3)
                        ], // Replace with your gradient colors
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.campaign,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                color: AppColors.backgroundColor,
                                text: "Campaign Management Dashboard",
                                fontSize: 20,
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(screenWidth),
                      crossAxisSpacing: isDesktop ? 20 : 12,
                      mainAxisSpacing: isDesktop ? 20 : 12,
                      childAspectRatio: isDesktop ? 0.85 : 0.8,
                    ),
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = campaigns[index];
                      return _buildCampaignCard(context, campaign, isDesktop);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1000;

    return Padding(
      padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(screenWidth),
          crossAxisSpacing: isDesktop ? 20 : 12,
          mainAxisSpacing: isDesktop ? 20 : 12,
          childAspectRatio: isDesktop ? 0.85 : 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => CustomShimmerWidget(),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.campaign_outlined,
              size: 64,
              color: AppColors.primaryColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          CustomText(
            text: 'No Campaigns Yet',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 12),
          CustomText(
            text: 'Create your first campaign to get started',
            fontSize: 16,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _showAddCampaignDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Create Campaign'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(
      BuildContext context, dynamic campaign, bool isDesktop) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Add navigation to campaign details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      "${Constant().featureBaseUrl}${campaign.image}",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 4),
                          CustomText(
                            text: 'Active',
                            fontSize: 10,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 16.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: campaign.title ?? 'Untitled Campaign',
                            fontSize: isDesktop ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  campaign.startDate ?? 'No date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomText(
                            text: 'Campaign',
                            fontSize: 10,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade400,
                            size: 20,
                          ),
                          onPressed: () {
                            showDeleteCampaignDialog(
                              context,
                              campaign.title ?? '',
                              campaign?.sId ?? '',
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCampaignDialog(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: _getDialogWidth(context),
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : 500,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 32 : 24),
              child: GetBuilder<CampaignController>(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.primaryColor.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                fontSize: isDesktop ? 24 : 20,
                                fontWeight: FontWeight.bold,
                                text: 'Create New Campaign',
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text:
                                    'Fill in the details to create your campaign',
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Form Fields
                    PopupTextField(
                      requiredField: true,
                      label: 'Campaign Title',
                      controller: controller.titleController,
                      icon: Icons.campaign,
                      hint: 'e.g., Summer Sale Campaign',
                    ),
                    const SizedBox(height: 20),

                    CustomDateField(
                      initialDate: DateTime.now(),
                      label: 'Start Date',
                      controller: controller.startDateController,
                    ),
                    const SizedBox(height: 24),

                    // Image Upload Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: controller.file64 != null
                              ? AppColors.primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: controller.file64 != null
                            ? AppColors.primaryColor.withOpacity(0.05)
                            : Colors.grey[50],
                      ),
                      child: Column(
                        children: [
                          if (controller.file64 != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                base64Decode(
                                    controller.file64!.split(",").last),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    String? file64 = await FileUploadService()
                                        .pickAndCompressFileAsBase64();
                                    controller.file64 = file64;
                                    controller.previewFile();
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Change Image'),
                                ),
                                const SizedBox(width: 16),
                                TextButton.icon(
                                  onPressed: () {
                                    controller.file64 = null;
                                    controller.previewFile();
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                  label: const Text('Remove'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            CustomText(
                              text: 'Upload Campaign Image',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text:
                                  'Select an image to represent your campaign',
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                String? file64 = await FileUploadService()
                                    .pickAndCompressFileAsBase64();
                                controller.file64 = file64;
                                controller.previewFile();
                              },
                              icon: const Icon(Icons.upload),
                              label: const Text("Choose Image"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.titleController.clear();
                            controller.startDateController.clear();
                            controller.file64 = null;
                            Get.back();
                          },
                          child: CustomText(
                            text: 'Cancel',
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.titleController.text.isEmpty ||
                                  controller.startDateController.text.isEmpty ||
                                  (controller.file64?.isEmpty ?? true)) {
                                CustomToast.showToast(
                                  context: context,
                                  message:
                                      'Please fill all fields and upload an image',
                                );
                              } else {
                                final success =
                                    await controller.addCampaign(context);
                                if (success) {
                                  controller.getCampaignList();
                                  controller.titleController.clear();
                                  controller.startDateController.clear();
                                  controller.file64 = null;
                                  Get.back();
                                  CustomToast.showToast(
                                    context: context,
                                    message: 'Campaign created successfully!',
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orangeSecondaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Icon(Icons.add,
                                      size: 18, color: Colors.white),
                                ),
                                Flexible(
                                  child: CustomText(
                                    text: 'Create Campaign',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
