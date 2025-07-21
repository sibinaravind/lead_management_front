import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overseas_front_end/model/models.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/CustomPasswordTextField.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../controller/auth/login_controller.dart';
import '../../../../controller/officers_controller/officers_controller.dart';

class PasswordReset extends StatefulWidget {
  final bool isResetPassword;
  final String officerId;
  const PasswordReset(
      {super.key, required this.officerId, required this.isResetPassword});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _resetPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.72;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.35,
              constraints: BoxConstraints(
                minWidth: 320,
                maxWidth: 500,
                minHeight:widget.isResetPassword? 450:300,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
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
                          height: widget.isResetPassword ? 350 : 230,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: widget.isResetPassword
                                    ? 'Reset Password'
                                    : 'Change Password',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: widget.isResetPassword
                                    ? 'Reset officer password'
                                    : 'Change Your Password',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Expanded(
                          flex: 3,
                          child: Container(
                            height: widget.isResetPassword ? 350 : 180,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final availableWidth =
                                              constraints.maxWidth;
                                          int columnsCount = 1;

                                          if (availableWidth > 1000) {
                                            columnsCount = 3;
                                          } else if (availableWidth > 600) {
                                            columnsCount = 2;
                                          }

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16),
                                              ResponsiveGrid(
                                                  columns: columnsCount,
                                                  children: [
                                                    CustomPasswordTextFormField(
                                                      label: widget
                                                              .isResetPassword
                                                          ? 'Current Password'
                                                          : 'Password',
                                                      controller:
                                                          _passwordController,
                                                      isRequired: true,
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty) {
                                                          return "Required";
                                                        }
                                                        final regex = RegExp(
                                                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
                                                        if (!widget
                                                            .isResetPassword) {
                                                          if (!regex.hasMatch(
                                                              value)) {
                                                            return 'Password must be at least 8 characters\nwith uppercase, lowercase, number & special character';
                                                          }
                                                        }

                                                        return null;
                                                      },
                                                    ),

                                                    // CustomPasswordTextFormField(
                                                    //
                                                    //                                                         label:
                                                    //   'Confirm Password',
                                                    //                                                         controller:
                                                    //   _resetPasswordController,
                                                    //                                                         isRequired: widget
                                                    //   .isResetPassword,
                                                    //                                                         validator:
                                                    //   (String? value) {
                                                    // if (value!.isEmpty) {
                                                    //   return 'Required';
                                                    // }
                                                    // final regex = RegExp(
                                                    //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
                                                    //
                                                    // if (!regex.hasMatch(
                                                    //     value)) {
                                                    //   return 'Password must be at least 8 characters\nwith uppercase, lowercase, number & special character';
                                                    // }
                                                    // return null;
                                                    //                                                         },
                                                    //                                                       ),
                                                    if (widget.isResetPassword)
                                                      const SizedBox(height: 16),
                                                    if (widget.isResetPassword)
                                                      CustomPasswordTextFormField(
                                                        label: 'Confirm Password',
                                                        controller: _resetPasswordController,
                                                        isRequired: true,
                                                        validator: (String? value) {
                                                          if (value!.isEmpty) return "Required";
                                                          final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
                                                          if (!regex.hasMatch(value)) {
                                                            return 'Password must be at least 8 characters\nwith uppercase, lowercase, number & special character';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                  ]),
                                              if (widget.isResetPassword)
                                                const SizedBox(height: 32),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 16),
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
                                        text: widget.isResetPassword
                                            ? "Reset Password"
                                            : "Change Password",
                                        icon: Icons.save_rounded,
                                        isFilled: true,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF7F00FF),
                                            Color(0xFFE100FF)
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            widget.isResetPassword
                                                ? resetPassword()
                                                : editPassword();
                                          } else {
                                            CustomSnackBar.show(
                                                context, "Password required",
                                                backgroundColor: AppColors
                                                    .redSecondaryColor);
                                          }
                                        },
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
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void editPassword() async {
    final officer = {"password": _passwordController.text};

    final officerId = widget.officerId; // or officerIdController.text

    if (officerId.isNotEmpty) {
      bool success =
          await OfficersControllerProvider().updateOfficer(officerId, officer);

      if (success) {
        Navigator.pop(context);
        CustomSnackBar.show(context, "Password updated successfully");
      } else {
        CustomSnackBar.show(context, "Failed to update",
            backgroundColor: AppColors.redSecondaryColor);
      }
    }
  }

  void resetPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
         return AlertDialog(
            title: const Text("Reset Password"),
            content: const Text("Are you sure?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    final officerId = widget.officerId;
                    if (officerId.isNotEmpty) {
                      bool success = await LoginProvider().resetPassword(
                          officerId: officerId,
                          currentPassword: _passwordController.text,
                          newPassword: _resetPasswordController.text,
                          context: context);
                      Navigator.pop(context);
                      if (success) {
                        CustomSnackBar.show(context, "Password Rest successfully");
                      } else {
                        CustomSnackBar.show(context, "Failed to Update",
                            backgroundColor: AppColors.redSecondaryColor);
                      }
                    }
                  },
                  child: const Text("Reset")),
            ],
          );

        },
    );
  }
}
