import 'package:flutter/material.dart';

import '../../../../res/style/colors/colors.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Access Permission Manager',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage role-based access control for all users',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGrayColour,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.buttonGraidentColour,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.security,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
