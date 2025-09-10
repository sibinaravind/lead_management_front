import 'package:flutter/material.dart';
import '../../../widgets/custom_text.dart';

class InfoItemCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;
  final bool isWebView;

  const InfoItemCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.accentColor,
    this.isWebView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isWebView ? 20 : 16),
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(isWebView ? 20 : 16),
        border: Border.all(
          color: accentColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: isWebView ? 18 : 16,
                color: accentColor,
              ),
              SizedBox(width: isWebView ? 10 : 8),
              Expanded(
                child: CustomText(
                  text: label,
                  fontSize: isWebView ? 14 : 12,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: isWebView ? 8 : 6),
          CustomText(
            text: value,
            fontSize: isWebView ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
