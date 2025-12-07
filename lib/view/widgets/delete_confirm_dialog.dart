import 'package:flutter/material.dart';
import '../../utils/style/colors/colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteMainColor.withOpacity(0.95),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.redSecondaryColor),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: AppColors.blackMainColor)),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(color: AppColors.textColor, fontSize: 16),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redSecondaryColor,
            foregroundColor: AppColors.whiteMainColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
