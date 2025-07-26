import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../config/flavour_config.dart';
import '../../../controller/navigation_controller/navigation_controller.dart';
import '../../../model/officer/officer_model.dart';
import '../../../res/style/colors/colors.dart';
import '../../widgets/widgets.dart';

class AnimatedDrawer extends StatefulWidget {
  final OfficerModel user;
  final bool ismobile;
  const AnimatedDrawer({
    super.key,
    required this.user,
    this.ismobile = false,
  });

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return AnimatedBuilder(
      animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: widget.ismobile
                  ? MediaQuery.of(context).size.width * 0.75
                  : 300,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E293B),
                    Color(0xFF0F172A),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
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
                                color: AppColors.violetPrimaryColor
                                    .withOpacity(0.3),
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
                          text: widget.user.name ?? 'Sibin',
                          fontSize: 25,
                          color: AppColors.textWhiteColour, // Slate 100
                        ),
                        CustomText(
                          text: widget.user.officerId ?? 'Sibin',
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: AppColors.offWhiteColour, // Slate 100
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Scrollbar(
                        controller: _controller,
                        child: ListView(
                          controller: _controller,
                          children: [
                            // Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(16),
                            //       color: Colors.transparent.withOpacity(0.3),
                            //       border: Border.all(
                            //         color: const Color(0xFF475569), // Slate 600
                            //         width: 1,
                            //       ),
                            //       //   boxShadow: [
                            //       //     BoxShadow(
                            //       //       color: Colors.black.withOpacity(0.2),
                            //       //       blurRadius: 8,
                            //       //       offset: const Offset(0, 2),
                            //       //     ),
                            //       //   ],
                            //     ),
                            //     child: _buildAnimatedDrawerTile(
                            //       context: context,
                            //       label: "Dashboard",
                            //       index: 0,
                            //       navigationController: navigationController,
                            //       icon: Icons.dashboard_rounded,
                            //       color:
                            //           AppColors.blueSecondaryColor, // Blue 500
                            //       delay: 0,
                            //     )),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['dashboard']!,
                              mainTab: 'dashboard',
                              delay: 0,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['leads']!,
                              mainTab: 'leads',
                              delay: 100,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['registrations']!,
                              mainTab: 'registrations',
                              delay: 200,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['application']!,
                              mainTab: 'application',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['visa']!,
                              mainTab: 'visa',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['ticketing']!,
                              mainTab: 'ticketing',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['deployment']!,
                              mainTab: 'deployment',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['employee']!,
                              mainTab: 'employee',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['config']!,
                              mainTab: 'config',
                              delay: 300,
                            ),
                            _buildAnimatedExpansionTile(
                              section: navigationController
                                  .navigationSections['campaign']!,
                              mainTab: 'campaign',
                              delay: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(
                  //         color: AppColors.iconWhiteColour.withOpacity(0.1),
                  //         width: 1,
                  //       ),
                  //     ),
                  //   ),
                  //   child: InkWell(
                  //     onTap: () => context.go('/'),
                  //     borderRadius: BorderRadius.circular(8),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.logout_rounded,
                  //             color: AppColors.redSecondaryColor,
                  //             size: 20,
                  //           ),
                  //           const SizedBox(width: 12),
                  //           CustomText(
                  //             text: 'Logout',
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //             color: AppColors.redSecondaryColor,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedExpansionTile({
    required NavigationSection section,
    required String mainTab,
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
                  color: const Color(0xFF475569),
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
                    iconColor: AppColors.iconWhiteColour,
                    collapsedIconColor: AppColors.iconWhiteColour.withAlpha(90),
                    textColor: AppColors.iconWhiteColour.withAlpha(90),
                    collapsedTextColor: AppColors.iconWhiteColour.withAlpha(90),
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
                    color: AppColors.textWhiteColour,
                  ),
                  children: section.items.map((item) {
                    return _buildAnimatedDrawerTile(
                      item: item,
                      mainTab: mainTab,
                      color: section.color,
                      delay: section.items.indexOf(item) * 25.0,
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
    required NavigationItem item,
    required String mainTab,
    required Color color,
    required double delay,
  }) {
    final navigationController = Get.find<NavigationController>();

    return Obx(() {
      final isSelected = navigationController.currentMainTab.value == mainTab &&
          navigationController.currentSubTab.value == item.route;

      return TweenAnimationBuilder<double>(
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
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            color.withOpacity(0.15),
                            color.withOpacity(0.05),
                          ],
                        )
                      : null,
                  border: isSelected
                      ? Border.all(
                          color: color.withOpacity(0.4),
                          width: 1.5,
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.2),
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
                    splashColor: color.withOpacity(0.1),
                    highlightColor: color.withOpacity(0.05),
                    onTap: () {
                      context.go('/dashboard/$mainTab/${item.route}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? color.withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              item.icon,
                              size: 16,
                              color: isSelected
                                  ? color
                                  : const Color.fromARGB(255, 196, 207, 225),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomText(
                              text: item.label,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.textWhiteColour.withOpacity(0.9)
                                  : AppColors.textWhiteColour.withOpacity(0.6),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.6),
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
      );
    });
  }
}



//   Widget _buildAnimatedDrawerTile({
//     required BuildContext context,
//     required String label,
//     required int index,
//     IconData? icon,
//     Color? color,
//     required double delay,
//     bool isSubItem = false,
//     required dynamic navigationController,
//   }) {
//     final isSelected =
//         navigationController.currentMainTab.value == 'dashboard' &&
//             navigationController.currentSubTab.value == 'overview' &&
//             label == 'Dashboard';
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 300 + delay.toInt()),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(20 * (1 - value), 0),
//           child: Opacity(
//             opacity: value,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: isSelected
//                     ? LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         colors: [
//                           (color ?? AppColors.blueSecondaryColor)
//                               .withOpacity(0.15),
//                           (color ?? AppColors.blueSecondaryColor)
//                               .withOpacity(0.15)
//                               .withOpacity(0.05),
//                         ],
//                       )
//                     : null,
//                 border: isSelected
//                     ? Border.all(
//                         color: (color ?? AppColors.blueSecondaryColor)
//                             .withOpacity(0.4),
//                         width: 1.5,
//                       )
//                     : null,
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: (color ?? AppColors.blueSecondaryColor)
//                               .withOpacity(0.2),
//                           blurRadius: 12,
//                           offset: const Offset(0, 4),
//                         ),
//                       ]
//                     : null,
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   splashColor:
//                       (color ?? AppColors.blueSecondaryColor).withOpacity(0.1),
//                   highlightColor:
//                       (color ?? AppColors.blueSecondaryColor).withOpacity(0.05),
//                   onTap: () {
//                     navigationController.navigateToDashboardOverview();
//                     context.go('/dashboard/dashboard/overview');
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     child: Row(
//                       children: [
//                         if (icon != null) ...[
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 200),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? (color ?? AppColors.blueSecondaryColor)
//                                       .withOpacity(0.15)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               icon,
//                               size: isSubItem ? 16 : 18,
//                               color: isSelected
//                                   ? (color ?? AppColors.blueSecondaryColor)
//                                   : const Color.fromARGB(
//                                       255, 196, 207, 225), // Slate 400
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                         ],
//                         Expanded(
//                           child: CustomText(
//                             text: label,

//                             fontSize: isSubItem ? 13 : 14,
//                             fontWeight:
//                                 isSelected ? FontWeight.w600 : FontWeight.w500,
//                             color: isSelected
//                                 ? AppColors.textWhiteColour
//                                     .withOpacity(0.9) // Slate 50
//                                 : AppColors.textWhiteColour
//                                     .withOpacity(0.6), // Slate 300
//                           ),
//                         ),
//                         if (isSelected)
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               color: color ?? AppColors.blueSecondaryColor,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: (color ?? AppColors.blueSecondaryColor)
//                                       .withOpacity(0.6),
//                                   blurRadius: 6,
//                                   spreadRadius: 1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }