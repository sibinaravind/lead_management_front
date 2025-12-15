import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/lead_details_tab.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/other_tab.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/product_intrested_tab.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/status_update_popup.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/vehicle_tab.dart';
import '../../../utils/style/colors/colors.dart';
import '../../widgets/custom_text.dart';
import '../leads/add_lead_screen.dart';
import 'widgets/education_tab.dart';
import 'widgets/real_estate_tab.dart';
import 'widgets/travel_tab.dart';
import 'widgets/call_history_tab.dart';
import 'widgets/customer_activity_journey.dart';
import 'widgets/document_tab.dart';
import 'widgets/professional_tab.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({
    super.key,
    required this.leadId,
  });

  final String leadId;

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  int _selectedTabIndex = 0;
  final profileController = Get.find<CustomerProfileController>();
  List<Map<String, dynamic>> _tabs = [];

  @override
  initState() {
    super.initState();
    initializeTabs();
  }

  Future<void> initializeTabs() async {
    await profileController.getLeadDetails(context, widget.leadId);
    _tabs = [
      {
        'icon': Icons.assignment_outlined,
        'label': 'Candidate Details',
        'widget': LeadDetailsTab(),
        'completed': true,
      },
      {
        'icon': Icons.call_outlined,
        'label': 'Call History',
        'widget': CallHistoryTab(clientId: widget.leadId),
        'completed': true,
      },
      {
        'icon': Icons.shopping_bag_rounded,
        'label': 'Products Interested',
        'widget': ProductInterestedTab(),
        'completed': true,
      },
      {
        'icon': Icons.work_outline,
        'label': 'Finance/Professional ',
        'widget': ProfessionalTab(lead: profileController.leadDetails.value),
        'completed': true,
      },
      {
        'icon': Icons.travel_explore,
        'label': 'Travel Pref',
        'widget': TravelTab(lead: profileController.leadDetails.value),
        'completed': true,
      },
      {
        'icon': Icons.work,
        'label': 'Educational Pref',
        'widget': EducationDeatilsTab(
          lead: profileController.leadDetails.value,
        ),
        'completed': true,
      },
      {
        'icon': Icons.directions_car_rounded,
        'label': 'Vehicle Pref',
        'widget': VehicleTab(lead: profileController.leadDetails.value),
        // 'widget': TravelRecordsTab(
        //   records: profileController.leadDetails.value.travelRecords ?? [],
        // ),
        'completed': true,
      },
      {
        'icon': Icons.home_work_rounded,
        'label': 'Real Estate Pref',
        'widget': RealEstateTab(lead: profileController.leadDetails.value),
        // 'widget': DocumentsTab(
        //   documents: profileController.leadDetails.value.documents ?? [],
        // ),
        'completed': true,
      },
      {
        'icon': Icons.info_outline,
        'label': 'Other Details',
        'widget': OtherDeatilsTab(
          lead: profileController.leadDetails.value,
        ),
        'completed': true,
      },
      {
        'icon': Icons.folder_copy,
        'label': 'Documents',
        'widget': DocumentsTab(
          lead: profileController.leadDetails.value,
        ),
        'completed': true,
      },
      {
        'icon': Icons.chat_bubble_outline,
        'label': 'Customer Journey',
        'widget': CustomerJourneyStages(
          leadid: widget.leadId,
        ),
        'completed': true,
      },
    ];
    setState(() {});
  }

  List<Widget> _chipsList() {
    return [
      _buildInfoChip(
          Icons.update,
          profileController.leadDetails.value.status ?? 'N/A',
          AppColors.greenSecondaryColor),
      _buildInfoChip(
          Icons.phone,
          profileController.leadDetails.value.phone ?? 'N/A',
          AppColors.whiteMainColor),
      _buildInfoChip(
          Icons.email,
          profileController.leadDetails.value.email ?? 'N/A',
          AppColors.redSecondaryColor),
      _buildInfoChip(
          Icons.person_outline,
          'Officer: ${profileController.leadDetails.value.officerName ?? 'N/A'}',
          AppColors.blueSecondaryColor),
      _buildInfoChip(
          Icons.person_outline,
          'Branch: ${profileController.leadDetails.value.branch ?? 'N/A'}',
          AppColors.viloletSecondaryColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 16 : 8),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.height * 0.98
              : MediaQuery.of(context).size.height * 0.9,
          maxWidth: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width * 0.95
              : double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header - Fixed height
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
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
                    const Flexible(
                      child: CustomText(
                        text: 'Lead Profile',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

            // Profile Section - Fixed height
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
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
                  // Profile row - make it responsive
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 400;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: AppColors.buttonGraidentColour,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.person,
                                    color: Colors.white, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: profileController
                                                    .leadDetails.value.name ??
                                                'N/A',
                                            fontSize: isSmallScreen ? 20 : 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textWhiteColour,
                                          ),
                                          const SizedBox(height: 4),
                                          CustomText(
                                            text: profileController.leadDetails
                                                    .value.clientId ??
                                                'N/A',
                                            fontSize: 14,
                                            color: AppColors.textGrayColour,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: PopupMenuButton<String>(
                                  elevation: 8,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: isSmallScreen ? 24 : 28,
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit_lead') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AddLeadScreen(
                                          leadToEdit: profileController
                                              .leadDetails.value,
                                        ),
                                      );
                                    } else if (value == 'update_status') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => StatusUpdatePopup(
                                          clientId: profileController
                                                  .leadDetails.value.id ??
                                              '',
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'edit_lead',
                                      child: Row(
                                        children: const [
                                          Icon(Icons.edit,
                                              size: 20,
                                              color:
                                                  AppColors.redSecondaryColor),
                                          SizedBox(width: 10),
                                          CustomText(
                                            text: 'Edit Lead',
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'update_status',
                                      child: Row(
                                        children: const [
                                          Icon(Icons.update,
                                              size: 20,
                                              color: AppColors
                                                  .greenSecondaryColor),
                                          SizedBox(width: 10),
                                          CustomText(
                                            text: 'Update Status',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // showDialog(
                              //     //   context: context,
                              //     //   builder: (context) => AddLeadScreen(
                              //     //     leadToEdit:
                              //     //         profileController.leadDetails.value,
                              //     //   ),
                              //     // );
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) => StatusUpdatePopup(
                              //         clientId: profileController
                              //                 .leadDetails.value.id ??
                              //             '',
                              //       ),
                              //     );
                              //   },
                              //   child: Icon(
                              //     Icons.edit_square,
                              //     color: AppColors.redSecondaryColor,
                              //     size: isSmallScreen ? 24 : 28,
                              //   ),
                              // ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Obx(
                            () => Align(
                              alignment: Alignment.centerLeft,
                              child: isSmallScreen
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: _chipsList()
                                            .map((chip) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: chip,
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  : Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: _chipsList()),
                            ),
                          ),
                          // Edit button - move to separate row on small screens
                        ],
                      );
                    },
                  ),

                  // Info chips - make them responsive

                  // const SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     _buildStatusChip(
                  //         leadProvider.leadDetails?.serviceType ?? 'N/A',
                  //         AppColors.skyBlueSecondaryColor),
                  //   ],
                  // ),
                ],
              ),
            ),

            // Tabs section - This is the main scrollable content
            Expanded(
              child: _tabs.isEmpty
                  ? Center(child: Text("No Tabs Available"))
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final isDesktop =
                            MediaQuery.of(context).size.width > 1000;
                        return isDesktop
                            ? Container(
                                height: 420,
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
                                      width: 280,
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
                                          final isSelected =
                                              _selectedTabIndex == index;
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 4),
                                            decoration: BoxDecoration(
                                              gradient: isSelected
                                                  ? AppColors
                                                      .buttonGraidentColour
                                                  : null,
                                              color: isSelected
                                                  ? null
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                    : Colors.white
                                                        .withOpacity(0.5),
                                              ),
                                              trailing: tab['completed'] as bool
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : AppColors
                                                              .greenSecondaryColor,
                                                      size: 18,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .radio_button_unchecked,
                                                      color: isSelected
                                                          ? Colors.white70
                                                          : AppColors
                                                              .textGrayColour,
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
                                        padding: const EdgeInsets.all(10),
                                        child: _tabs[_selectedTabIndex]
                                            ['widget'] as Widget,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : // Mobile layout with tabs
                            Column(
                                children: [
                                  // Tab bar for mobile
                                  Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                    ),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      itemCount: _tabs.length,
                                      itemBuilder: (context, index) {
                                        final tab = _tabs[index];
                                        final isSelected =
                                            _selectedTabIndex == index;
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 8),
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? AppColors.buttonGraidentColour
                                                : null,
                                            color: isSelected
                                                ? null
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedTabIndex = index;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    tab['icon'] as IconData,
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withOpacity(0.7),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  CustomText(
                                                    text:
                                                        tab['label'] as String,
                                                    fontSize: 12,
                                                    fontWeight: isSelected
                                                        ? FontWeight.w600
                                                        : FontWeight.w400,
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withOpacity(0.7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Tab content
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 0,
                                          bottom: 0),
                                      child: _tabs[_selectedTabIndex]['widget']
                                          as Widget,
                                    ),
                                  ),
                                ],
                              );
                      },
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
}
