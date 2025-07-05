import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/view/screens/dashboard/widgets/todays_quotes.dart';
import 'package:provider/provider.dart';

import '../../../res/style/colors/colors.dart';
import '../../widgets/custom_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟 Premium Header Section
            _buildPremiumHeader(),

            const SizedBox(height: 30),

            // 💭 Today's Quote Section
            BuildTodaysQuotesSection(),
            SizedBox(height: 30),

            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWeb =
                    constraints.maxWidth > 800; // Adjust breakpoint as needed

                if (isWeb) {
                  // Web layout - horizontal arrangement
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.assessment,
                                  size: 40,
                                ),
                                const Text(
                                  "Things For you",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // final userList = controller.userList.value;
                            // final totalLeads = userList?.totalItems ?? 0;

                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                _buildStatCard(
                                  icon: Icons.trending_up,
                                  title: "Active Today",
                                  value: "24",
                                  color: AppColors.greenSecondaryColor,
                                ),
                                _buildStatCard(
                                  icon: Icons.schedule,
                                  title: "Pending",
                                  value: "8",
                                  color: AppColors.orangeSecondaryColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 40,
                                ),
                                const Text(
                                  "Call Statistics",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Consumer<AppUserProvider>(
                              builder: (context, value, child) => Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      value.selectedIndex = 35;
                                    },
                                    child: _buildCallStatCard(
                                      title: "Today's Calls",
                                      value: "47",
                                      icon: Icons.phone_in_talk_rounded,
                                      color: Colors.green,
                                      width: (constraints.maxWidth - 80) /
                                          6, // Adjusted for row layout
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.selectedIndex = 35;
                                    },
                                    child: _buildCallStatCard(
                                      title: "This Week",
                                      value: "285",
                                      icon: Icons.trending_up_rounded,
                                      color: Colors.blue,
                                      width: (constraints.maxWidth - 80) / 6,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.selectedIndex = 35;
                                    },
                                    child: _buildCallStatCard(
                                      title: "This Month",
                                      value: "1,247",
                                      icon: Icons.bar_chart_rounded,
                                      color: Colors.purple,
                                      width: (constraints.maxWidth - 80) / 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Things For You Section
                    ],
                  );
                } else {
                  // Mobile layout - vertical arrangement
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Call Statistics Section
                      const Text(
                        "📞 Call Statistics",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Consumer<AppUserProvider>(
                        builder: (context, value, child) => LayoutBuilder(
                          builder: (context, innerConstraints) {
                            return Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                InkWell(
                                  onTap: () {
                                    value.selectedIndex = 35;
                                  },
                                  child: _buildCallStatCard(
                                    title: "Today's Calls",
                                    value: "47",
                                    icon: Icons.phone_in_talk_rounded,
                                    color: Colors.green,
                                    width: innerConstraints.maxWidth - 40,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    value.selectedIndex = 35;
                                  },
                                  child: _buildCallStatCard(
                                    title: "This Week",
                                    value: "285",
                                    icon: Icons.trending_up_rounded,
                                    color: Colors.blue,
                                    width: innerConstraints.maxWidth - 40,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    value.selectedIndex = 35;
                                  },
                                  child: _buildCallStatCard(
                                    title: "This Month",
                                    value: "1,247",
                                    icon: Icons.bar_chart_rounded,
                                    color: Colors.purple,
                                    width: innerConstraints.maxWidth - 40,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Things For You Section
                      const Text(
                        "📊 Things For you",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // final userList = controller.userList.value;
                      // final totalLeads = userList?.totalItems ?? 0;

                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          GestureDetector(
                            onTap: () => {/* Get.to(() => CallLogDisplay()) */},
                            child: _buildStatCard(
                              icon: Icons.trending_up,
                              title: "Active Today",
                              value: "24",
                              color: AppColors.greenSecondaryColor,
                            ),
                          ),
                          _buildStatCard(
                            icon: Icons.schedule,
                            title: "Pending",
                            value: "8",
                            color: AppColors.orangeSecondaryColor,
                          ),
                        ],
                      )
                    ],
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildCarouselSection(isWeb, screenWidth),

            const SizedBox(height: 30),

            // Multi-Column Layout using Expanded and Flexible

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1000) {
                  // Three column layout for very large screens
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column - Tasks
                        // Expanded(
                        //   flex: 3,
                        //   child: Column(
                        //     children: [
                        //       _buildTodayTasksSection(),
                        //       const SizedBox(height: 20),
                        //       // _buildPendingTasksSection(),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(width: 20),
                        // Middle Column - Projects
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildDeadlineProjectsSection(),
                              const SizedBox(height: 20),
                              // _buildAnnouncementsSection()
                              // // _buildActivityListSection(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // // Right Column - Announcements
                        Expanded(
                          flex: 2,
                          child: _buildAnnouncementsSection(),
                        ),
                      ],
                    ),
                  );
                } else if (constraints.maxWidth > 900) {
                  // Two column layout for medium screens
                  return Column(
                    children: [
                      // Tasks Row
                      // IntrinsicHeight(
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Expanded(child: _buildTodayTasksSection()),
                      //       const SizedBox(width: 20),
                      //       Expanded(child: _buildPendingTasksSection()),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 30),
                      // Projects and Announcements Row
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildDeadlineProjectsSection(),
                                  const SizedBox(height: 20),
                                  _buildAnnouncementsSection(),
                                ],
                              ),
                            ),
                            // const SizedBox(width: 20),
                            // Expanded(
                            //   flex: 1,
                            //   child: _buildAnnouncementsSection(),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Single column layout for small screens
                  return Column(
                    children: [
                      _buildTodayTasksSection(),
                      const SizedBox(height: 20),
                      // _buildPendingTasksSection(),
                      // const SizedBox(height: 30),
                      _buildDeadlineProjectsSection(),
                      const SizedBox(height: 30),
                      _buildAnnouncementsSection(),
                      // const SizedBox(height: 30),
                      // _buildActivityListSection(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Container(
        height: 185,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🌟 Premium Header
  Widget _buildPremiumHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          stops: [0, .15, 1],
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor,
            Colors.blue.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.flight_takeoff_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Affiniks Management Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Empowering clients to achieve their migration dreams",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 24),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.15),
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: Colors.white.withOpacity(0.2)),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Icon(Icons.access_time_rounded,
          //           color: Colors.white, size: 20),
          //       const SizedBox(width: 8),
          //       Text(
          //         "Last updated: ${DateTime.now().toString().substring(0, 16)}",
          //         style: const TextStyle(
          //           color: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // 🎠 Carousel Section with responsive sizing
  Widget _buildCarouselSection(bool isWeb, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🌍 Campagins",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              height: isWeb ? 320 : 280,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: isWeb ? 0.5 : 0.85,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enableInfiniteScroll: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            ),
            items: [
              _buildCarouselCard(
                title: "Canada Immigration",
                image: 'https://picsum.photos/id/1015/600/320',
                color: Colors.red,
              ),
              _buildCarouselCard(
                title: "Australia Points System",
                image: 'https://picsum.photos/id/1016/600/320',
                color: Colors.green,
              ),
              _buildCarouselCard(
                title: "European Union",
                image: 'https://picsum.photos/id/1019/600/320',
                color: Colors.blue,
              ),
              _buildCarouselCard(
                title: "Student Visas",
                image: 'https://picsum.photos/id/1018/600/320',
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselCard({
    required String title,
    required String image,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    color.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 28,
              right: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📋 Today's Tasks Section
  Widget _buildTodayTasksSection() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.today_rounded,
                    color: Colors.green, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "✅ Today's Tasks",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "6 tasks",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildTaskItem(
                  title: "Review visa applications - Canada",
                  time: "9:00 AM",
                  priority: "High",
                  isCompleted: true,
                  color: Colors.green,
                ),
                _buildTaskItem(
                  title: "Prepare IELTS guidance materials",
                  time: "11:30 AM",
                  priority: "Medium",
                  isCompleted: false,
                  color: Colors.orange,
                ),
                _buildTaskItem(
                  title: "Client consultation - Smith family",
                  time: "2:00 PM",
                  priority: "High",
                  isCompleted: false,
                  color: Colors.red,
                ),
                _buildTaskItem(
                  title: "Update immigration database",
                  time: "4:30 PM",
                  priority: "Low",
                  isCompleted: false,
                  color: Colors.blue,
                ),
                _buildTaskItem(
                  title: "Submit PNP applications",
                  time: "5:00 PM",
                  priority: "Medium",
                  isCompleted: false,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📋 Pending Tasks Section
  Widget _buildPendingTasksSection() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.pending_actions_rounded,
                    color: Colors.orange, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "⏳ Pending Tasks",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "8 pending",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildTaskItem(
                  title: "Review Australia PR applications",
                  time: "Overdue 2 days",
                  priority: "High",
                  isCompleted: false,
                  color: Colors.red,
                  isOverdue: true,
                ),
                _buildTaskItem(
                  title: "Complete document verification",
                  time: "Due tomorrow",
                  priority: "Medium",
                  isCompleted: false,
                  color: Colors.orange,
                ),
                _buildTaskItem(
                  title: "Update client immigration status",
                  time: "Due in 3 days",
                  priority: "Low",
                  isCompleted: false,
                  color: Colors.blue,
                ),
                _buildTaskItem(
                  title: "Prepare visa interview training",
                  time: "Due in 5 days",
                  priority: "Medium",
                  isCompleted: false,
                  color: Colors.purple,
                ),
                _buildTaskItem(
                  title: "Conduct team briefing",
                  time: "Due next week",
                  priority: "Low",
                  isCompleted: false,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String time,
    required String priority,
    required bool isCompleted,
    required Color color,
    bool isOverdue = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.05)
            : isOverdue
                ? Colors.red.withOpacity(0.05)
                : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withOpacity(0.2)
              : isOverdue
                  ? Colors.red.withOpacity(0.2)
                  : color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green : Colors.transparent,
              border: Border.all(
                color: isCompleted
                    ? Colors.green
                    : isOverdue
                        ? Colors.red
                        : color,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.green : AppColors.primaryColor,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      isOverdue
                          ? Icons.warning_rounded
                          : Icons.access_time_rounded,
                      size: 14,
                      color: isOverdue ? Colors.red : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: isOverdue ? Colors.red : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              priority,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📅 Deadline Projects Section
  Widget _buildDeadlineProjectsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.calendar_today_rounded,
                    color: Colors.purple, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "⏰ Deadline Projects",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "5 projects",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildProjectItem(
                title: "Canada Express Entry Batch",
                deadline: "July 15, 2023",
                targeted: 100,
                reached: 70,
                color: Colors.blue,
              ),
              _buildProjectItem(
                title: "Australia SkillSelect Round",
                deadline: "July 22, 2023",
                targeted: 50,
                reached: 34,
                color: Colors.green,
              ),
              _buildProjectItem(
                title: "UK Skilled Worker Visa",
                deadline: "July 30, 2023",
                targeted: 100,
                reached: 20,
                color: Colors.red,
              ),
              _buildProjectItem(
                title: "New Zealand EOI Selection",
                deadline: "August 5, 2023",
                targeted: 10,
                reached: 5,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return SizedBox(
      width: 250, // fixed width for wrapping layout
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomText(
              text: value,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textGrayColour,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectItem({
    required String title,
    required String deadline,
    required int targeted,
    required int reached,
    required Color color,
  }) {
    final double progress = targeted == 0 ? 0 : reached / targeted;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                deadline,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: color.withOpacity(0.2),
                    color: color,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people_alt_rounded, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                "$targeted targeted, $reached reached",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  progress > 0.75
                      ? "On track"
                      : progress > 0.4
                          ? "Needs focus"
                          : "Behind schedule",
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 📢 Announcements Section
  Widget _buildAnnouncementsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.announcement_rounded,
                    color: Colors.blue, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "📢 Announcements",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildAnnouncementItem(
                title: "New Immigration Policy Update",
                description: "Canada announces changes to Express Entry system",
                time: "2 hours ago",
                icon: Icons.new_releases_rounded,
                color: Colors.red,
              ),
              _buildAnnouncementItem(
                title: "Team Meeting Scheduled",
                description: "Monthly review meeting on Friday at 11 AM",
                time: "Yesterday",
                icon: Icons.people_rounded,
                color: Colors.green,
              ),
              _buildAnnouncementItem(
                title: "Document Checklist Updated",
                description: "New requirements for student visa applications",
                time: "2 days ago",
                icon: Icons.description_rounded,
                color: Colors.orange,
              ),
              _buildAnnouncementItem(
                title: "Holiday Notice",
                description:
                    "Office will be closed on July 4th for Independence Day",
                time: "1 week ago",
                icon: Icons.celebration_rounded,
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📝 Activity List Section
  Widget _buildActivityListSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.history_rounded,
                    color: Colors.red, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "📝 Recent Activity",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildActivityItem(
                title: "Visa approved for John Smith",
                description: "Canada PR application approved",
                time: "Just now",
                icon: Icons.verified_rounded,
                color: Colors.green,
              ),
              _buildActivityItem(
                title: "New consultation booked",
                description: "Family of 4 for Australia migration",
                time: "30 minutes ago",
                icon: Icons.event_available_rounded,
                color: Colors.blue,
              ),
              _buildActivityItem(
                title: "Document submitted",
                description: "IELTS results for client #2456",
                time: "2 hours ago",
                icon: Icons.upload_rounded,
                color: Colors.orange,
              ),
              _buildActivityItem(
                title: "Payment received",
                description: "For Canada Express Entry application",
                time: "5 hours ago",
                icon: Icons.payment_rounded,
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
