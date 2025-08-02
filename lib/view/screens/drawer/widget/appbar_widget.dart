import 'package:flutter/material.dart';
import '../../../../model/officer/officer_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/widgets.dart';
import '../../Project/widget/client_detail_tab.dart';
import '../../officers/widgets/password_reset_dialog.dart';

class AppBarContainer extends StatefulWidget {
  final bool isdesktop;
  final OfficerModel user;
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
  void initState() {
    // Provider.of<ProjectProvider>(context, listen: false).fetchClients(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildClientSearchDialog(context),
                  );
                },
                // controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: "Search Profiles...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                  ),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search,
                          size: 20, color: Colors.grey),
                      onPressed: null),
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
                      builder: (context) => PasswordResetDialog(
                        isAdmin: false,
                        officerId: widget.user.id ?? '',
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

  Widget _buildClientSearchDialog(BuildContext context) {
    // final clientProvider = Provider.of<ProjectProvider>(context, listen: false);
    final TextEditingController searchController = TextEditingController();
    final clients = []; // clientProvider.clients;
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: AppColors.whiteMainColor,
          title: const Text('Search Clients'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Enter client name...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    // clients = clientProvider.clients
                    //     .where((client) => client.name!
                    //         .toLowerCase()
                    //         .contains(query.toLowerCase()))
                    //     .toList();
                  });
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                width: 300,
                child: clients.isEmpty
                    ? const Center(child: Text('No clients found'))
                    : ListView.builder(
                        itemCount: clients.length,
                        itemBuilder: (context, index) {
                          final client = clients[index];
                          return ListTile(
                            title: Text(client.name ?? ''),
                            subtitle: Text(client.phone ?? ''),
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return ClientDetailTab(
                              //         client:
                              //             client); // Pass necessary arguments
                              //   },
                              // );
                              // ClientDetailTab(
                              //   client:client
                              // );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
