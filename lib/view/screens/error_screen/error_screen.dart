import 'package:flutter/material.dart';

import '../../../res/style/colors/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline,
                  size: 64,
                  color: AppColors.redSecondaryColor.withOpacity(0.8)),
              const SizedBox(height: 24),
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.redSecondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhiteColour,
                ),
              ),
              const SizedBox(height: 12),
              // Text(
              //   'Route not found: ${state.uri}',
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: AppColors.textWhiteColour.withOpacity(0.7),
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 32),
              // ElevatedButton.icon(
              //   onPressed: () => context.go('/'),
              //   icon: const Icon(Icons.home, color: Colors.white),
              //   label: const Text(
              //     'Go Home',
              //     style: TextStyle(color: Colors.white, fontSize: 16),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: AppColors.blueSecondaryColor,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
