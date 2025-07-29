import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/campaign/campaign_controller.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_toast.dart';

void showDeleteCampaignDialog(BuildContext context, String name, String id) {
  final CampaignController controller = Get.find<CampaignController>();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: CustomText(text: 'Delete $name'),
      content: CustomText(
        text:
            'Are you sure you want to delete this item? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(), // closes dialog
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await controller.deleteCampaign(context, id);
            Get.back(); // close dialog
            CustomToast.showToast(
              context: context,
              message: '$name deleted successfully',
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: CustomText(text: 'Delete', color: Colors.white),
        ),
      ],
    ),
  );
}
