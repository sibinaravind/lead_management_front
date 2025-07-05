import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/model/officer/user_model.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../config/flavour_config.dart';
import '../../../../res/style/colors/colors.dart';

class CustomDrawer extends StatefulWidget {
  final bool? ismobile;
  final UserModel user;

  const CustomDrawer({
    super.key,
    this.ismobile = false,
    required this.user,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with TickerProviderStateMixin {
  // final drawerController = Get.find<AppUserController>();
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  final List<DrawerSection> drawerSections = [
    DrawerSection(
      title: 'Leads',
      icon: Icons.people_rounded,
      color: AppColors.violetPrimaryColor,
      items: [
        DrawerItem(
            label: 'Lead', index: 1, icon: Icons.follow_the_signs_rounded),
        DrawerItem(label: 'Repeat Lead', index: 2, icon: Icons.repeat_rounded),
        // DrawerItem(label: 'Deadline', index: 35, icon: Icons.call),
        DrawerItem(
            label: 'CRE Followup',
            index: 3,
            icon: Icons.mark_email_read_rounded),
        // DrawerItem(
        //     label: 'Repeated Lead', index: 3, icon: Icons.repeat_rounded),
        DrawerItem(
            label: 'Dead Lead', index: 4, icon: Icons.remove_circle_rounded),
        // DrawerItem(
        // label: 'CRE Follow Up', index: 32, icon: Icons.repeat_rounded),
      ],
    ),
    DrawerSection(
      title: 'Registrations',
      icon: Icons.app_registration_rounded,
      color: AppColors.greenSecondaryColor, // Emerald 500
      items: [
        DrawerItem(
            label: 'Registration Pending',
            index: 5,
            icon: Icons.pending_actions_rounded),
        DrawerItem(
            label: 'Registration Completed',
            index: 6,
            icon: Icons.task_alt_rounded),
      ],
    ),
    DrawerSection(
      title: 'Project',
      icon: Icons.work_rounded,
      color: AppColors.viloletSecondaryColor, // Violet 500
      items: [
        DrawerItem(label: 'Projects', index: 7, icon: Icons.folder_outlined),
        DrawerItem(
            label: 'Interview',
            index: 8,
            icon: Icons.record_voice_over_rounded),
        DrawerItem(
            label: 'Closed Projects',
            index: 34,
            icon: Icons.assignment_late_rounded),
        DrawerItem(
            label: 'Client', index: 31, icon: Icons.account_circle_outlined),
      ],
    ),
    DrawerSection(
      title: 'Application',
      icon: Icons.description_rounded,
      color: AppColors.orangeSecondaryColor, // Amber 500
      items: [
        DrawerItem(
            label: 'Application Verification',
            index: 9,
            icon: Icons.fact_check_rounded),
        DrawerItem(
            label: 'Application Pending',
            index: 32,
            icon: Icons.hourglass_empty_rounded),
        DrawerItem(
            label: 'Offer Letter Apply',
            index: 11,
            icon: Icons.mail_outline_rounded),
        DrawerItem(
            label: 'Offer Letter Waiting',
            index: 12,
            icon: Icons.timer_rounded),
        DrawerItem(
            label: 'Offer Letter', index: 13, icon: Icons.description_rounded),
        DrawerItem(
            label: 'Application Schedule',
            index: 14,
            icon: Icons.calendar_month_rounded),
      ],
    ),
    DrawerSection(
      title: 'Visa',
      icon: Icons.card_membership_rounded,
      color: AppColors.redSecondaryColor,
      items: [
        // DrawerItem(
        //     label: 'Visa Verification',
        //     index: 15,
        //     icon: Icons.gpp_good_rounded),
        // DrawerItem(
        //     label: 'Visa Pending',
        //     index: 16,
        //     icon: Icons.pending_actions_rounded),
        // DrawerItem(
        //     label: 'Visa Waiting', index: 17, icon: Icons.pending_rounded),
        DrawerItem(label: 'Visa', index: 18, icon: Icons.contact_page_rounded),
      ],
    ),
    DrawerSection(
      title: 'Ticketing',
      icon: Icons.airplane_ticket_rounded,
      color: AppColors.skyBlueSecondaryColor,
      items: [
        DrawerItem(
            label: 'Ticketing', index: 19, icon: Icons.flight_takeoff_rounded),
      ],
    ),
    DrawerSection(
      title: 'Deployment',
      icon: Icons.message_rounded,
      color: AppColors.greenSecondaryColor,
      items: [
        DrawerItem(label: 'Deployed', index: 20, icon: Icons.send_rounded),
        // DrawerItem(
        //     label: 'Email History', index: 21, icon: Icons.email_rounded),
        // DrawerItem(
        //     label: 'WhatsApp History',
        //     index: 22,
        //     icon: Icons.chat_bubble_rounded),
      ],
    ),

    // DrawerSection(
    //   title: 'Messaging',
    //   icon: Icons.message_rounded,
    //   color: AppColors.greenSecondaryColor,
    //   items: [
    //     DrawerItem(label: 'Send Message', index: 20, icon: Icons.send_rounded),
    //     DrawerItem(
    //         label: 'Email History', index: 21, icon: Icons.email_rounded),
    //     DrawerItem(
    //         label: 'WhatsApp History',
    //         index: 22,
    //         icon: Icons.chat_bubble_rounded),
    //   ],
    // ),
    DrawerSection(
      title: 'Employee',
      icon: Icons.badge_rounded,
      color: AppColors.pinkSecondaryColor,
      items: [
        DrawerItem(
            label: 'Employee', index: 23, icon: Icons.person_outline_rounded),
        // DrawerItem(
        //     label: 'Employee Role',
        //     index: 24,
        //     icon: Icons.assignment_ind_rounded),
        // DrawerItem(
        //     label: 'WhatsApp History',
        //     index: 25,
        //     icon: Icons.chat_bubble_rounded),
      ],
    ),
    DrawerSection(
      title: 'Config',
      icon: Icons.message_rounded,
      color: AppColors.greenSecondaryColor,
      items: [
        DrawerItem(label: 'Config', index: 36, icon: Icons.send_rounded),
      ],
    ),
    // DrawerSection(
    //   title: 'Lead Campaign',
    //   icon: Icons.campaign_rounded,
    //   color: AppColors.skyBlueSecondaryColor,
    //   items: [
    //     DrawerItem(
    //         label: 'Lead Round Robin', index: 26, icon: Icons.sync_alt_rounded),
    //     DrawerItem(
    //         label: 'Campaign', index: 27, icon: Icons.trending_up_rounded),
    //     DrawerItem(
    //         label: 'Lead Ad Set', index: 28, icon: Icons.ads_click_rounded),
    //     DrawerItem(label: 'Ad', index: 29, icon: Icons.ad_units_rounded),
    //   ],
    // ),
    // DrawerSection(
    //   title: 'Message Templates',
    //   icon: Icons.format_quote_rounded,
    //   color: AppColors.viloletSecondaryColor,
    //   items: [
    //     DrawerItem(
    //         label: 'Email Template', index: 30, icon: Icons.email_outlined),
    //     DrawerItem(
    //         label: 'WhatsApp Templates', index: 31, icon: Icons.chat_outlined),
    //   ],
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: double.maxFinite,
            width: 280,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: const Offset(4, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 24, 0, 0),
                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //       Color(0xFF334155), // Slate 700
                  //       Color(0xFF1E293B), // Slate 800
                  //     ],
                  //   ),
                  // ),
                  child: Column(
                    children: [
                      // Logo Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGraidentColour,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.violetPrimaryColor.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          FlavourConfig.appLogo(),
                          height: 36,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // User Info
                      const CustomText(
                        text: 'Welcome Back',
                        color: AppColors.textGrayColour,
                        fontSize: 15,
                      ),
                      const SizedBox(height: 6),
                      CustomText(
                        text: widget.user.familyName ?? 'Sibin',
                        fontSize: 25,
                        color: AppColors.textWhiteColour, // Slate 100
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Navigation Section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        const SizedBox(height: 25),
                        // Dashboard Item
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent.withOpacity(0.3),
                              border: Border.all(
                                color: const Color(0xFF475569), // Slate 600
                                width: 1,
                              ),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.black.withOpacity(0.2),
                              //       blurRadius: 8,
                              //       offset: const Offset(0, 2),
                              //     ),
                              //   ],
                            ),
                            child: _buildAnimatedDrawerTile(
                              context: context,
                              label: "Dashboard",
                              index: 0,
                              icon: Icons.dashboard_rounded,
                              color: AppColors.blueSecondaryColor, // Blue 500
                              delay: 0,
                            )),
                        const SizedBox(height: 16),
                        // Section Items
                        ...drawerSections.asMap().entries.map((entry) {
                          int sectionIndex = entry.key;
                          DrawerSection section = entry.value;
                          return _buildAnimatedExpansionTile(
                            section: section,
                            delay: sectionIndex * 50.0,
                          );
                        }),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedExpansionTile({
    required DrawerSection section,
    required double delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay.toInt()),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF475569), // Slate 600
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  expansionTileTheme: ExpansionTileThemeData(
                    backgroundColor: Colors.transparent.withOpacity(0.1),
                    collapsedBackgroundColor:
                        Colors.transparent.withOpacity(0.1),
                    iconColor: AppColors.iconWhiteColour, // Slate 200
                    collapsedIconColor:
                        AppColors.iconWhiteColour.withAlpha(90), // Slate 400
                    textColor:
                        AppColors.iconWhiteColour.withAlpha(90), // Slate 50
                    collapsedTextColor:
                        AppColors.iconWhiteColour.withAlpha(90), // Slate 200
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    childrenPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 12,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          section.color.withOpacity(0.2),
                          section.color.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: section.color.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      section.icon,
                      size: 20,
                      color: section.color,
                    ),
                  ),
                  title: CustomText(
                      text: section.title,
                      fontSize: 15,
                      color: AppColors.textWhiteColour // Slate 100
                      ),
                  children: section.items.asMap().entries.map((itemEntry) {
                    int itemIndex = itemEntry.key;
                    DrawerItem item = itemEntry.value;
                    return _buildAnimatedDrawerTile(
                      context: context,
                      label: item.label,
                      index: item.index,
                      icon: item.icon,
                      color: section.color,
                      delay: itemIndex * 25.0,
                      isSubItem: true,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDrawerTile({
    required BuildContext context,
    required String label,
    required int index,
    IconData? icon,
    Color? color,
    required double delay,
    bool isSubItem = false,
  }) {
    // final isSelected = drawerController.selectedIndex.value == index;

    return Consumer<AppUserProvider>(
      builder: (context, value2, child) => TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300 + delay.toInt()),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: Opacity(
              opacity: value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: value2.selectedIndex == index
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            (color ?? AppColors.blueSecondaryColor)
                                .withOpacity(0.15),
                            (color ?? AppColors.blueSecondaryColor)
                                .withOpacity(0.15)
                                .withOpacity(0.05),
                          ],
                        )
                      : null,
                  border: value2.selectedIndex == index
                      ? Border.all(
                          color: (color ?? AppColors.blueSecondaryColor)
                              .withOpacity(0.4),
                          width: 1.5,
                        )
                      : null,
                  boxShadow: value2.selectedIndex == index
                      ? [
                          BoxShadow(
                            color: (color ?? AppColors.blueSecondaryColor)
                                .withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    splashColor: (color ?? AppColors.blueSecondaryColor)
                        .withOpacity(0.1),
                    highlightColor: (color ?? AppColors.blueSecondaryColor)
                        .withOpacity(0.05),
                    onTap: () {
                      value2.updateIndex(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          if (icon != null) ...[
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: value2.selectedIndex == index
                                    ? (color ?? AppColors.blueSecondaryColor)
                                        .withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                icon,
                                size: isSubItem ? 16 : 18,
                                color: value2.selectedIndex == index
                                    ? (color ?? AppColors.blueSecondaryColor)
                                    : const Color.fromARGB(
                                        255, 196, 207, 225), // Slate 400
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: CustomText(
                              text: label,

                              fontSize: isSubItem ? 13 : 14,
                              fontWeight: value2.selectedIndex == index
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: value2.selectedIndex == index
                                  ? AppColors.textWhiteColour
                                      .withOpacity(0.9) // Slate 50
                                  : AppColors.textWhiteColour
                                      .withOpacity(0.6), // Slate 300
                            ),
                          ),
                          if (value2.selectedIndex == index)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: color ?? AppColors.blueSecondaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        (color ?? AppColors.blueSecondaryColor)
                                            .withOpacity(0.6),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrawerSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<DrawerItem> items;

  DrawerSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class DrawerItem {
  final String label;
  final int index;
  final IconData icon;

  DrawerItem({
    required this.label,
    required this.index,
    required this.icon,
  });
}
