import 'dart:math';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import '../../../../res/style/colors/colors.dart';
import '../../../widgets/custom_gradient_button.dart';
import '../../../widgets/custom_pager.dart';
import '../../../widgets/custom_text.dart';

class ProjectDetailsTab extends StatefulWidget {
  const ProjectDetailsTab({super.key, this.project});

  @override
  State<ProjectDetailsTab> createState() => _ProjectDetailsTabState();
  final ProjectModel? project;
}

class _ProjectDetailsTabState extends State<ProjectDetailsTab> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.assessment,
      'label': 'Project',
      'widget': const ProjectTab(),
      'completed': true,
    },
    {
      'icon': Icons.account_tree,
      'label': 'Client',
      'widget': const ClientTab(),
      'completed': true,
    },
    {
      'icon': Icons.account_box,
      'label': 'Matching',
      'widget': MatchingTab(),
      'completed': false,
    },
    {
      'icon': Icons.list,
      'label': 'Shortlist',
      'widget': ShortlistTab(),
      'completed': false,
    },
    {
      'icon': Icons.account_circle_rounded,
      'label': 'Interview',
      'widget': InterviewTab(),
      'completed': false,
    },
    // {
    //   'icon': Icons.person_outline,
    //   'label': 'Registration Personal',
    //   'widget': const RegistrationPersonalTab(),
    //   'completed': true,
    // },
    // {
    //   'icon': Icons.school_outlined,
    //   'label': 'Academic',
    //   'widget': const AcademicTab(),
    //   'completed': true,
    // },
    // {
    //   'icon': Icons.language_outlined,
    //   'label': 'Language Test',
    //   'widget': const LanguageTestTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.work_outline,
    //   'label': 'My Job Details',
    //   'widget': const JobDetailsTab(),
    //   'completed': true,
    // },
    // {
    //   'icon': Icons.flight_takeoff_outlined,
    //   'label': 'Migration',
    //   'widget': const MigrationTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.question_answer_outlined,
    //   'label': 'Interview',
    //   'widget': const InterviewTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.history_outlined,
    //   'label': 'Travel History',
    //   'widget': const TravelHistoryTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.description_outlined,
    //   'label': 'Documents',
    //   'widget': const DocumentsTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.verified_outlined,
    //   'label': 'Verification Status',
    //   'widget': const VerificationStatusTab(),
    //   'completed': false,
    // },
    // {
    //   'icon': Icons.app_registration_outlined,
    //   'label': 'Application Status',
    //   'widget': const ApplicationStatusTab(),
    //   'completed': false,
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95,
          maxHeight: MediaQuery.of(context).size.height * 0.95,
        ),
        child: Column(
          children: [
            // Header with gradient
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Project Details',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 24),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),

            // Customer Info Card
            Container(
              width: double.maxFinite,
              // margin: const EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                // borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(color: AppColors.iconWhiteColour),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGraidentColour,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.work,
                            color: Colors.white, size: 32),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'Saudi MOH',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textWhiteColour,
                                ),
                                CustomGradientButton(
                                  text: 'Edit Project',
                                  gradientColors: AppColors.redGradient,
                                  onPressed: () {
                                    // Handle view profile action
                                  },
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 8,
                                children: [
                                  _buildInfoChip(
                                      Icons.date_range,
                                      'Deadline: 29 July 25',
                                      AppColors.blueSecondaryColor),
                                  _buildInfoChip(
                                      Icons.numbers,
                                      'No of vacancies: 20',
                                      AppColors.greenSecondaryColor),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab and content section
            Expanded(
              child: Container(
                // margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Tab List
                    Container(
                      width: 200,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _tabs.length,
                        itemBuilder: (context, index) {
                          final tab = _tabs[index];
                          final isSelected = _selectedTabIndex == index;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? AppColors.buttonGraidentColour
                                  : null,
                              color: isSelected ? null : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              dense: true,
                              leading: Icon(
                                tab['icon'] as IconData,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textGrayColour,
                                size: 22,
                              ),
                              title: CustomText(
                                text: tab['label'] as String,
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w100,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                              trailing: tab['completed'] as bool
                                  ? Icon(
                                      Icons.check_circle,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.greenSecondaryColor,
                                      size: 18,
                                    )
                                  : Icon(
                                      Icons.radio_button_unchecked,
                                      color: isSelected
                                          ? Colors.white70
                                          : AppColors.textGrayColour,
                                      size: 18,
                                    ),
                              onTap: () {
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // Right content
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: _tabs[_selectedTabIndex]['widget'] as Widget,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          CustomText(text: text, fontSize: 12, color: color),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: CustomText(
        text: text,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

// Enhanced Tab Widgets with detailed content

class ProjectTab extends StatelessWidget {
  const ProjectTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Project Information', Icons.assignment_outlined),
        const SizedBox(height: 16),
        _buildDetailCard([
          _buildDetailRow('Organization', 'Saudi MOH'),
          _buildDetailRow('Job Posititon', 'Doctor'),
          _buildDetailRow('Job Field', 'Medical',
              color: AppColors.redSecondaryColor),
          _buildDetailRow('Qualification', 'Degree'),
          _buildDetailRow('No of vacancies', '10'),
          _buildDetailRow('CV Target', '10'),
          _buildDetailRow('Deadline', '28 July 2025',
              color: AppColors.greenSecondaryColor),
          // _buildDetailRow('Priority', 'High',
          //     color: AppColors.orangeSecondaryColor),
        ]),
        // const SizedBox(height: 20),
        // _buildSectionHeader('Contact Preferences', Icons.contact_phone),
        // const SizedBox(height: 16),
        // _buildDetailCard([
        //   _buildDetailRow('Preferred Contact Time', '10:00 AM - 6:00 PM'),
        //   _buildDetailRow('Preferred Language', 'English, Malayalam'),
        //   _buildDetailRow('Contact Method', 'Phone Call, WhatsApp'),
        //   _buildDetailRow('Time Zone', 'IST (UTC+5:30)'),
        // ]),
        // const SizedBox(height: 20),
        // _buildSectionHeader('Lead Notes', Icons.note_alt_outlined),
        // const SizedBox(height: 16),
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     color: AppColors.textWhiteColour,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: AppColors.iconWhiteColour),
        //   ),
        //   child: const CustomText(
        //     text:
        //         'Customer showed high interest in Canada PR program. Has relevant work experience in IT sector. Requested detailed information about Express Entry process and timeline.',
        //     fontSize: 14,
        //     color: AppColors.primaryColor,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGraidentColour,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Project Information', Icons.assignment_outlined),
        const SizedBox(height: 16),
        _buildDetailCard([
          _buildDetailRow('Hospital', 'Hospital A'),
          _buildDetailRow('Job Posititon', 'Doctor'),
          _buildDetailRow('Job Field', 'Medical',
              color: AppColors.redSecondaryColor),
          _buildDetailRow('Qualification', 'Degree'),
          _buildDetailRow('No of vacancies', '10'),
          _buildDetailRow('CV Target', '10'),
          _buildDetailRow('Deadline', '28 July 2025',
              color: AppColors.greenSecondaryColor),
        ]),
      ],
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.iconWhiteColour),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textGrayColour,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomText(
              text: value,
              fontSize: 14,
              color: color ?? AppColors.primaryColor,
              fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ClientTab extends StatelessWidget {
  const ClientTab({super.key});

  @override
  Widget build(BuildContext context) {
    // return DisplayClientManagementTab();
    return Container();
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGraidentColour,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildCallSummaryCards() {
    return Row(
      children: [
        Expanded(
            child: _buildSummaryCard(
                'Total Calls', '12', AppColors.blueSecondaryColor, Icons.call)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildSummaryCard('Answered', '9',
                AppColors.greenSecondaryColor, Icons.call_received)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildSummaryCard(
                'Missed', '3', AppColors.redSecondaryColor, Icons.call_missed)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildSummaryCard('Total Duration', '2h 45m',
                AppColors.viloletSecondaryColor, Icons.schedule)),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          CustomText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: title,
            fontSize: 12,
            color: AppColors.textGrayColour,
          ),
        ],
      ),
    );
  }

  Widget _buildCallHistoryList() {
    final calls = [
      {
        'date': '28 May 2024',
        'time': '2:30 PM',
        'duration': '15 min',
        'type': 'Outgoing',
        'status': 'Answered',
        'notes': 'Discussed Canada PR requirements'
      },
      {
        'date': '25 May 2024',
        'time': '11:45 AM',
        'duration': '8 min',
        'type': 'Incoming',
        'status': 'Answered',
        'notes': 'Follow-up on document submission'
      },
      {
        'date': '22 May 2024',
        'time': '4:15 PM',
        'duration': '0 min',
        'type': 'Outgoing',
        'status': 'Missed',
        'notes': 'Customer callback requested'
      },
      {
        'date': '20 May 2024',
        'time': '10:20 AM',
        'duration': '22 min',
        'type': 'Outgoing',
        'status': 'Answered',
        'notes': 'Initial consultation - Express Entry'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Recent Calls',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 12),
        ...calls.map((call) => _buildCallItem(call)).toList(),
      ],
    );
  }

  Widget _buildCallItem(Map<String, String> call) {
    Color statusColor = call['status'] == 'Answered'
        ? AppColors.greenSecondaryColor
        : AppColors.redSecondaryColor;
    IconData callIcon =
        call['type'] == 'Incoming' ? Icons.call_received : Icons.call_made;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.iconWhiteColour),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(callIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: '${call['date']} • ${call['time']}',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomText(
                        text: call['status']!,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    CustomText(
                      text: 'Duration: ${call['duration']}',
                      fontSize: 12,
                      color: AppColors.textGrayColour,
                    ),
                    const SizedBox(width: 16),
                    CustomText(
                      text: call['type']!,
                      fontSize: 12,
                      color: AppColors.textGrayColour,
                    ),
                  ],
                ),
                if (call['notes']!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  CustomText(
                    text: call['notes']!,
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShortlistTab extends StatelessWidget {
  ShortlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        // margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Table Content
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: ShortlistUserListTable(userlist: userList.data),
            // ),

            // Footer with Pagination
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.textGrayColour.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.blackGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomText(
                          //   text: "${userList.totalItems} Leads",
                          //   color: AppColors.primaryColor,
                          //   fontWeight: FontWeight.w700,
                          //   fontSize: 15,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // CustomPager(
                  //   currentPage: controller.currentPage.value + 1,
                  //   totalPages: min(userList.totalItems, 100),
                  //   onPageSelected: (page) {
                  //     if (controller.currentPage.value != page - 1) {
                  //       controller.currentPage.value = page - 1;
                  //       controller.onPageSelected(page - 1);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterviewTab extends StatelessWidget {
  InterviewTab({super.key});
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        // margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Table Header
            // Container(
            //   width: double.maxFinite,
            //   padding: const EdgeInsets.only(
            //       top: 6, bottom: 8, left: 15, right: 15),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: const BorderRadius.only(
            //         bottomLeft: Radius.circular(20),
            //         bottomRight: Radius.circular(20)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.05),
            //         blurRadius: 20,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            // child: Row(
            // children: [
            // Expanded(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         _buildFilterChip(
            //           icon: Icons.all_inclusive,
            //           text: 'All Leads',
            //           count: 128,
            //           color: AppColors.primaryColor,
            //           isSelected: selectedFilter == 'all',
            //           onTap: () {
            //             selectedFilter = 'all';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.fiber_new,
            //           text: 'New',
            //           count: 10,
            //           color: AppColors.blueSecondaryColor,
            //           isSelected: selectedFilter == 'new',
            //           onTap: () {
            //             selectedFilter = 'new';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.today,
            //           text: 'Today',
            //           count: 24,
            //           color: AppColors.greenSecondaryColor,
            //           isSelected: selectedFilter == 'today',
            //           onTap: () {
            //             selectedFilter = 'today';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.schedule,
            //           text: 'Pending',
            //           count: 8,
            //           color: AppColors.orangeSecondaryColor,
            //           isSelected: selectedFilter == 'pending',
            //           onTap: () {
            //             selectedFilter = 'pending';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.trending_up,
            //           text: 'Hot Leads',
            //           count: 15,
            //           color: AppColors.redSecondaryColor,
            //           isSelected: selectedFilter == 'hot',
            //           onTap: () {
            //             selectedFilter = 'hot';
            //           },
            //         ),
            //         _buildFilterChip(
            //           icon: Icons.history,
            //           text: 'Converted',
            //           count: 156,
            //           color: AppColors.viloletSecondaryColor,
            //           isSelected: selectedFilter == 'converted',
            //           onTap: () {
            //             selectedFilter = 'converted';
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ],
            // ),
            // ),
            // Table Content
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: InterviewUserListTable(userlist: userList.data),
            // ),

            // Footer with Pagination
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.textGrayColour.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.blackGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomText(
                          //   text: "${userList.totalItems} Leads",
                          //   color: AppColors.primaryColor,
                          //   fontWeight: FontWeight.w700,
                          //   fontSize: 15,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // CustomPager(
                  //   currentPage: controller.currentPage.value + 1,
                  //   totalPages: min(userList.totalItems, 100),
                  //   onPageSelected: (page) {
                  //     if (controller.currentPage.value != page - 1) {
                  //       controller.currentPage.value = page - 1;
                  //       controller.onPageSelected(page - 1);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String text,
    required int count,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            onTap();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? color : color.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : color,
                  size: 16,
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: text,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.primaryColor,
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    text: count.toString(),
                    color: isSelected ? Colors.white : color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MatchingTab extends StatelessWidget {
  MatchingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        // margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Table Header
            // Table Content
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: MatchingUserListTable(userlist: userList.data),
            // ),

            // Footer with Pagination
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.textGrayColour.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: AppColors.blackGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomText(
                          //   text: "${userList.totalItems} Leads",
                          //   color: AppColors.primaryColor,
                          //   fontWeight: FontWeight.w700,
                          //   fontSize: 15,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // CustomPager(
                  //   currentPage: controller.currentPage.value + 1,
                  //   totalPages: min(userList.totalItems, 100),
                  //   onPageSelected: (page) {
                  //     if (controller.currentPage.value != page - 1) {
                  //       controller.currentPage.value = page - 1;
                  //       controller.onPageSelected(page - 1);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     TextButton.icon(
    //       onPressed: () {
    //         showDialog(
    //             context: context,
    //             builder: (context) => AlertDialog(
    //                   title: Text("Add to interview?"),
    //                   actions: [
    //                     TextButton(
    //                         onPressed: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Text("No")),
    //                     TextButton(
    //                         onPressed: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Text("Yes"))
    //                   ],
    //                 ));
    //       },
    //       label: Text("Add to interview"),
    //       icon: Icon(Icons.person),
    //     ),
    //     TextButton.icon(
    //       onPressed: () {},
    //       label: Text("Add to shortlist"),
    //       icon: Icon(Icons.assignment_add),
    //     ),
    //   ],
    // );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGraidentColour,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildCampaignOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGraident,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.iconWhiteColour),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Current Campaign',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 12),
          // _buildDetailRow('Campaign Name', 'Canada PR - Express Entry 2024'),
          // _buildDetailRow('Campaign Type', 'Migration Services'),
          // _buildDetailRow('Target Audience', 'IT Professionals (25-35 years)'),
          // _buildDetailRow('Start Date', '1 Jan 2024'),
          // _buildDetailRow('End Date', '31 Dec 2024'),
          // _buildDetailRow('Status', 'Active',
          //     color: AppColors.greenSecondaryColor),
          // _buildDetailRow('Lead Source', 'Google Ads, Facebook, Website'),
          // _buildDetailRow('Budget Allocated', '₹50,000'),
          // _buildDetailRow('Spent So Far', '₹32,500'),
        ],
      ),
    );
  }

  Widget _buildCampaignHistory() {
    final campaigns = [
      {
        'name': 'Canada PR - Express Entry 2024',
        'type': 'Migration',
        'status': 'Active',
        'leads': '45',
        'conversions': '12',
        'cost': '₹32,500'
      },
      {
        'name': 'Australia Student Visa',
        'type': 'Education',
        'status': 'Completed',
        'leads': '28',
        'conversions': '8',
        'cost': '₹18,200'
      },
      {
        'name': 'UK Work Visa Campaign',
        'type': 'Work Visa',
        'status': 'Paused',
        'leads': '15',
        'conversions': '3',
        'cost': '₹12,800'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Campaign Performance',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 12),
        ...campaigns.map((campaign) => _buildCampaignCard(campaign)).toList(),
      ],
    );
  }

  Widget _buildCampaignCard(Map<String, String> campaign) {
    Color statusColor = campaign['status'] == 'Active'
        ? AppColors.greenSecondaryColor
        : campaign['status'] == 'Paused'
            ? AppColors.orangeSecondaryColor
            : AppColors.blueSecondaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.iconWhiteColour),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: campaign['name']!,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomText(
                  text: campaign['status']!,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildCampaignStat(
                  'Type', campaign['type']!, AppColors.viloletSecondaryColor),
              const SizedBox(width: 12),
              _buildCampaignStat(
                  'Leads', campaign['leads']!, AppColors.blueSecondaryColor),
              const SizedBox(width: 12),
              _buildCampaignStat('Conversions', campaign['conversions']!,
                  AppColors.greenSecondaryColor),
              const SizedBox(width: 12),
              _buildCampaignStat(
                  'Cost', campaign['cost']!, AppColors.orangeSecondaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CustomText(
            text: '$label: ',
            fontSize: 11,
            color: AppColors.textGrayColour,
          ),
          CustomText(
            text: value,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import '../../widgets/custom_text.dart';
// import './tabs/lead_details_tab.dart';
// import './tabs/call_history_tab.dart';
// import './tabs/campaign_tab.dart';
// import './tabs/registration_personal_tab.dart';
// import './tabs/academic_tab.dart';
// import './tabs/language_test_tab.dart';
// import './tabs/job_details_tab.dart';
// import './tabs/migration_tab.dart';
// import './tabs/interview_tab.dart';
// import './tabs/travel_history_tab.dart';
// import './tabs/documents_tab.dart';
// import './tabs/verification_status_tab.dart';
// import './tabs/application_status_tab.dart';

// class CustomerProfileScreen extends StatefulWidget {
//   const CustomerProfileScreen({super.key});

//   @override
//   State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
// }

// class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
//   int _selectedTabIndex = 0;

//   final List<Map<String, dynamic>> _tabs = [
//     {
//       'icon': Icons.assignment_outlined,
//       'label': 'Lead Details',
//       'widget': const LeadDetailsTab(),
//       'completed': true,
//     },
//     {
//       'icon': Icons.call_outlined,
//       'label': 'Call History',
//       'widget': const CallHistoryTab(),
//       'completed': true,
//     },
//     {
//       'icon': Icons.campaign_outlined,
//       'label': 'Campaign',
//       'widget': const CampaignTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.person_outline,
//       'label': 'Registration Personal',
//       'widget': const RegistrationPersonalTab(),
//       'completed': true,
//     },
//     {
//       'icon': Icons.school_outlined,
//       'label': 'Academic',
//       'widget': const AcademicTab(),
//       'completed': true,
//     },
//     {
//       'icon': Icons.language_outlined,
//       'label': 'Language Test',
//       'widget': const LanguageTestTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.work_outline,
//       'label': 'My Job Details',
//       'widget': const JobDetailsTab(),
//       'completed': true,
//     },
//     {
//       'icon': Icons.flight_takeoff_outlined,
//       'label': 'Migration',
//       'widget': const MigrationTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.question_answer_outlined,
//       'label': 'Interview',
//       'widget': const InterviewTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.history_outlined,
//       'label': 'Travel History',
//       'widget': const TravelHistoryTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.description_outlined,
//       'label': 'Documents',
//       'widget': const DocumentsTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.verified_outlined,
//       'label': 'Verification Status',
//       'widget': const VerificationStatusTab(),
//       'completed': false,
//     },
//     {
//       'icon': Icons.app_registration_outlined,
//       'label': 'Application Status',
//       'widget': const ApplicationStatusTab(),
//       'completed': false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(16),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.9,
//           maxHeight: MediaQuery.of(context).size.height * 0.9,
//         ),
//         child: Column(
//           children: [
//             // Header row
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const CustomText(
//                     text: 'View',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//             ),

//             // Info section
//             Container(
//               width: double.maxFinite,
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(4.0),
//               ),
//               child: Wrap(
//                 spacing: 16,
//                 runSpacing: 8,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   const CircleAvatar(
//                     backgroundColor: Colors.amber,
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                   const CustomText(
//                     text: 'Sibin PP',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   _buildTag(Icons.phone, 'Mobile: 91623'),
//                   _buildTag(Icons.person, 'Counselling by: Sibin - Recruiter'),
//                   _buildStatusTag('MIGRATION', Colors.grey[300]!),
//                   _buildStatusTag('REGISTRATION', Colors.red[100]!),
//                   _buildStatusTag('Registration Completed', Colors.green[100]!),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.delete, color: Colors.white),
//                     label: const CustomText(
//                         text: 'Delete Lead', color: Colors.white),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8),

//             // Tab and content section
//             Expanded(
//               child: Row(
//                 children: [
//                   // Left Tab List
//                   Container(
//                     width: 250,
//                     color: Colors.grey[100],
//                     child: ListView.builder(
//                       itemCount: _tabs.length,
//                       itemBuilder: (context, index) {
//                         final tab = _tabs[index];
//                         return ListTile(
//                           selected: _selectedTabIndex == index,
//                           selectedTileColor: Colors.blue[50],
//                           leading: Icon(
//                             tab['icon'] as IconData,
//                             color: _selectedTabIndex == index
//                                 ? Colors.blue
//                                 : Colors.grey,
//                           ),
//                           title: CustomText(
//                             text: tab['label'] as String,
//                             fontWeight: _selectedTabIndex == index
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                             color: _selectedTabIndex == index
//                                 ? Colors.blue
//                                 : Colors.black,
//                           ),
//                           trailing: tab['completed'] as bool
//                               ? const Icon(Icons.check_circle,
//                                   color: Colors.green, size: 20)
//                               : null,
//                           onTap: () {
//                             setState(() {
//                               _selectedTabIndex = index;
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),

//                   // Right content
//                   Expanded(
//                     child: Container(
//                       color: Colors.white,
//                       padding: const EdgeInsets.all(16),
//                       child: _tabs[_selectedTabIndex]['widget'] as Widget,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTag(IconData icon, String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16),
//           const SizedBox(width: 4),
//           CustomText(text: text),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: CustomText(text: text),
//     );
//   }
// }
