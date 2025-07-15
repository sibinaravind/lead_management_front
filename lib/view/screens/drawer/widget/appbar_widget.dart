import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/auth/login_controller.dart';
import '../../../../model/officer/officers_lofin_model.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/widgets.dart';
import '../../officers/widgets/reset_password.dart';

class AppBarContainer extends StatefulWidget {
  final bool isdesktop;
  final Officer user;
  final void Function()? onDrawerButtonPressed;

  const AppBarContainer({
    super.key,
    required this.isdesktop,
    required this.user,
    this.onDrawerButtonPressed,
  });

  @override
  State<AppBarContainer> createState() => _AppBarContainerState();
}

class _AppBarContainerState extends State<AppBarContainer> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 20, right: 15, bottom: 5, top: 10),
      // padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.isdesktop)
            IconButton(
              onPressed: widget.onDrawerButtonPressed,
              // DashboardScreen(
              //   user: UserModel(),
              //   child: SizedBox.shrink(),
              // ).openEndDrawer();

              icon: const Icon(Icons.menu),
            ),
          Flexible(
            child: Container(
              height: 50,
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: TextField(
                // controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: "Search Profiles...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                  ),
                  suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.search, size: 20, color: Colors.grey),
                    onPressed: () {
                      print("Search query: ${_searchController.text}");
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CustomText(
              //       text: "${widget.user.name ?? ''} ",
              //       fontWeight: FontWeight.w800,
              //       color: AppColors.textColor,
              //       fontSize: 16,
              //     ),
              //     // CustomText(
              //     //   text: widget.user.branch.first.toString() ?? '',
              //     //   fontWeight: FontWeight.w800,
              //     //   color: AppColors.primaryColor,
              //     //   fontSize: 16,
              //     // ),
              //   ],
              // ),
              const SizedBox(
                width: 10,
              ),
              PopupMenuButton<String>(
                elevation: 2,
                shadowColor: Colors.grey,
                color: AppColors.primaryColor,
                onSelected: (String result) {
                  switch (result) {
                    case 'option1':
                      break;
                    case 'option2':
                      break;
                    case 'option3':
                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    value: 'option1',
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined,
                            color: AppColors.textWhiteColour),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Settings",
                          color: AppColors.textWhiteColour,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => EmployeeEditScreen(
                        isResetPassword: true,
                        officerId: widget.user.officerId ?? '',
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    value: 'option2',
                    child: const Row(
                      children: [
                        Icon(Icons.settings_outlined,
                            color: AppColors.textWhiteColour),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Reset Password",
                          color: AppColors.textWhiteColour,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      // Provider.of<LoginProvider>(context, listen: false).logout(context);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    value: 'option3',
                    child: const Row(
                      children: [
                        Icon(Icons.logout, color: AppColors.textWhiteColour),
                        SizedBox(width: 10),
                        CustomText(
                            text: "LogOut", color: AppColors.textWhiteColour),
                      ],
                    ),
                  ),
                ],
                child: Stack(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: AppColors.primaryColor,
                      size: 45,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.green[400],
                        radius: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
