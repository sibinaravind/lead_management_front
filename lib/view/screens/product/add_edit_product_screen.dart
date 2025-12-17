// add_product_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/model/product/product_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/product_controller/product_controller.dart';
import '../../../model/product/price_distribution_model.dart';
import '../../../model/product/product_provider_deatils_model.dart';
import '../../widgets/custom_dropdown_with_text_widget.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModel? productToEdit;
  const AddProductScreen({super.key, this.productToEdit});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  final productController = Get.find<ProductController>();
  final configController = Get.find<ConfigController>();
  final _formKey = GlobalKey<FormState>();

  var productid = "";

  // Basic Information
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _shortDescriptionController =
      TextEditingController();
  final TextEditingController _validityController = TextEditingController();
  final TextEditingController _processingTimeController =
      TextEditingController();
  final TextEditingController _termsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _refundPolicyController = TextEditingController();
  final TextEditingController _warrantyInfoController = TextEditingController();
  final TextEditingController _supportDurationController =
      TextEditingController();

  // Pricing
  final TextEditingController _basePriceController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _advancePercentController =
      TextEditingController();

  // Provider Details
  final TextEditingController _providerNameController = TextEditingController();
  final TextEditingController _providerContactController =
      TextEditingController();
  final TextEditingController _providerEmailController =
      TextEditingController();
  final TextEditingController _providerAddressController =
      TextEditingController();

  // Dropdown Values
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedStatus = 'ACTIVE';
  String? _selectedServiceMode;
  String? _selectedCountry;
  String? _selectedCity;
  final TextEditingController _selectedStateController =
      TextEditingController();

  // Travel Specific
  final TextEditingController _durationController = TextEditingController();
  String? _selectedTravelType;
  String? _selectedVisaType;
  List<String> _inclusions = [];
  List<String> _exclusions = [];

  // Education Specific
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();
  String? _selectedCourseLevel;

  // Vehicle Specific
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _registrationYearController =
      TextEditingController();
  final TextEditingController _kmsDrivenController = TextEditingController();
  final TextEditingController _insuranceValidTillController =
      TextEditingController();
  final TextEditingController _downpaymentController = TextEditingController();
  final TextEditingController _loanEligibilityController =
      TextEditingController();
  String? _selectedFuelType;
  String? _selectedTransmission;

  // Real Estate Specific
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _possessionTimeController =
      TextEditingController();
  String? _selectedPropertyType;
  String? _selectedFurnishingStatus;

  // Eligibility
  final TextEditingController _ageLimitController = TextEditingController();
  final TextEditingController _minIncomeController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  // Documents Required
  List<DocumentsRequired> _documents = [];

  // Price Components
  List<PriceDistributionModel> _priceComponents = [];
  // Steps
  List<String> _stepList = [];

  // Tags
  List<String> _tags = [];

  // Checkboxes
  bool _requiresAgreement = false;
  bool _isRefundable = true;
  bool _supportAvailable = true;
  bool _jobAssistance = false;
  bool _interviewPreparation = false;

  late TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: 'Basic Info', icon: Icon(Icons.info, size: 16)),
    const Tab(text: 'Pricing', icon: Icon(Icons.attach_money, size: 16)),
    const Tab(text: 'Eligibility', icon: Icon(Icons.person, size: 16)),
    const Tab(text: 'Details', icon: Icon(Icons.details, size: 16)),
    const Tab(text: 'Provider', icon: Icon(Icons.business, size: 16)),
    const Tab(text: 'Other', icon: Icon(Icons.more_horiz, size: 16)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    if (widget.productToEdit != null) {
      _populateProductData(widget.productToEdit!);
    }
  }

  void _populateProductData(ProductModel product) {
    _nameController.text = product.name ?? '';
    _codeController.text = product.code ?? '';
    _selectedSubCategory = product.subCategory;
    _selectedStatus = product.status;
    _descriptionController.text = product.description ?? '';
    _shortDescriptionController.text = product.shortDescription ?? '';
    _basePriceController.text = product.basePrice?.toString() ?? '';
    _sellingPriceController.text = product.sellingPrice?.toString() ?? '';
    _costPriceController.text = product.costPrice?.toString() ?? '';
    _advancePercentController.text =
        product.advanceRequiredPercent?.toString() ?? '';
    _priceComponents.addAll(product.priceComponents ?? []);
    _documents = List.from(product.documentsRequired ?? []);
    _validityController.text = product.validity ?? '';
    _processingTimeController.text = product.processingTime ?? '';
    _selectedServiceMode = product.serviceMode;
    _downpaymentController.text = product.downpayment?.toString() ?? '';
    _loanEligibilityController.text = product.loanEligibility?.toString() ?? '';
    _ageLimitController.text = product.ageLimit ?? '';
    _minIncomeController.text = product.minIncomeRequired ?? '';
    _qualificationController.text = product.qualificationRequired ?? '';
    _experienceController.text = product.experienceRequired ?? '';
    _requiresAgreement = product.requiresAgreement ?? false;
    _isRefundable = product.isRefundable ?? true;
    _refundPolicyController.text = product.refundPolicy ?? '';
    _tags.addAll(product.tags ?? []);
    _notesController.text = product.notes ?? '';
    _selectedCountry = product.country;
    _selectedCity = product.city;
    _selectedStateController?.text = product.state ?? '';
    _selectedTravelType = product.travelType;
    _durationController.text = product.duration ?? '';
    _inclusions.addAll(product.inclusions ?? []);
    _exclusions.addAll(product.exclusions ?? []);
    _selectedVisaType = product.visaType;
    _jobAssistance = product.jobAssistance ?? false;
    _interviewPreparation = product.interviewPreparation ?? false;
    _brandController.text = product.brand ?? '';
    _modelController.text = product.model ?? '';
    _selectedFuelType = product.fuelType;
    _selectedTransmission = product.transmission;
    _registrationYearController.text = product.registrationYear ?? '';
    _kmsDrivenController.text = product.kmsDriven ?? '';
    _insuranceValidTillController.text = product.insuranceValidTill ?? '';
    _courseDurationController.text = product.courseDuration ?? '';
    _selectedCourseLevel = product.courseLevel;
    _institutionNameController.text = product.institutionName ?? '';

    _selectedPropertyType = product.propertyType;
    _sizeController.text = product.size ?? '';
    _bhkController.text = product.bhk ?? '';
    _locationController.text = product.location ?? '';
    _possessionTimeController.text = product.possessionTime ?? '';
    _selectedFurnishingStatus = product.furnishingStatus;
    _termsController.text = product.termsAndConditions ?? '';
    _supportAvailable = product.supportAvailable ?? true;
    _supportDurationController.text = product.supportDuration ?? '';
    _warrantyInfoController.text = product.warrantyInfo ?? '';

    // Provider Details
    _providerNameController.text = product.providerDetails?.name ?? '';
    _providerContactController.text = product.providerDetails?.contact ?? '';
    _providerEmailController.text = product.providerDetails?.email ?? '';
    _providerAddressController.text = product.providerDetails?.address ?? '';

    _stepList.addAll(product.stepList ?? []);
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

          var coloums = 2;
          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            coloums = 2;
            dialogWidth = maxWidth * 0.85;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.95;
            coloums = 2;
          } else if (maxWidth < 600) {
            coloums = 1;
            dialogWidth = maxWidth;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
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
                  )
                ],
              ),
              child: Column(
                children: [
                  // Header Section
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
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.inventory_2_rounded,
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
                                text: widget.productToEdit != null
                                    ? 'Edit Product'
                                    : 'Add New Product',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: widget.productToEdit != null
                                    ? 'Update product details'
                                    : 'Create a new product or service',
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

                  // Tab Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primaryColor,
                      tabs: _tabs,
                    ),
                  ),

                  // Form Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildBasicInfoTab(context, coloums),
                            _buildPricingTab(context, coloums),
                            _buildEligibilityTab(context, coloums),
                            _buildDetailsTab(context, coloums),
                            _buildProviderTab(context, coloums),
                            _buildOtherTab(context, coloums),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Form Buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
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
                            text: widget.productToEdit != null
                                ? 'Update Product'
                                : 'Save Product',
                            icon: Icons.save_rounded,
                            isFilled: true,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                            ),
                            onPressed: _saveProduct,
                          ),
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

  Widget _buildBasicInfoTab(
    BuildContext context,
    int coloums,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Basic Information',
            icon: Icons.info_outline_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Product Name',
                controller: _nameController,
                isRequired: true,
                hintText: 'e.g., Europe Holiday Package',
              ),
              CustomTextFormField(
                label: 'Product Code',
                controller: _codeController,
                hintText: 'e.g., PRD-00123',
              ),
              // CustomDropdownField(
              //   label: 'Category',
              //   value: _selectedCategory,
              //   isRequired: true,
              //   items: const [
              //     'TRAVEL',
              //     'EDUCATION',
              //     'MIGRATION',
              //     'VEHICLE',
              //     'REAL_ESTATE',
              //     'INSURANCE',
              //     'OTHER'
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedCategory = value;
              //       _generateProductCode();
              //     });
              //   },
              // ),
              CustomDropdownField(
                label: 'Sub Category',
                value: _selectedSubCategory,
                items: configController.configData.value.subcategory
                        ?.map((e) => e.name ?? "")
                        .toList() ??
                    [],
                onChanged: (value) =>
                    setState(() => _selectedSubCategory = value),
              ),
              CustomDropdownField(
                label: 'Service Mode',
                value: _selectedServiceMode,
                items: const ['ONLINE', 'OFFLINE', 'HYBRID'],
                onChanged: (value) =>
                    setState(() => _selectedServiceMode = value),
              ),
              CustomDropdownField(
                label: 'Status',
                value: _selectedStatus,
                items: const ['ACTIVE', 'INACTIVE', 'DRAFT', 'COMING_SOON'],
                onChanged: (value) => setState(() => _selectedStatus = value),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Descriptions',
            icon: Icons.description_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: 1,
            children: [
              CustomTextFormField(
                label: 'Short Description',
                controller: _shortDescriptionController,
                maxLines: 2,
                hintText: 'Brief description (max 150 characters)',
              ),
              CustomTextFormField(
                label: 'Full Description',
                controller: _descriptionController,
                maxLines: 4,
                hintText: 'Detailed product description',
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPricingTab(BuildContext context, int coloums) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Pricing Details',
            icon: Icons.attach_money_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Base Price (₹)',
                controller: _basePriceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.currency_rupee_rounded,
                isRequired: true,
              ),
              CustomTextFormField(
                label: 'Selling Price (₹)',
                controller: _sellingPriceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.currency_rupee_rounded,
              ),
              CustomTextFormField(
                label: 'Cost Price (₹)',
                controller: _costPriceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.currency_rupee_rounded,
              ),
              CustomTextFormField(
                label: 'Advance Required (₹)',
                controller: _advancePercentController,
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                label: 'Downpayment (₹)',
                controller: _downpaymentController,
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                label: 'Loan Eligibility Upto (₹)',
                controller: _loanEligibilityController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Price Components',
            icon: Icons.pie_chart_rounded,
          ),
          const SizedBox(height: 16),
          ..._priceComponents.asMap().entries.map((entry) {
            int index = entry.key;
            PriceDistributionModel component = entry.value;
            return _buildPriceComponentCard(index, component, coloums);
          }).toList(),
          CustomActionButton(
            text: 'Add Price Component',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _priceComponents.add(PriceDistributionModel(
                  title: '',
                  amount: 0,
                  gstPercent: 18,
                  cgstPercent: 9,
                  sgstPercent: 9,
                ));
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildEligibilityTab(BuildContext context, int coloums) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Eligibility Criteria',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Age Limit',
                controller: _ageLimitController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\-\s]')),
                  LengthLimitingTextInputFormatter(2)
                ],
                hintText: 'e.g : 18 - 60 years',
              ),
              CustomTextFormField(
                label: 'Minimum Income Required Monthly',
                controller: _minIncomeController,
                hintText: 'e.g : ₹35,000 monthly',
              ),
              CustomTextFormField(
                label: 'Qualification Required',
                controller: _qualificationController,
                hintText: 'e.g : Any qualification',
              ),
              CustomTextFormField(
                label: 'Experience Required',
                controller: _experienceController,
                hintText: ' 2+ years in OT',
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Required Documents',
            icon: Icons.description_rounded,
          ),
          const SizedBox(height: 16),
          ..._documents.asMap().entries.map((entry) {
            int index = entry.key;
            DocumentsRequired doc = entry.value;
            return _buildDocumentCard(index, doc, coloums);
          }).toList(),
          CustomActionButton(
            text: 'Add Document',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _documents.add(DocumentsRequired(docName: '', mandatory: true));
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Requirements',
            icon: Icons.checklist_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              // EnhancedSwitchTile(
              //   label: 'Requires Agreement',
              //   icon: Icons.gavel_rounded,
              //   value: _requiresAgreement,
              //   onChanged: (val) => setState(() => _requiresAgreement = val),
              // ),
              // EnhancedSwitchTile(
              //   label: 'Job Assistance',
              //   icon: Icons.work_rounded,
              //   value: _jobAssistance,
              //   onChanged: (val) => setState(() => _jobAssistance = val),
              // ),
              // EnhancedSwitchTile(
              //   label: 'Interview Preparation',
              //   icon: Icons.video_call_rounded,
              //   value: _interviewPreparation,
              //   onChanged: (val) => setState(() => _interviewPreparation = val),
              // ),
              EnhancedSwitchTile(
                label: 'Is Refundable',
                icon: Icons.refresh_rounded,
                value: _isRefundable,
                onChanged: (val) => setState(() => _isRefundable = val),
              ),
            ],
          ),
          if (_isRefundable) ...[
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Refund Policy',
              controller: _refundPolicyController,
              maxLines: 3,
              hintText: 'Describe refund policy details...',
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDetailsTab(BuildContext context, int coloums) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category-specific details
          // if (_selectedCategory == 'TRAVEL') ...[
          const SectionTitle(
            title: 'Travel Details',
            icon: Icons.flight_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomDropdownField(
                label: 'Travel Type',
                value: _selectedTravelType,
                items: const [
                  'TOUR',
                  'CRUISE',
                  'ADVENTURE',
                  'BUSINESS',
                  'FAMILY'
                ],
                onChanged: (value) =>
                    setState(() => _selectedTravelType = value),
              ),
              CustomTextFormField(
                label: 'Duration',
                controller: _durationController,
                hintText: 'e.g., 10D/9N',
              ),
              CustomDropdownField(
                label: 'Visa Type',
                value: _selectedVisaType,
                items: const [
                  'Tourist Visa',
                  'Business Visa',
                  'Student Visa',
                  'Work Visa',
                  'Transit Visa'
                ],
                onChanged: (value) => setState(() => _selectedVisaType = value),
              ),
            ],
          ),

          const SizedBox(height: 20),
          // ] else if (_selectedCategory == 'EDUCATION') ...[
          const SectionTitle(
            title: 'Education Details',
            icon: Icons.school_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Course Duration',
                controller: _courseDurationController,
                hintText: 'e.g., 2 Years',
              ),
              CustomDropdownField(
                label: 'Course Level',
                value: _selectedCourseLevel,
                items: configController.configData.value.program
                        ?.map((e) => e.name ?? "")
                        .toList() ??
                    [],
                onChanged: (value) =>
                    setState(() => _selectedCourseLevel = value),
              ),
              CustomTextFormField(
                label: 'Institution Name',
                controller: _institutionNameController,
              ),
              CustomTextFormField(
                label: 'Mode of Study',
                controller: _modelController,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // ] else if (_selectedCategory == 'VEHICLE') ...[
          const SectionTitle(
            title: 'Vehicle Details',
            icon: Icons.directions_car_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Brand',
                controller: _brandController,
              ),
              CustomTextFormField(
                label: 'Model',
                controller: _modelController,
              ),
              CustomDropdownField(
                label: 'Fuel Type',
                value: _selectedFuelType,
                items: const ['Petrol', 'Diesel', 'Electric', 'Hybrid', 'CNG'],
                onChanged: (value) => setState(() => _selectedFuelType = value),
              ),
              CustomDropdownField(
                label: 'Transmission',
                value: _selectedTransmission,
                items: const ['Automatic', 'Manual'],
                onChanged: (value) =>
                    setState(() => _selectedTransmission = value),
              ),
              CustomTextFormField(
                label: 'Registration Date/Year',
                controller: _registrationYearController,
              ),
              CustomTextFormField(
                label: 'KMs Driven',
                controller: _kmsDrivenController,
              ),
              CustomDateField(
                label: 'Insurance Valid Till Date/Year',
                controller: _insuranceValidTillController,
                endDate: DateTime.now(),
                onChanged: (formattedDate) {
                  _insuranceValidTillController.text = formattedDate;
                },
              ),
            ],
          ),
          // ] else if (_selectedCategory == 'REAL_ESTATE') ...[
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Property Details',
            icon: Icons.home_work_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomDropdownField(
                label: 'Property Type',
                value: _selectedPropertyType,
                items: const [
                  'Residential',
                  'Commercial',
                  'Plot',
                  'Villa',
                  'Apartment'
                ],
                onChanged: (value) =>
                    setState(() => _selectedPropertyType = value),
              ),
              CustomTextFormField(
                label: 'Size',
                controller: _sizeController,
                hintText: 'e.g., 1500 sq ft',
              ),
              CustomTextFormField(
                label: 'BHK',
                controller: _bhkController,
                hintText: 'e.g., 3 BHK',
              ),
              CustomTextFormField(
                label: 'Location',
                controller: _locationController,
              ),
              CustomTextFormField(
                label: 'Possession Time',
                controller: _possessionTimeController,
                hintText: 'e.g., 2026 Q2',
              ),
              CustomDropdownField(
                label: 'Furnishing Status',
                value: _selectedFurnishingStatus,
                items: const [
                  'Fully Furnished',
                  'Semi-Furnished',
                  'Unfurnished'
                ],
                onChanged: (value) =>
                    setState(() => _selectedFurnishingStatus = value),
              ),
            ],
          ),
          // ],

          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Location',
            icon: Icons.location_on_rounded,
          ),
          const SizedBox(height: 16),

          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomDropdownField(
                label: 'Country',
                value: _selectedCountry,
                items: configController.configData.value.country
                        ?.map((e) => e.name ?? "")
                        .toList() ??
                    [],
                onChanged: (value) => setState(() => _selectedCountry = value),
              ),
              CustomTextFormField(
                label: 'City',
                controller: _selectedStateController,
                onChanged: (value) =>
                    setState(() => _selectedStateController?.text = value),
              ),
              CustomTextFormField(
                label: 'City',
                controller: TextEditingController(text: _selectedCity),
                onChanged: (value) => setState(() => _selectedCity = value),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Validity & Processing Time',
            icon: Icons.list_alt_rounded,
          ),

          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Validity / Duration',
                controller: _validityController,
              ),
              CustomTextFormField(
                label: 'Processing Time /Paperwork Time',
                controller: _processingTimeController,
                hintText: 'e.g., 7-14 working days',
              ),
            ],
          ),
          const SizedBox(height: 32),

          const SectionTitle(
            title: 'Inclusions & Exclusions',
            icon: Icons.list_alt_rounded,
          ),

          const SizedBox(height: 16),
          CustomDropdownWithText(
            options: const [
              'Accommodation',
              'Meals',
              'Sightseeing',
              'Transport',
              'Guide Services',
              'Travel Insurance',
              'Flight Tickets',
              'Visa Assistance',
              'Other'
            ],
            label: 'Inclusions',
            selectedValues: _inclusions,
            onChanged: (list) {
              setState(
                () {
                  _inclusions = list;
                },
              );
            },
          ),
          const SizedBox(height: 16),

          CustomDropdownWithText(
            options: const [
              'Accommodation',
              'Meals',
              'Sightseeing',
              'Transport',
              'Guide Services',
              'Travel Insurance',
              'Flight Tickets',
              'Visa Assistance',
              'Other'
            ],
            label: 'Exclusions',
            selectedValues: _exclusions,
            onChanged: (list) {
              setState(
                () {
                  _exclusions = list;
                },
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProviderTab(BuildContext context, int coloums) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Provider Information',
            icon: Icons.business_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              CustomTextFormField(
                label: 'Provider Name',
                controller: _providerNameController,
                // isRequired: true,
              ),
              CustomTextFormField(
                label: 'Contact Number',
                controller: _providerContactController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              CustomTextFormField(
                label: 'Email',
                controller: _providerEmailController,
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Address',
            controller: _providerAddressController,
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Support & Warranty',
            icon: Icons.support_agent_rounded,
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            columns: coloums,
            children: [
              EnhancedSwitchTile(
                margin: EdgeInsets.only(top: 10),
                label: 'Support Available',
                icon: Icons.headset_mic_rounded,
                value: _supportAvailable,
                onChanged: (val) => setState(() => _supportAvailable = val),
              ),
              if (_supportAvailable)
                CustomTextFormField(
                  label: 'Support Duration',
                  controller: _supportDurationController,
                  hintText: 'e.g., 6 Months',
                ),
              CustomTextFormField(
                label: 'Warranty Information',
                controller: _warrantyInfoController,
                maxLines: 2,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildOtherTab(BuildContext context, int coloums) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Process Steps',
            icon: Icons.label_rounded,
          ),
          const SizedBox(height: 16),
          CustomDropdownWithText(
            options: const [
              'Enquiry Received',
              'Document Collection',
              'Processing',
              'Approval',
              'Payment',
            ],
            selectedValues: _stepList,
            onChanged: (list) {
              setState(
                () {
                  _stepList = list;
                },
              );
            },
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Tags & Classification',
            icon: Icons.label_rounded,
          ),
          const SizedBox(height: 16),
          CustomDropdownWithText(
            options: const [
              'Popular',
              'Seasonal',
              'New Arrival',
              'Limited Edition',
              'Best Seller',
            ],
            label: 'Tags',
            selectedValues: _tags,
            onChanged: (list) {
              setState(
                () {
                  _tags = list;
                },
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Terms & Conditions',
            icon: Icons.gavel_rounded,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Terms & Conditions',
            controller: _termsController,
            maxLines: 5,
            hintText: 'Enter terms and conditions...',
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Additional Notes',
            controller: _notesController,
            maxLines: 3,
            hintText: 'Any additional information...',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPriceComponentCard(
      int index, PriceDistributionModel component, int coloums) {
    final TextEditingController titleController =
        TextEditingController(text: component.title);
    final TextEditingController amountController =
        TextEditingController(text: component.amount?.toString() ?? '0');
    final TextEditingController gstController =
        TextEditingController(text: component.gstPercent?.toString() ?? '18');
    final TextEditingController cgstController =
        TextEditingController(text: component.cgstPercent?.toString() ?? '9');
    final TextEditingController sgstController =
        TextEditingController(text: component.sgstPercent?.toString() ?? '9');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Price Component',
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () {
                    setState(() {
                      _priceComponents.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            ResponsiveGrid(
              columns: coloums,
              children: [
                CustomTextFormField(
                  label: 'Component Title',
                  controller: titleController,
                  onChanged: (value) => _priceComponents[index].title = value,
                ),
                CustomTextFormField(
                  label: 'Amount',
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  // suffixText: '%',
                  onChanged: (value) =>
                      _priceComponents[index].amount = double.tryParse(value),
                ),
                CustomTextFormField(
                  label: 'GST %',
                  controller: gstController,
                  keyboardType: TextInputType.number,
                  // suffixText: '%',
                  onChanged: (value) => _priceComponents[index].gstPercent =
                      double.tryParse(value),
                ),
                CustomTextFormField(
                  label: 'CGST %',
                  controller: cgstController,
                  keyboardType: TextInputType.number,
                  // suffixText: '%',
                  onChanged: (value) => _priceComponents[index].cgstPercent =
                      double.tryParse(value),
                ),
                CustomTextFormField(
                  label: 'SGST %',
                  controller: sgstController,
                  keyboardType: TextInputType.number,
                  // suffixText: '%',
                  onChanged: (value) => _priceComponents[index].sgstPercent =
                      double.tryParse(value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(int index, DocumentsRequired doc, int coloums) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Document',
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () {
                    setState(() {
                      _documents.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            ResponsiveGrid(
              columns: coloums,
              children: [
                CustomTextFormField(
                  label: 'Document Name',
                  value: doc.docName, // ✅ FIX
                  onChanged: (value) {
                    _documents[index].docName = value;
                  },
                ),
                Flexible(
                  child: EnhancedSwitchTile(
                    margin: EdgeInsets.only(top: 20),
                    label: 'Mandatory',
                    value: doc.mandatory ?? true,
                    onChanged: (value) {
                      setState(() {
                        _documents[index].mandatory = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        name: _nameController.text.trim(),
        code: _codeController.text.trim(),
        category: _selectedCategory,
        subCategory: _selectedSubCategory,
        status: _selectedStatus,
        description: _descriptionController.text.trim(),
        shortDescription: _shortDescriptionController.text.trim(),
        basePrice: double.tryParse(_basePriceController.text.trim()),
        sellingPrice: double.tryParse(_sellingPriceController.text.trim()),
        costPrice: double.tryParse(_costPriceController.text.trim()),
        advanceRequiredPercent:
            double.tryParse(_advancePercentController.text.trim()),
        priceComponents: _priceComponents,
        downpayment: double.tryParse(_downpaymentController.text.trim()),
        loanEligibility:
            double.tryParse(_loanEligibilityController.text.trim()),
        documentsRequired: _documents,
        validity: _validityController.text.trim(),
        processingTime: _processingTimeController.text.trim(),
        serviceMode: _selectedServiceMode,
        ageLimit: _ageLimitController.text.trim(),
        minIncomeRequired: _minIncomeController.text.trim(),
        qualificationRequired: _qualificationController.text.trim(),
        experienceRequired: _experienceController.text.trim(),
        requiresAgreement: _requiresAgreement,
        isRefundable: _isRefundable,
        refundPolicy: _refundPolicyController.text.trim(),
        tags: _tags,
        notes: _notesController.text.trim(),
        country: _selectedCountry,
        city: _selectedCity,
        state: _selectedStateController?.text,
        travelType: _selectedTravelType,
        duration: _durationController.text.trim(),
        inclusions: _inclusions,
        exclusions: _exclusions,
        visaType: _selectedVisaType,
        jobAssistance: _jobAssistance,
        interviewPreparation: _interviewPreparation,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        fuelType: _selectedFuelType,
        transmission: _selectedTransmission,
        registrationYear: _registrationYearController.text.trim(),
        kmsDriven: _kmsDrivenController.text.trim(),
        insuranceValidTill: _insuranceValidTillController.text.trim(),
        courseDuration: _courseDurationController.text.trim(),
        courseLevel: _selectedCourseLevel,
        institutionName: _institutionNameController.text.trim(),
        propertyType: _selectedPropertyType,
        size: _sizeController.text.trim(),
        bhk: _bhkController.text.trim(),
        location: _locationController.text.trim(),
        possessionTime: _possessionTimeController.text.trim(),
        furnishingStatus: _selectedFurnishingStatus,
        termsAndConditions: _termsController.text.trim(),
        supportAvailable: _supportAvailable,
        supportDuration: _supportDurationController.text.trim(),
        warrantyInfo: _warrantyInfoController.text.trim(),
        providerDetails: ProductProviderDeatilsModel(
          name: _providerNameController.text.trim(),
          contact: _providerContactController.text.trim(),
          email: _providerEmailController.text.trim(),
          address: _providerAddressController.text.trim(),
        ),
        stepList: _stepList,
      );

      // Show loading
      showLoaderDialog(context);
      try {
        if (widget.productToEdit != null) {
          await productController.editProduct(
            context: context,
            product: product,
            productId: widget.productToEdit!.id!,
          );
        } else if (productid != "") {
          await productController.editProduct(
            context: context,
            product: product,
            productId: productid,
          );
        } else {
          var result = await productController.createProd(
            product: product,
            context: context,
          );
          productid = result;
        }
      } catch (e) {
      } finally {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _shortDescriptionController.dispose();
    _basePriceController.dispose();
    _sellingPriceController.dispose();
    _costPriceController.dispose();
    _advancePercentController.dispose();
    _validityController.dispose();
    _processingTimeController.dispose();
    _termsController.dispose();
    _notesController.dispose();
    _refundPolicyController.dispose();
    _warrantyInfoController.dispose();
    _supportDurationController.dispose();
    _providerNameController.dispose();
    _providerContactController.dispose();
    _providerEmailController.dispose();
    _providerAddressController.dispose();
    _durationController.dispose();
    _courseDurationController.dispose();
    _institutionNameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _registrationYearController.dispose();
    _kmsDrivenController.dispose();
    _insuranceValidTillController.dispose();
    _sizeController.dispose();
    _bhkController.dispose();
    _locationController.dispose();
    _possessionTimeController.dispose();
    _ageLimitController.dispose();
    _minIncomeController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
