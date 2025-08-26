import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

class PasswordResetDialog extends StatefulWidget {
  final bool isAdmin;
  final String officerId;
  const PasswordResetDialog({
    super.key,
    required this.officerId,
    required this.isAdmin,
  });

  @override
  State<PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUserFlow = !widget.isAdmin;
    final dialogHeight = isUserFlow ? 460.0 : 380.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 500,
        height: dialogHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withOpacity(0.9),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.lock_reset,
                        size: 22, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: widget.isAdmin
                              ? 'Reset Password'
                              : 'Change Password',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: widget.isAdmin
                              ? 'Reset user password'
                              : 'Change your password',
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.white, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Form Content
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isUserFlow)
                          CustomTextFormField(
                            showPasswordToggle: true,
                            label: "Current Password",
                            controller: _currentPasswordController,
                            isRequired: true,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Current password is required";
                              }
                              return null;
                            },
                          ),

                        if (isUserFlow) const SizedBox(height: 16),

                        CustomTextFormField(
                          showPasswordToggle: true,
                          label: "New Password",
                          controller: _newPasswordController,
                          isRequired: true,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$',
                            ).hasMatch(value)) {
                              return "Password must be at least 8 characters long, \ninclude upper & lowercase letters, a number, and a special character.";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomTextFormField(
                          showPasswordToggle: true,
                          label: "Confirm New Password",
                          controller: _confirmPasswordController,
                          isRequired: true,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your new password";
                            }
                            if (value != _newPasswordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Buttons
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomActionButton(
            text: 'Cancel',
            icon: Icons.close_rounded,
            textColor: Colors.grey,
            onPressed: () => Navigator.pop(context),
            borderColor: Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: CustomActionButton(
            text: widget.isAdmin ? "Reset Password" : "Change Password",
            icon: Icons.save_rounded,
            isFilled: true,
            gradient: const LinearGradient(
              colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            ),
            onPressed: _handlePasswordAction,
          ),
        ),
      ],
    );
  }

  void _handlePasswordAction() async {
    if (!_formKey.currentState!.validate()) return;

    if (widget.isAdmin) {
      await _resetPasswordAsAdmin();
    } else {
      await _changePasswordAsUser();
    }
  }

  Future<void> _resetPasswordAsAdmin() async {
    try {
      showLoaderDialog(context);
      var result = await Get.find<OfficersController>().resetOfficerPassword(
        widget.officerId,
        _newPasswordController.text,
      );
      Navigator.pop(context);
      if (!result) {
        throw Exception();
      } else {
        Navigator.pop(context);
        CustomSnackBar.show(context, "Password reset successfully");
      }
    } catch (e) {
      CustomToast.showToast(
        context: context,
        message: "Failed to reset password. Please try again.",
        backgroundColor: AppColors.redSecondaryColor,
      );
    }
  }

  Future<void> _changePasswordAsUser() async {
    try {
      // Call user change password API
      // await UserApi.changePassword(
      //   officerId: widget.officerId,
      //   currentPassword: _currentPasswordController.text,
      //   newPassword: _newPasswordController.text,
      // );

      Navigator.pop(context);
      CustomSnackBar.show(context, "Password changed successfully");
    } catch (e) {
      CustomSnackBar.show(
        context,
        "Failed to change password. Check current password.",
        backgroundColor: AppColors.redSecondaryColor,
      );
    }
  }
}
