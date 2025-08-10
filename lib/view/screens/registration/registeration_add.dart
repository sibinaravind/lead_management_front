import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';
import '../../../controller/registration/registration_controller.dart';
import '../../../utils/style/colors/colors.dart';
import 'tabs/acadamic_tab.dart';
import 'tabs/document_tab.dart';
import 'tabs/eligility_tab.dart';
import 'tabs/personal_details_tab.dart';
import 'tabs/travel_details.dart';
import 'tabs/work_experience_tab.dart';

class RegistrationAdd extends StatefulWidget {
  const RegistrationAdd({super.key, required this.leadid});
  final String leadid;

  @override
  State<RegistrationAdd> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationAdd>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _registrationController = Get.find<RegistrationController>();
  late ScrollController tabScrollController;
  String? contactCountryCode = '';

  @override
  void initState() {
    super.initState();
    tabScrollController = ScrollController();
    _tabController = TabController(length: 6, vsync: this);

    _fetchLeadDetails();
  }

  void _fetchLeadDetails() async {
    await _registrationController.getCustomerDetails(context, widget.leadid);
  }

  @override
  void dispose() {
    _tabController.dispose();

    tabScrollController.dispose();
    super.dispose();
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
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.98,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1600,
                minHeight: 500,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: AppColors.blackGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Header Title Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeSecondaryColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.person_add,
                                    color: AppColors.orangeSecondaryColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const CustomText(
                                  text: 'Candidate Registration',
                                  fontSize: 20,
                                  color: AppColors.textWhiteColour,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primaryColor.withOpacity(0.8),
                                      AppColors.primaryColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Obx(
                                () => Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: _registrationController
                                                .leadDetails.value.name ??
                                            'N/A',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.grey.shade800,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                              size: 14,
                                              color: Colors.grey.shade500),
                                          const SizedBox(width: 6),
                                          CustomText(
                                            text:
                                                '${_registrationController.leadDetails.value.countryCode ?? ''} ${_registrationController.leadDetails.value.phone ?? ''}',
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.email,
                                              size: 14,
                                              color: Colors.grey.shade500),
                                          const SizedBox(width: 6),
                                          CustomText(
                                            text: _registrationController
                                                    .leadDetails.value.email ??
                                                'N/A',
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.orange.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.pending,
                                        size: 14,
                                        color: Colors.orange.shade700),
                                    const SizedBox(width: 4),
                                    CustomText(
                                      text: 'Pending',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.orange.shade700,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                            ),
                          ),
                          child: Scrollbar(
                            controller: tabScrollController,
                            trackVisibility: true,
                            thumbVisibility: true,
                            thickness: 5,
                            radius: const Radius.circular(4),
                            child: SingleChildScrollView(
                              controller: tabScrollController,
                              scrollDirection: Axis.horizontal,
                              primary:
                                  false, // prevent primary ScrollController usage
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 2),
                              child: Row(
                                children: [
                                  AnimatedBuilder(
                                    animation: _tabController,
                                    builder: (context, _) {
                                      return TabBar(
                                        controller: _tabController,
                                        isScrollable: true,
                                        indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.primaryColor,
                                        ),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        dividerColor: Colors.transparent,
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                        tabs: [
                                          _buildEnhancedTab(
                                              'Personal Details',
                                              Icons.person_outline,
                                              _tabController.index == 0),
                                          _buildEnhancedTab(
                                              'Academic Details',
                                              Icons.school_outlined,
                                              _tabController.index == 1),
                                          _buildEnhancedTab(
                                              'Eligibility Test',
                                              Icons.language_outlined,
                                              _tabController.index == 2),
                                          _buildEnhancedTab(
                                              'Work Experience',
                                              Icons.work_outline,
                                              _tabController.index == 3),
                                          _buildEnhancedTab(
                                              'Travel Details',
                                              Icons.flight_outlined,
                                              _tabController.index == 4),
                                          _buildEnhancedTab(
                                              'Documents',
                                              Icons.description_outlined,
                                              _tabController.index == 5),
                                        ],
                                        onTap: (int index) {},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(() {
                            final lead =
                                _registrationController.leadDetails.value;

                            return TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                if (lead != null && lead.clientId != null) ...[
                                  PersonalDetailsTab(leadModel: lead),
                                  AcadamicTab(leadModel: lead),
                                  EligibilityTab(leadModel: lead),
                                  WorkExperience(leadModel: lead),
                                  TravelDetails(leadModel: lead),
                                  DocumentTab(leadModel: lead),
                                ] else ...[
                                  // Optional: Placeholder widgets when lead is null
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  const Center(
                                      child: CircularProgressIndicator()),
                                ],
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnhancedTab(String title, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color:
                isSelected ? AppColors.darkOrangeColour : Colors.grey.shade700,
          ),
          const SizedBox(width: 8),
          CustomText(
            text: title,
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(width: 15),
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
        ],
      ),
    );
  }
}
