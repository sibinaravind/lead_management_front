import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import '../../../widgets/custom_text.dart';

class ProfilePhotoUploadWidget extends StatefulWidget {
  final String title;
  final Uint8List? initialImageBytes;
  final ValueChanged<Uint8List?>? onImageChanged;

  const ProfilePhotoUploadWidget({
    super.key,
    this.initialImageBytes,
    this.onImageChanged,
    required this.title,
  });

  @override
  State<ProfilePhotoUploadWidget> createState() =>
      _ProfilePhotoUploadWidgetState();
}

class _ProfilePhotoUploadWidgetState extends State<ProfilePhotoUploadWidget> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    imageBytes = widget.initialImageBytes;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => imageBytes = bytes);
      widget.onImageChanged?.call(bytes);
    }
  }

  void _removeImage() {
    setState(() => imageBytes = null);
    widget.onImageChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.photo_camera_rounded,
                  size: 18, color: AppColors.violetPrimaryColor),
              const SizedBox(width: 8),
              CustomText(
                text: widget.title,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: imageBytes != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: 50,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'No Photo',
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload_rounded, size: 16),
                  label: const CustomText(text: 'Upload', fontSize: 12),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    side: BorderSide(color: AppColors.violetPrimaryColor),
                    foregroundColor: AppColors.violetPrimaryColor,
                  ),
                ),
              ),
              if (imageBytes != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _removeImage,
                    icon: const Icon(Icons.delete_rounded, size: 16),
                    label: const CustomText(text: 'Remove', fontSize: 12),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      side: const BorderSide(color: Colors.red),
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
