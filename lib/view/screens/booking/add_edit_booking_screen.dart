// booking_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/booking/booking_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/model/booking_model/co_applicant_model.dart';
import 'package:overseas_front_end/model/booking_model/price_component_model.dart';
import 'package:overseas_front_end/model/booking_model/transaction_model.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/model/product/product_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../controller/config/config_controller.dart';
import '../../../model/booking_model/booking_applied_offer_model.dart';
import '../../../model/booking_model/payment_shedule_model.dart';

class BookingScreen extends StatefulWidget {
  final ProductModel product;
  final BookingModel? bookingToEdit;
  final bool isViewMode;

  const BookingScreen({
    super.key,
    required this.product,
    this.bookingToEdit,
    this.isViewMode = false,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final leadController = Get.find<LeadController>();
  final bookingController = Get.find<BookingController>();
  final _formKey = GlobalKey<FormState>();

  static const List<Tab> _tabs = [
    Tab(text: 'Basic Info', icon: Icon(Icons.info_outline, size: 16)),
    Tab(text: 'Pricing', icon: Icon(Icons.attach_money, size: 16)),
    Tab(text: 'Payments', icon: Icon(Icons.payment, size: 16)),
    Tab(text: 'Details', icon: Icon(Icons.details, size: 16)),
    Tab(text: 'Summary', icon: Icon(Icons.summarize, size: 16)),
  ];

  // Customer Search
  final _customerSearchController = TextEditingController();
  bool _isSearching = false;
  String? _selectedCustomerId;

  // Basic Controllers
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerAddressController = TextEditingController();
  final _bookingDateController = TextEditingController();
  final _expectedClosureDateController = TextEditingController();
  final _notesController = TextEditingController();

  final _loanAmountController = TextEditingController();

  // Transaction Controllers
  final _paidAmountController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _transactionIdController = TextEditingController();
  final _transactionRemarksController = TextEditingController();

  // Travel Details Controllers
  final _courseNameController = TextEditingController();
  final _institutionNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _visaTypeController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _noOfTravellersController = TextEditingController();

  // Dynamic Lists
  final List<PriceComponentHelper> _priceComponents = [];
  final List<PaymentScheduleHelper> _paymentSchedules = [];
  final List<CoApplicantHelper> _coApplicants = [];
  String? _selectedStatus = "PROCESSING";

  BookingModel _booking = BookingModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _initializeBooking();
  }

  void _selectCustomer(LeadModel customer) {
    setState(() {
      _selectedCustomerId = customer.id;
      _customerNameController.text = customer.name ?? '';
      _customerPhoneController.text = customer.phone ?? '';
      _customerAddressController.text = customer.address ?? '';
      _customerSearchController.clear();
      _isSearching = false;
    });
  }

  void _initializeBooking() {
    if (widget.bookingToEdit != null) {
      _booking = widget.bookingToEdit!;
      _populateFromBooking();
    } else {
      _booking = _createNewBooking();
      _populateFromProduct();
    }
  }

  BookingModel _createNewBooking() {
    return BookingModel(
      productId: widget.product.id ?? '',
      productName: widget.product.name ?? '',
      bookingDate: DateTime.now(),
      expectedClosureDate: DateTime.now().add(const Duration(days: 20)),
      totalAmount: widget.product.sellingPrice ?? 0,
      gstPercentage: 18,
      cgstPercentage: 9,
      sgstPercentage: 9,
      discountAmount: 0,
      noOfTravellers: 1,
      institutionName: '',
      countryApplyingFor: '',
      visaType: '',
      destination: '',
      transaction: TransactionModel(
        paidAmount: null,
        paymentMethod: '',
        transactionId: '',
        remarks: '',
      ),
    );
  }

  void _populateFromProduct() {
    _bookingDateController.text = formatDatetoString(DateTime.now()) ?? '';
    _expectedClosureDateController.text =
        formatDatetoString(DateTime.now().add(const Duration(days: 20))) ?? '';
    _noOfTravellersController.text = '1';
    _loanAmountController.text = '';
    _paidAmountController.text = '';

    _institutionNameController.text = widget.product.institutionName ?? '';
    _countryController.text = widget.product.country ?? '';
    _visaTypeController.text = widget.product.visaType ?? '';
    _destinationController.text = widget.product.location ?? '';

    // Add default price components from product
    if (widget.product.priceComponents != null) {
      for (var component in widget.product.priceComponents!) {
        _priceComponents.add(PriceComponentHelper(
          title: component.title,
          amount: component.amount,
          gstPercent: component.gstPercent,
          cgstPercent: component.cgstPercent,
          sgstPercent: component.sgstPercent,
        ));
      }
    }
  }

  void _populateFromBooking() {
    _selectedCustomerId = _booking.customerId;
    _customerNameController.text = _booking.customerName ?? '';
    _customerPhoneController.text = _booking.customerPhone ?? '';
    _customerAddressController.text = _booking.customerAddress ?? '';
    _bookingDateController.text =
        formatDatetoString(_booking.bookingDate) ?? '';
    _expectedClosureDateController.text =
        formatDatetoString(_booking.expectedClosureDate) ?? '';
    _selectedStatus = _booking.status ?? '';
    _loanAmountController.text = (_booking.loanAmountRequested ?? 0).toString();
    _notesController.text = _booking.notes ?? '';

    _courseNameController.text = _booking.courseName ?? '';
    _institutionNameController.text = _booking.institutionName ?? '';
    _countryController.text = _booking.countryApplyingFor ?? '';
    _visaTypeController.text = _booking.visaType ?? '';
    _originController.text = _booking.origin ?? '';
    _destinationController.text = _booking.destination ?? '';
    _returnDateController.text = formatDatetoString(_booking.returnDate) ?? '';
    _noOfTravellersController.text = (_booking.noOfTravellers ?? 1).toString();

    _paidAmountController.text =
        (_booking.transaction?.paidAmount ?? 0).toString();
    _paymentMethodController.text = _booking.transaction?.paymentMethod ?? '';
    _transactionIdController.text = _booking.transaction?.transactionId ?? '';
    _transactionRemarksController.text = _booking.transaction?.remarks ?? '';

    // Populate price components with offers
    if (_booking.priceComponents != null) {
      for (var comp in _booking.priceComponents!) {
        final componentHelper = PriceComponentHelper(
          title: comp.title,
          amount: comp.amount,
          gstPercent: comp.gstPercent,
          cgstPercent: comp.cgstPercent,
          sgstPercent: comp.sgstPercent,
        );

        // Add offers for this component
        if (comp.offersApplied != null) {
          for (var offer in comp.offersApplied!) {
            componentHelper.offers.add(OfferHelper(
              offerName: offer.offerName,
              discountAmount: offer.discountAmount,
            ));
          }
        }

        _priceComponents.add(componentHelper);
      }
    }

    if (_booking.paymentSchedule != null) {
      for (var payment in _booking.paymentSchedule!) {
        _paymentSchedules.add(PaymentScheduleHelper(
          paymentType: payment.paymentType,
          dueDate: payment.dueDate,
          amount: payment.amount,
        ));
      }
    }

    if (_booking.coApplicantList != null) {
      for (var applicant in _booking.coApplicantList!) {
        _coApplicants.add(CoApplicantHelper(
          name: applicant.name,
          phone: applicant.phone,
          dob: applicant.dob,
          address: applicant.address,
          email: applicant.email,
        ));
      }
    }
  }

  double _calculateComponentSubtotal(PriceComponentHelper component) {
    final amount = double.tryParse(component.amountController.text) ?? 0;
    double totalDiscount = 0;

    for (var offer in component.offers) {
      if (offer.isPercentage) {
        final percent = double.tryParse(offer.discountController.text) ?? 0;
        totalDiscount += (amount * percent) / 100;
      } else {
        totalDiscount += double.tryParse(offer.discountController.text) ?? 0;
      }
    }
    return amount - totalDiscount;
  }

  double _calculateComponentGST(PriceComponentHelper component) {
    final subtotal = _calculateComponentSubtotal(component);
    final gstPercent = double.tryParse(component.gstController.text) ?? 0;
    return (subtotal * gstPercent) / 100;
  }

  double _calculateComponentCGST(PriceComponentHelper component) {
    final subtotal = _calculateComponentSubtotal(component);
    final cgstPercent = double.tryParse(component.cgstController.text) ?? 0;
    return (subtotal * cgstPercent) / 100;
  }

  double _calculateComponentSGST(PriceComponentHelper component) {
    final subtotal = _calculateComponentSubtotal(component);
    final sgstPercent = double.tryParse(component.sgstController.text) ?? 0;
    return (subtotal * sgstPercent) / 100;
  }

  double _calculateTotalAmount() {
    double total = 0;
    for (var component in _priceComponents) {
      total += double.tryParse(component.amountController.text) ?? 0;
    }
    return total;
  }

  double _calculateTotalDiscount() {
    double total = 0;
    for (var component in _priceComponents) {
      final amount = double.tryParse(component.amountController.text) ?? 0;
      for (var offer in component.offers) {
        if (offer.isPercentage) {
          final percent = double.tryParse(offer.discountController.text) ?? 0;
          total += (amount * percent) / 100;
        } else {
          total += double.tryParse(offer.discountController.text) ?? 0;
        }
      }
    }
    return total;
  }

  double _calculateTotalGST() {
    double total = 0;
    for (var component in _priceComponents) {
      total += _calculateComponentGST(component);
    }
    return total;
  }

  double _calculateTotalCGST() {
    double total = 0;
    for (var component in _priceComponents) {
      total += _calculateComponentCGST(component);
    }
    return total;
  }

  double _calculateTotalSGST() {
    double total = 0;
    for (var component in _priceComponents) {
      total += _calculateComponentSGST(component);
    }
    return total;
  }

  double _calculateGrandTotal() {
    double total = 0;
    for (var component in _priceComponents) {
      final subtotal = _calculateComponentSubtotal(component);
      final gst = _calculateComponentGST(component);
      final cgst = _calculateComponentCGST(component);
      final sgst = _calculateComponentSGST(component);
      total += subtotal + gst + cgst + sgst;
    }
    return total;
  }

  void _recalculate() {
    setState(() {});
  }

  // Add/Remove Methods
  void _addPriceComponent() {
    setState(() {
      _priceComponents.add(PriceComponentHelper());
    });
  }

  void _removePriceComponent(int index) {
    setState(() {
      _priceComponents.removeAt(index);
      _recalculate();
    });
  }

  void _addOfferToComponent(PriceComponentHelper component) {
    setState(() {
      component.offers.add(OfferHelper());
    });
  }

  void _removeOfferFromComponent(
      PriceComponentHelper component, int offerIndex) {
    setState(() {
      component.offers.removeAt(offerIndex);
      _recalculate();
    });
  }

  void _addPaymentSchedule() {
    setState(() {
      _paymentSchedules.add(PaymentScheduleHelper());
    });
  }

  void _removePaymentSchedule(int index) {
    setState(() {
      _paymentSchedules.removeAt(index);
    });
  }

  void _addCoApplicant() {
    setState(() {
      _coApplicants.add(CoApplicantHelper());
    });
  }

  void _removeCoApplicant(int index) {
    setState(() {
      _coApplicants.removeAt(index);
    });
  }

  Future<void> _saveBooking() async {
    if (!_formKey.currentState!.validate()) return;

    // Build price components with their offers
    final List<PriceComponentModel> priceComponentsData =
        _priceComponents.map((comp) {
      final componentAmount = double.tryParse(comp.amountController.text) ?? 0;

      final offersData = comp.offers.map((offer) {
        double amount;

        if (offer.isPercentage) {
          final percent = double.tryParse(offer.discountController.text) ?? 0;
          amount = (componentAmount * percent) / 100;
        } else {
          amount = double.tryParse(offer.discountController.text) ?? 0;
        }

        return BookingAppliedOfferModel(
          offerName: offer.offerNameController.text,
          discountAmount: amount,
        );
      }).toList();

      return PriceComponentModel(
        title: comp.titleController.text,
        amount: componentAmount,
        gstPercent: double.tryParse(comp.gstController.text) ?? 18,
        cgstPercent: double.tryParse(comp.cgstController.text) ?? 9,
        sgstPercent: double.tryParse(comp.sgstController.text) ?? 9,
        offersApplied: offersData,
      );
    }).toList();

    final bookingData = BookingModel(
      customerId: _selectedCustomerId ?? "",
      customerName: _customerNameController.text,
      customerPhone: _customerPhoneController.text,
      officerId: Get.find<LoginController>().officer.value?.id ?? "",
      customerAddress: _customerAddressController.text,
      status: _selectedStatus ?? "",
      productId: widget.product.id,
      productName: widget.product.name,
      bookingDate: formatStringToDate(_bookingDateController.text),
      // expectedClosureDate:
      //     formatStringToDate(_expectedClosureDateController.text),
      totalAmount: _calculateTotalAmount(),
      sgstAmount: _calculateTotalSGST(),
      cgstAmount: _calculateTotalCGST(),
      gstAmount: _calculateTotalGST(),
      grandTotal: _calculateGrandTotal(),
      discountAmount: _calculateTotalDiscount(),
      transaction: TransactionModel(
        paidAmount: double.tryParse(_paidAmountController.text) ?? 0,
        paymentMethod: _paymentMethodController.text,
        transactionId: _transactionIdController.text,
        remarks: _transactionRemarksController.text,
      ),
      priceComponents: priceComponentsData,
      paymentSchedule: _paymentSchedules.map((schedule) {
        return PaymentScheduleModel(
          paymentType: schedule.paymentTypeController.text,
          dueDate: formatStringToDate(schedule.dueDateController.text),
          amount: double.tryParse(schedule.amountController.text) ?? 0,
        );
      }).toList(),
      loanAmountRequested: double.tryParse(_loanAmountController.text) ?? 0,
      notes: _notesController.text,
      courseName: _courseNameController.text,
      institutionName: _institutionNameController.text,
      countryApplyingFor: _countryController.text,
      visaType: _visaTypeController.text,
      origin: _originController.text,
      destination: _destinationController.text,
      returnDate: formatStringToDate(_returnDateController.text),
      noOfTravellers: int.tryParse(_noOfTravellersController.text) ?? 1,
      coApplicantList: _coApplicants.map((applicant) {
        return CoApplicantModel(
          name: applicant.nameController.text,
          phone: applicant.phoneController.text,
          dob: formatStringToDate(applicant.dobController.text),
          address: applicant.addressController.text,
          email: applicant.emailController.text,
        );
      }).toList(),
    );
    if (widget.isViewMode) {
      showLoaderDialog(context);
      await bookingController.updateBooking(
        context,
        bookingData,
        widget.bookingToEdit?.id ?? "",
      );
    } else {
      showLoaderDialog(context);
      await Get.find<BookingController>().createBooking(
        bookingData,
        context,
      );
    }
  }

  // UI Builders
  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('Customer Information', Icons.person_outline),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isViewMode) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customerSearchController,
                          decoration: InputDecoration(
                            labelText: 'Search Customer',
                            hintText: 'Search by name or phone',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                _isSearching = true;
                                setState(() {});
                                leadController.searchLead(
                                    query: _customerSearchController.text);
                              },
                            ),
                          ),
                          // onChanged: (value) {
                          //   leadController.searchLead(query: value);
                          // },
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.person_add, color: Colors.blue),
                        tooltip: 'Create New Customer',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Obx(() {
                    if (leadController.searchResults.isNotEmpty) {
                      if (_isSearching) {
                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              constraints: const BoxConstraints(maxHeight: 200),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: leadController.searchResults.length,
                                itemBuilder: (context, index) {
                                  final customer =
                                      leadController.searchResults[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.primaryColor
                                          .withOpacity(0.1),
                                      child: Icon(
                                        Icons.person,
                                        size: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    title: Text(
                                      customer.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(customer.phone ?? ''),
                                    trailing: const Icon(Icons.chevron_right,
                                        size: 20),
                                    onTap: () => _selectCustomer(customer),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  }),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                ],

                // Customer form fields
                CustomTextFormField(
                  controller: _customerNameController,
                  label: 'Customer Name',
                  isRequired: true,
                  readOnly: widget.isViewMode,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _customerPhoneController,
                  label: 'Customer Phone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  isRequired: true,
                  readOnly: widget.isViewMode,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _customerAddressController,
                  label: 'Customer Address',
                  maxLines: 2,
                  readOnly: widget.isViewMode,
                  prefixIcon: Icons.location_on_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Booking Details', Icons.calendar_today_outlined),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              children: [
                CustomDateField(
                  controller: _bookingDateController,
                  label: 'Booking For ',
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                CustomDropdownField(
                  isRequired: true,
                  label: "Status",
                  value: _selectedStatus,
                  items: Get.find<ConfigController>()
                          .configData
                          .value
                          .bookingStatus
                          ?.map((e) => e.name ?? "")
                          .toList() ??
                      [],
                  onChanged: (value) {
                    _selectedStatus = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                // CustomDateField(
                //   controller: _expectedClosureDateController,
                //   label: 'Expected Closure Date',
                //   isRequired: true,
                // ),
                // const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _notesController,
                  label: 'Notes / Special Requirements',
                  maxLines: 3,
                  readOnly: widget.isViewMode,
                  prefixIcon: Icons.note_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Price Components', Icons.receipt_long_outlined),
          const SizedBox(height: 16),
          ..._priceComponents.asMap().entries.map((entry) {
            return _buildPriceComponentCard(entry.key, entry.value);
          }).toList(),
          if (!widget.isViewMode) ...[
            _buildAddButton('Add Price Component', _addPriceComponent),
            const SizedBox(height: 24),
          ],
          _buildFinancialSummaryCard(),
          const SizedBox(height: 24),
          _buildSectionTitle(
              'Loan Information', Icons.account_balance_outlined),
          const SizedBox(height: 16),
          _buildCard(
            child: CustomTextFormField(
              controller: _loanAmountController,
              label: 'Loan Amount Requested (₹)',
              keyboardType: TextInputType.number,
              readOnly: widget.isViewMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    final grandTotal = _calculateGrandTotal();
    double totalScheduled = 0;
    for (var schedule in _paymentSchedules) {
      totalScheduled += double.tryParse(schedule.amountController.text) ?? 0;
    }

    // Add initial paid amount to total scheduled
    final initialPaid = double.tryParse(_paidAmountController.text) ?? 0;
    final totalPaid = totalScheduled;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Payment Schedule', Icons.schedule_outlined),
          const SizedBox(height: 16),
          ..._paymentSchedules.asMap().entries.map((entry) {
            return _buildPaymentScheduleCard(entry.key, entry.value);
          }).toList(),
          if (!widget.isViewMode) ...[
            _buildAddButton('Add Payment Schedule', _addPaymentSchedule),
            const SizedBox(height: 24),
          ],
          _buildPaymentSummaryCard(grandTotal, totalScheduled, totalPaid),
          const SizedBox(height: 24),
          _buildSectionTitle('Initial Transaction', Icons.receipt_outlined),
          const SizedBox(height: 16),
          _buildCard(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _paidAmountController,
                  label: 'Paid Amount (₹)',
                  keyboardType: TextInputType.number,
                  readOnly: widget.isViewMode,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _paymentMethodController,
                  label: 'Payment Method',
                  readOnly: widget.isViewMode,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _transactionIdController,
                  label: 'Transaction ID',
                  readOnly: widget.isViewMode,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _transactionRemarksController,
                  label: 'Remarks',
                  maxLines: 2,
                  readOnly: widget.isViewMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Travel/Education Details', Icons.flight_outlined),
          const SizedBox(height: 16),
          _buildCard(
            child: LayoutBuilder(builder: (context, constraints) {
              return ResponsiveGrid(
                columns: constraints.maxWidth > 600 ? 2 : 1,
                children: [
                  CustomTextFormField(
                    controller: _courseNameController,
                    label: 'Course Name',
                    readOnly: widget.isViewMode,
                  ),
                  CustomTextFormField(
                    controller: _institutionNameController,
                    label: 'Institution Name',
                    readOnly: widget.isViewMode,
                  ),
                  CustomTextFormField(
                    controller: _countryController,
                    label: 'Country Applying For',
                    readOnly: widget.isViewMode,
                  ),
                  CustomTextFormField(
                    controller: _visaTypeController,
                    label: 'Visa Type',
                    readOnly: widget.isViewMode,
                  ),
                  CustomTextFormField(
                    controller: _originController,
                    label: 'Origin',
                    readOnly: widget.isViewMode,
                  ),
                  CustomTextFormField(
                    controller: _destinationController,
                    label: 'Destination',
                    readOnly: widget.isViewMode,
                  ),
                  CustomDateField(
                    controller: _returnDateController,
                    label: 'Return Date',
                    isRequired: false,
                    initialDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    focusDate: DateTime.now(),
                  ),
                  CustomTextFormField(
                    controller: _noOfTravellersController,
                    label: 'Number of Travellers',
                    keyboardType: TextInputType.number,
                    readOnly: widget.isViewMode,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Co-Applicants', Icons.group_outlined),
          const SizedBox(height: 16),
          ..._coApplicants.asMap().entries.map((entry) {
            return _buildCoApplicantCard(entry.key, entry.value);
          }).toList(),
          if (!widget.isViewMode)
            _buildAddButton('Add Co-Applicant', _addCoApplicant),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Booking Summary', Icons.summarize_outlined),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Customer Details',
            icon: Icons.person,
            children: [
              _buildInfoRow('Name', _customerNameController.text),
              _buildInfoRow('Phone', _customerPhoneController.text),
              _buildInfoRow('Address', _customerAddressController.text),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Product Details',
            icon: Icons.shopping_bag,
            children: [
              _buildInfoRow('Product', widget.product.name ?? ''),
              _buildInfoRow('Code', widget.product.code ?? ''),
              _buildInfoRow('Booking Date', _bookingDateController.text),
              _buildInfoRow(
                  'Closure Date', _expectedClosureDateController.text),
            ],
          ),
          const SizedBox(height: 16),
          _buildFinancialSummaryCard(),
        ],
      ),
    );
  }

  // Card Builders
  Widget _buildPriceComponentCard(int index, PriceComponentHelper component) {
    final componentSubtotal = _calculateComponentSubtotal(component);
    final componentGST = _calculateComponentGST(component);
    final componentCGST = _calculateComponentCGST(component);
    final componentSGST = _calculateComponentSGST(component);
    final componentTotal =
        componentSubtotal + componentGST + componentCGST + componentSGST;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Component ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (!widget.isViewMode)
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.red, size: 20),
                    onPressed: () => _removePriceComponent(index),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: component.titleController,
              label: 'Component Title',
              readOnly: widget.isViewMode,
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: component.amountController,
              label: 'Amount (₹)',
              keyboardType: TextInputType.number,
              readOnly: widget.isViewMode,
              onChanged: (_) => _recalculate(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: component.gstController,
                    label: 'GST %',
                    keyboardType: TextInputType.number,
                    readOnly: widget.isViewMode,
                    onChanged: (_) => _recalculate(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextFormField(
                    controller: component.cgstController,
                    label: 'CGST %',
                    keyboardType: TextInputType.number,
                    readOnly: widget.isViewMode,
                    onChanged: (_) => _recalculate(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextFormField(
                    controller: component.sgstController,
                    label: 'SGST %',
                    keyboardType: TextInputType.number,
                    readOnly: widget.isViewMode,
                    onChanged: (_) => _recalculate(),
                  ),
                ),
              ],
            ),

            // Offers Section
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_offer,
                        color: Colors.orange.shade700, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Offers (${component.offers.length})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.orange.shade900,
                      ),
                    ),
                  ],
                ),
                if (!widget.isViewMode)
                  TextButton.icon(
                    onPressed: () => _addOfferToComponent(component),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Offer'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange.shade700,
                    ),
                  ),
              ],
            ),

            // Offers List
            if (component.offers.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...component.offers.asMap().entries.map((offerEntry) {
                return _buildOfferCardInComponent(
                  component,
                  offerEntry.key,
                  offerEntry.value,
                );
              }).toList(),
            ],

            // Component Summary
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildComponentSummaryRow('Base Amount',
                      double.tryParse(component.amountController.text) ?? 0),
                  if (component.offers.isNotEmpty)
                    _buildComponentSummaryRow(
                        'Discount',
                        (double.tryParse(component.amountController.text) ??
                                0) -
                            componentSubtotal,
                        isNegative: true),
                  _buildComponentSummaryRow(
                      'After Discount', componentSubtotal),
                  _buildComponentSummaryRow('GST', componentGST),
                  _buildComponentSummaryRow('CGST', componentCGST),
                  _buildComponentSummaryRow('SGST', componentSGST),
                  const Divider(height: 16),
                  _buildComponentSummaryRow('Component Total', componentTotal,
                      isBold: true, color: Colors.green.shade700),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCardInComponent(
    PriceComponentHelper component,
    int offerIndex,
    OfferHelper offer,
  ) {
    final componentAmount =
        double.tryParse(component.amountController.text) ?? 0;
    double calculatedAmount = 0;

    if (offer.isPercentage) {
      final percent = double.tryParse(offer.discountController.text) ?? 0;
      calculatedAmount = (componentAmount * percent) / 100;
    } else {
      calculatedAmount = double.tryParse(offer.discountController.text) ?? 0;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Offer ${offerIndex + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade900,
                ),
              ),
              if (!widget.isViewMode)
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Colors.red,
                  onPressed: () =>
                      _removeOfferFromComponent(component, offerIndex),
                ),
            ],
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: offer.offerNameController,
            label: 'Offer Name',
            readOnly: widget.isViewMode,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (!widget.isViewMode)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Discount Type',
                      ),
                      SizedBox(height: 4),
                      DropdownButtonFormField<bool>(
                        value: offer.isPercentage,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: true, child: Text('%   Percentage')),
                          DropdownMenuItem(
                              value: false, child: Text('₹    Amount')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            offer.isPercentage = value ?? true;
                            _recalculate();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  controller: offer.discountController,
                  label: offer.isPercentage
                      ? 'Discount (%)'
                      : 'Discount Amount (₹)',
                  keyboardType: TextInputType.number,
                  readOnly: widget.isViewMode,
                  onChanged: (_) => _recalculate(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Discount Amount: ₹${calculatedAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentSummaryRow(
    String label,
    double amount, {
    bool isBold = false,
    bool isNegative = false,
    Color? color,
  }) {
    final displayAmount = isNegative ? -amount : amount;
    final textColor =
        color ?? (isNegative ? Colors.red.shade700 : Colors.grey.shade700);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 14 : 13,
              color: textColor,
            ),
          ),
          Text(
            '₹${displayAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 14 : 13,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentScheduleCard(int index, PaymentScheduleHelper schedule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (!widget.isViewMode)
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.red, size: 20),
                    onPressed: () => _removePaymentSchedule(index),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: schedule.paymentTypeController,
              label: 'Payment Type',
              readOnly: widget.isViewMode,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomDateField(
                    controller: schedule.dueDateController,
                    label: 'Due Date',
                    isRequired: true,
                    initialDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    focusDate: DateTime.now(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextFormField(
                    controller: schedule.amountController,
                    label: 'Amount (₹)',
                    keyboardType: TextInputType.number,
                    readOnly: widget.isViewMode,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoApplicantCard(int index, CoApplicantHelper applicant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Co-Applicant ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (!widget.isViewMode)
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red, size: 20),
                      onPressed: () => _removeCoApplicant(index),
                    ),
                ],
              ),
              LayoutBuilder(builder: (context, constraints) {
                return ResponsiveGrid(
                  columns: constraints.maxWidth > 600 ? 2 : 1,
                  children: [
                    CustomTextFormField(
                      controller: applicant.nameController,
                      label: 'Full Name',
                      readOnly: widget.isViewMode,
                    ),
                    CustomTextFormField(
                      controller: applicant.phoneController,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      readOnly: widget.isViewMode,
                    ),
                    CustomTextFormField(
                      controller: applicant.emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      readOnly: widget.isViewMode,
                    ),
                    CustomDateField(
                      controller: applicant.dobController,
                      label: 'Date of Birth',
                      endDate: DateTime.now(),
                      isRequired: false,
                    ),
                    CustomTextFormField(
                      controller: applicant.addressController,
                      label: 'Address',
                      maxLines: 2,
                      readOnly: widget.isViewMode,
                    ),
                  ],
                );
              }),
            ],
          )),
    );
  }

  Widget _buildProductCard() {
    return Card(
      elevation: 0,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Product',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.name ?? 'Product',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.product.code ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '₹${widget.product.sellingPrice ?? 0}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard(
      double grandTotal, double totalScheduled, double totalPaid) {
    final balance = grandTotal - totalPaid;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Payment Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildSummaryRow('Grand Total', grandTotal, isBold: true),
            const SizedBox(height: 8),
            _buildSummaryRow('Scheduled Payments', totalScheduled),
            const SizedBox(height: 8),
            _buildSummaryRow('Total Paid', totalPaid,
                color: Colors.blue.shade700),
            const Divider(height: 16),
            _buildSummaryRow('Balance Due', balance,
                isBold: true,
                color: balance > 0
                    ? Colors.orange.shade700
                    : Colors.green.shade700),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Financial Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildSummaryRow('Total Amount', _calculateTotalAmount()),
            const SizedBox(height: 8),
            _buildSummaryRow('Total Discount', _calculateTotalDiscount(),
                isNegative: true),
            const SizedBox(height: 8),
            _buildSummaryRow('Total GST', _calculateTotalGST()),
            const SizedBox(height: 8),
            _buildSummaryRow('Total CGST', _calculateTotalCGST()),
            const SizedBox(height: 8),
            _buildSummaryRow('Total SGST', _calculateTotalSGST()),
            const Divider(height: 24),
            _buildSummaryRow('Grand Total', _calculateGrandTotal(),
                isBold: true, color: Colors.green.shade700),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primaryColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 0,
      color: AppColors.blueNeutralColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  Widget _buildAddButton(String text, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
        foregroundColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isBold = false,
    bool isNegative = false,
    Color? color,
  }) {
    final displayAmount = isNegative ? -amount : amount;
    final textColor =
        color ?? (isNegative ? Colors.red.shade700 : Colors.grey.shade800);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
            color: textColor,
          ),
        ),
        Text(
          '₹${displayAmount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: isBold ? 18 : 15,
            color: textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isViewMode = widget.isViewMode;
    final isEditMode = widget.bookingToEdit != null;
    final screenTitle = isViewMode
        ? 'View Booking'
        : isEditMode
            ? 'Edit Booking'
            : 'Create Booking';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.75;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.85;
          } else if (maxWidth < 600) {
            dialogWidth = maxWidth;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1400,
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
                  // Header
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.85),
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
                            Icons.book_online_rounded,
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
                              Text(
                                screenTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.product.name ?? 'Product Booking',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
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
                      onTap: (value) => setState(() {}),
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primaryColor,
                      indicatorWeight: 3,
                      tabs: _tabs,
                    ),
                  ),

                  // Content
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildBasicInfoTab(),
                          _buildPricingTab(),
                          _buildPaymentsTab(),
                          _buildDetailsTab(),
                          _buildSummaryTab(),
                        ],
                      ),
                    ),
                  ),

                  // Action Buttons

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomActionButton(
                            text: 'Cancel',
                            icon: Icons.close_rounded,
                            textColor: Colors.grey.shade700,
                            onPressed: () => Navigator.pop(context),
                            borderColor: Colors.grey.shade300,
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (_tabController.index != _tabs.length - 1)
                          Expanded(
                            child: CustomActionButton(
                              text: 'NEXT',
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withOpacity(0.8),
                                ],
                              ),
                              isFilled: true,
                              icon: Icons.arrow_forward_rounded,
                              textColor: Colors.grey.shade700,
                              onPressed: () {
                                _tabController.animateTo(
                                  _tabController.index + 1,
                                );
                                setState(() {});
                              },
                              borderColor: Colors.grey.shade300,
                            ),
                          )
                        else
                          Expanded(
                            flex: 2,
                            child: CustomActionButton(
                              text: isEditMode
                                  ? 'Update Booking'
                                  : 'Create Booking',
                              icon: Icons.check_circle_outline,
                              isFilled: true,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withOpacity(0.8),
                                ],
                              ),
                              onPressed: _saveBooking,
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

  @override
  void dispose() {
    _tabController.dispose();
    _customerSearchController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerAddressController.dispose();
    _bookingDateController.dispose();
    _expectedClosureDateController.dispose();
    _notesController.dispose();
    _loanAmountController.dispose();
    _paidAmountController.dispose();
    _paymentMethodController.dispose();
    _transactionIdController.dispose();
    _transactionRemarksController.dispose();
    _courseNameController.dispose();
    _institutionNameController.dispose();
    _countryController.dispose();
    _visaTypeController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _returnDateController.dispose();
    _noOfTravellersController.dispose();

    for (var component in _priceComponents) {
      component.dispose();
    }
    for (var schedule in _paymentSchedules) {
      schedule.dispose();
    }
    for (var applicant in _coApplicants) {
      applicant.dispose();
    }

    super.dispose();
  }
}

// Helper Classes
class PriceComponentHelper {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController gstController;
  final TextEditingController cgstController;
  final TextEditingController sgstController;
  final List<OfferHelper> offers = [];

  PriceComponentHelper({
    String? title,
    double? amount,
    double? gstPercent,
    double? cgstPercent,
    double? sgstPercent,
  })  : titleController = TextEditingController(text: title ?? ''),
        amountController =
            TextEditingController(text: (amount ?? 0).toString()),
        gstController =
            TextEditingController(text: (gstPercent ?? 18).toString()),
        cgstController =
            TextEditingController(text: (cgstPercent ?? 9).toString()),
        sgstController =
            TextEditingController(text: (sgstPercent ?? 9).toString());

  void dispose() {
    titleController.dispose();
    amountController.dispose();
    gstController.dispose();
    cgstController.dispose();
    sgstController.dispose();
    for (var offer in offers) {
      offer.dispose();
    }
  }
}

class OfferHelper {
  final TextEditingController offerNameController;
  final TextEditingController discountController;
  bool isPercentage;

  OfferHelper({
    String? offerName,
    double? discountAmount,
    this.isPercentage = false,
  })  : offerNameController = TextEditingController(text: offerName ?? ''),
        discountController =
            TextEditingController(text: (discountAmount ?? 0).toString());

  void dispose() {
    offerNameController.dispose();
    discountController.dispose();
  }
}

class PaymentScheduleHelper {
  final TextEditingController paymentTypeController;
  final TextEditingController dueDateController;
  final TextEditingController amountController;

  PaymentScheduleHelper({
    String? paymentType,
    DateTime? dueDate,
    double? amount,
  })  : paymentTypeController = TextEditingController(text: paymentType ?? ''),
        dueDateController = TextEditingController(
            text: dueDate != null
                ? DateFormat('yyyy-MM-dd').format(dueDate)
                : ''),
        amountController =
            TextEditingController(text: (amount ?? 0).toString());

  void dispose() {
    paymentTypeController.dispose();
    dueDateController.dispose();
    amountController.dispose();
  }
}

class CoApplicantHelper {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController addressController;

  CoApplicantHelper({
    String? name,
    String? phone,
    String? email,
    DateTime? dob,
    String? address,
  })  : nameController = TextEditingController(text: name ?? ''),
        phoneController = TextEditingController(text: phone ?? ''),
        emailController = TextEditingController(text: email ?? ''),
        dobController = TextEditingController(
            text: dob != null ? DateFormat('yyyy-MM-dd').format(dob) : ''),
        addressController = TextEditingController(text: address ?? '');

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dobController.dispose();
    addressController.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/model/booking_model/booking_model.dart';
// import 'package:overseas_front_end/model/booking_model/transaction_model.dart';
// import 'package:overseas_front_end/model/lead/lead_model.dart';
// import 'package:overseas_front_end/model/product/product_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class BookingScreen extends StatefulWidget {
//   final ProductModel product;
//   final BookingModel? bookingToEdit;
//   final bool isViewMode;

//   const BookingScreen({
//     super.key,
//     required this.product,
//     this.bookingToEdit,
//     this.isViewMode = false,
//   });

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final _formKey = GlobalKey<FormState>();

//   static const List<Tab> _tabs = [
//     Tab(text: 'Basic Info', icon: Icon(Icons.info_outline, size: 16)),
//     Tab(text: 'Pricing', icon: Icon(Icons.attach_money, size: 16)),
//     Tab(text: 'Payments', icon: Icon(Icons.payment, size: 16)),
//     Tab(text: 'Details', icon: Icon(Icons.details, size: 16)),
//     Tab(text: 'Summary', icon: Icon(Icons.summarize, size: 16)),
//   ];

//   // Customer Search
//   final _customerSearchController = TextEditingController();
//   List<LeadModel> _customerList = [];
//   List<LeadModel> _filteredCustomerList = [];
//   bool _isSearching = false;
//   String? _selectedCustomerId;

//   // Basic Controllers
//   final _customerNameController = TextEditingController();
//   final _customerPhoneController = TextEditingController();
//   final _customerAddressController = TextEditingController();
//   final _bookingDateController = TextEditingController();
//   final _expectedClosureDateController = TextEditingController();
//   final _notesController = TextEditingController();

//   // Pricing Controllers
//   final _gstPercentageController = TextEditingController();
//   final _cgstPercentageController = TextEditingController();
//   final _sgstPercentageController = TextEditingController();
//   final _loanAmountController = TextEditingController();

//   // Transaction Controllers
//   final _paidAmountController = TextEditingController();
//   final _paymentMethodController = TextEditingController();
//   final _transactionIdController = TextEditingController();
//   final _transactionRemarksController = TextEditingController();

//   // Travel Details Controllers
//   final _courseNameController = TextEditingController();
//   final _institutionNameController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _visaTypeController = TextEditingController();
//   final _originController = TextEditingController();
//   final _destinationController = TextEditingController();
//   final _returnDateController = TextEditingController();
//   final _noOfTravellersController = TextEditingController();

//   // Dynamic Lists
//   final List<PriceComponentHelper> _priceComponents = [];
//   final List<PaymentScheduleHelper> _paymentSchedules = [];
//   final List<CoApplicantHelper> _coApplicants = [];

//   BookingModel _booking = BookingModel();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _tabs.length, vsync: this);
//     _initializeBooking();
//     _loadCustomers();
//   }

//   // Load customers from DB/API
//   Future<void> _loadCustomers() async {
//     // TODO: Replace with actual API call
//     setState(() {
//       _customerList = [
//         LeadModel(
//           id: '691d916c2d42a656d483fe9c',
//           name: 'John Doe',
//           phone: '9876543210',
//           address: 'MG Road, Kochi',
//           email: 'john@example.com',
//         ),
//         LeadModel(
//           id: '691d916c2d42a656d483fe9d',
//           name: 'Jane Smith',
//           phone: '9876543211',
//           address: 'Marine Drive, Kochi',
//           email: 'jane@example.com',
//         ),
//         LeadModel(
//           id: '691d916c2d42a656d483fe9e',
//           name: 'Robert Johnson',
//           phone: '9876543212',
//           address: 'Kakkanad, Kochi',
//           email: 'robert@example.com',
//         ),
//       ];
//       _filteredCustomerList = _customerList;
//     });
//   }

//   void _searchCustomers(String query) {
//     setState(() {
//       _isSearching = query.isNotEmpty;
//       if (query.isEmpty) {
//         _filteredCustomerList = _customerList;
//       } else {
//         _filteredCustomerList = _customerList.where((customer) {
//           final nameLower = (customer.name ?? '').toLowerCase();
//           final phoneLower = (customer.phone ?? '').toLowerCase();
//           final queryLower = query.toLowerCase();
//           return nameLower.contains(queryLower) ||
//               phoneLower.contains(queryLower);
//         }).toList();
//       }
//     });
//   }

//   void _selectCustomer(LeadModel customer) {
//     setState(() {
//       _selectedCustomerId = customer.id;
//       _customerNameController.text = customer.name ?? '';
//       _customerPhoneController.text = customer.phone ?? '';
//       _customerAddressController.text = customer.address ?? '';
//       _customerSearchController.clear();
//       _isSearching = false;
//     });
//   }

//   void _initializeBooking() {
//     if (widget.bookingToEdit != null) {
//       _booking = widget.bookingToEdit!;
//       _populateFromBooking();
//     } else {
//       _booking = _createNewBooking();
//       _populateFromProduct();
//     }
//   }

//   BookingModel _createNewBooking() {
//     return BookingModel(
//       productId: widget.product.id ?? '',
//       productName: widget.product.name ?? '',
//       bookingDate: DateTime.now(),
//       expectedClosureDate: DateTime.now().add(const Duration(days: 20)),
//       totalAmount: widget.product.sellingPrice ?? 0,
//       gstPercentage: 18,
//       cgstPercentage: 9,
//       sgstPercentage: 9,
//       discountAmount: 0,
//       noOfTravellers: 1,
//       institutionName: widget.product.institutionName ?? '',
//       countryApplyingFor: widget.product.country ?? '',
//       visaType: widget.product.visaType ?? '',
//       destination: widget.product.location ?? '',
//       transaction: TransactionModel(
//         paidAmount: 0,
//         paymentMethod: '',
//         transactionId: '',
//         remarks: '',
//       ),
//     );
//   }

//   void _populateFromProduct() {
//     _bookingDateController.text = _formatDate(DateTime.now());
//     _expectedClosureDateController.text =
//         _formatDate(DateTime.now().add(const Duration(days: 20)));
//     _gstPercentageController.text = '18';
//     _cgstPercentageController.text = '9';
//     _sgstPercentageController.text = '9';
//     _noOfTravellersController.text = '1';
//     _loanAmountController.text = '0';
//     _paidAmountController.text = '0';

//     _institutionNameController.text = widget.product.institutionName ?? '';
//     _countryController.text = widget.product.country ?? '';
//     _visaTypeController.text = widget.product.visaType ?? '';
//     _destinationController.text = widget.product.location ?? '';

//     // Add default price components from product
//     if (widget.product.priceComponents != null) {
//       for (var component in widget.product.priceComponents!) {
//         _priceComponents.add(PriceComponentHelper(
//           title: component.title,
//           amount: component.amount,
//           gstPercent: component.gstPercent,
//           cgstPercent: component.cgstPercent,
//           sgstPercent: component.sgstPercent,
//         ));
//       }
//     }
//   }

//   void _populateFromBooking() {
//     _selectedCustomerId = _booking.customerId;
//     _customerNameController.text = _booking.customerName ?? '';
//     _customerPhoneController.text = _booking.customerPhone ?? '';
//     _customerAddressController.text = _booking.customerAddress ?? '';
//     _bookingDateController.text = _formatDate(_booking.bookingDate);
//     _expectedClosureDateController.text =
//         _formatDate(_booking.expectedClosureDate);
//     _gstPercentageController.text = (_booking.gstPercentage ?? 18).toString();
//     _cgstPercentageController.text = (_booking.cgstPercentage ?? 9).toString();
//     _sgstPercentageController.text = (_booking.sgstPercentage ?? 9).toString();
//     _loanAmountController.text = (_booking.loanAmountRequested ?? 0).toString();
//     _notesController.text = _booking.notes ?? '';

//     _courseNameController.text = _booking.courseName ?? '';
//     _institutionNameController.text = _booking.institutionName ?? '';
//     _countryController.text = _booking.countryApplyingFor ?? '';
//     _visaTypeController.text = _booking.visaType ?? '';
//     _originController.text = _booking.origin ?? '';
//     _destinationController.text = _booking.destination ?? '';
//     _returnDateController.text = _formatDate(_booking.returnDate);
//     _noOfTravellersController.text = (_booking.noOfTravellers ?? 1).toString();

//     _paidAmountController.text =
//         (_booking.transaction?.paidAmount ?? 0).toString();
//     _paymentMethodController.text = _booking.transaction?.paymentMethod ?? '';
//     _transactionIdController.text = _booking.transaction?.transactionId ?? '';
//     _transactionRemarksController.text = _booking.transaction?.remarks ?? '';

//     // Populate price components with offers
//     if (_booking.priceComponents != null) {
//       for (var comp in _booking.priceComponents!) {
//         final componentHelper = PriceComponentHelper(
//           title: comp.title,
//           amount: comp.amount,
//           gstPercent: comp.gstPercent,
//           cgstPercent: comp.cgstPercent,
//           sgstPercent: comp.sgstPercent,
//         );

//         // Add offers for this component
//         if (comp.offersApplied != null) {
//           for (var offer in comp.offersApplied!) {
//             componentHelper.offers.add(OfferHelper(
//               offerName: offer.offerName,
//               discountAmount: offer.discountAmount,
//             ));
//           }
//         }

//         _priceComponents.add(componentHelper);
//       }
//     }

//     if (_booking.paymentSchedule != null) {
//       for (var payment in _booking.paymentSchedule!) {
//         _paymentSchedules.add(PaymentScheduleHelper(
//           paymentType: payment.paymentType,
//           dueDate: payment.dueDate,
//           amount: payment.amount,
//         ));
//       }
//     }

//     if (_booking.coApplicantList != null) {
//       for (var applicant in _booking.coApplicantList!) {
//         _coApplicants.add(CoApplicantHelper(
//           name: applicant.name,
//           phone: applicant.phone,
//           dob: applicant.dob,
//           address: applicant.address,
//           email: applicant.email,
//         ));
//       }
//     }
//   }

//   String _formatDate(DateTime? date) {
//     return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
//   }

//   // Calculation Methods - Updated to handle offers per component
//   double _calculateComponentSubtotal(PriceComponentHelper component) {
//     final amount = double.tryParse(component.amountController.text) ?? 0;
//     double totalDiscount = 0;

//     for (var offer in component.offers) {
//       if (offer.isPercentage) {
//         final percent = double.tryParse(offer.discountController.text) ?? 0;
//         totalDiscount += (amount * percent) / 100;
//       } else {
//         totalDiscount += double.tryParse(offer.discountController.text) ?? 0;
//       }
//     }

//     return amount - totalDiscount;
//   }

//   double _calculateComponentGST(PriceComponentHelper component) {
//     final subtotal = _calculateComponentSubtotal(component);
//     final gstPercent = double.tryParse(component.gstController.text) ?? 0;
//     return (subtotal * gstPercent) / 100;
//   }

//   double _calculateComponentCGST(PriceComponentHelper component) {
//     final subtotal = _calculateComponentSubtotal(component);
//     final cgstPercent = double.tryParse(component.cgstController.text) ?? 0;
//     return (subtotal * cgstPercent) / 100;
//   }

//   double _calculateComponentSGST(PriceComponentHelper component) {
//     final subtotal = _calculateComponentSubtotal(component);
//     final sgstPercent = double.tryParse(component.sgstController.text) ?? 0;
//     return (subtotal * sgstPercent) / 100;
//   }

//   double _calculateTotalAmount() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       total += double.tryParse(component.amountController.text) ?? 0;
//     }
//     return total;
//   }

//   double _calculateTotalDiscount() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       final amount = double.tryParse(component.amountController.text) ?? 0;
//       for (var offer in component.offers) {
//         if (offer.isPercentage) {
//           final percent = double.tryParse(offer.discountController.text) ?? 0;
//           total += (amount * percent) / 100;
//         } else {
//           total += double.tryParse(offer.discountController.text) ?? 0;
//         }
//       }
//     }
//     return total;
//   }

//   double _calculateTotalGST() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       total += _calculateComponentGST(component);
//     }
//     return total;
//   }

//   double _calculateTotalCGST() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       total += _calculateComponentCGST(component);
//     }
//     return total;
//   }

//   double _calculateTotalSGST() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       total += _calculateComponentSGST(component);
//     }
//     return total;
//   }

//   double _calculateGrandTotal() {
//     double total = 0;
//     for (var component in _priceComponents) {
//       final subtotal = _calculateComponentSubtotal(component);
//       final gst = _calculateComponentGST(component);
//       final cgst = _calculateComponentCGST(component);
//       final sgst = _calculateComponentSGST(component);
//       total += subtotal + gst + cgst + sgst;
//     }
//     return total;
//   }

//   void _recalculate() {
//     setState(() {});
//   }

//   // Add/Remove Methods
//   void _addPriceComponent() {
//     setState(() {
//       _priceComponents.add(PriceComponentHelper());
//     });
//   }

//   void _removePriceComponent(int index) {
//     setState(() {
//       _priceComponents.removeAt(index);
//       _recalculate();
//     });
//   }

//   void _addOfferToComponent(PriceComponentHelper component) {
//     setState(() {
//       component.offers.add(OfferHelper());
//     });
//   }

//   void _removeOfferFromComponent(
//       PriceComponentHelper component, int offerIndex) {
//     setState(() {
//       component.offers.removeAt(offerIndex);
//       _recalculate();
//     });
//   }

//   void _addPaymentSchedule() {
//     setState(() {
//       _paymentSchedules.add(PaymentScheduleHelper());
//     });
//   }

//   void _removePaymentSchedule(int index) {
//     setState(() {
//       _paymentSchedules.removeAt(index);
//     });
//   }

//   void _addCoApplicant() {
//     setState(() {
//       _coApplicants.add(CoApplicantHelper());
//     });
//   }

//   void _removeCoApplicant(int index) {
//     setState(() {
//       _coApplicants.removeAt(index);
//     });
//   }

//   Future<void> _saveBooking() async {
//     if (!_formKey.currentState!.validate()) return;

//     // Build price components with their offers
//     final priceComponentsData = _priceComponents.map((comp) {
//       final offersData = comp.offers.map((offer) {
//         double amount;
//         final componentAmount =
//             double.tryParse(comp.amountController.text) ?? 0;
//         if (offer.isPercentage) {
//           final percent = double.tryParse(offer.discountController.text) ?? 0;
//           amount = (componentAmount * percent) / 100;
//         } else {
//           amount = double.tryParse(offer.discountController.text) ?? 0;
//         }

//         return {
//           "offer_name": offer.offerNameController.text,
//           "discount_amount": amount,
//         };
//       }).toList();

//       return {
//         "title": comp.titleController.text,
//         "amount": double.tryParse(comp.amountController.text) ?? 0,
//         "gstPercent": double.tryParse(comp.gstController.text) ?? 18,
//         "cgstPercent": double.tryParse(comp.cgstController.text) ?? 9,
//         "sgstPercent": double.tryParse(comp.sgstController.text) ?? 9,
//         "offers_applied": offersData,
//       };
//     }).toList();

//     final bookingData = {
//       "customer_id": _selectedCustomerId ?? "691d916c2d42a656d483fe9c",
//       "customer_name": _customerNameController.text,
//       "customer_phone": _customerPhoneController.text,
//       "officer_id": _booking.officerId ?? "687b5b1b0ae65f8ce9d4601a",
//       "customer_address": _customerAddressController.text,
//       "product_id": widget.product.id,
//       "product_name": widget.product.name,
//       "booking_date": _bookingDateController.text,
//       "expected_closure_date": _expectedClosureDateController.text,
//       "total_amount": _calculateTotalAmount(),
//       "gst_percentage": double.tryParse(_gstPercentageController.text) ?? 18,
//       "gst_amount": _calculateTotalGST(),
//       "cgst_percentage": double.tryParse(_cgstPercentageController.text) ?? 9,
//       "cgst_amount": _calculateTotalCGST(),
//       "sgst_percentage": double.tryParse(_sgstPercentageController.text) ?? 9,
//       "sgst_amount": _calculateTotalSGST(),
//       "grand_total": _calculateGrandTotal(),
//       "discount_amount": _calculateTotalDiscount(),
//       "transaction": {
//         "paid_amount": double.tryParse(_paidAmountController.text) ?? 0,
//         "payment_method": _paymentMethodController.text,
//         "transaction_id": _transactionIdController.text,
//         "remarks": _transactionRemarksController.text,
//       },
//       "priceComponents": priceComponentsData,
//       "payment_schedule": _paymentSchedules
//           .map((schedule) => {
//                 "payment_type": schedule.paymentTypeController.text,
//                 "due_date": schedule.dueDateController.text,
//                 "amount": double.tryParse(schedule.amountController.text) ?? 0,
//               })
//           .toList(),
//       "loan_amount_requested": double.tryParse(_loanAmountController.text) ?? 0,
//       "notes": _notesController.text,
//       "course_name": _courseNameController.text,
//       "institution_name": _institutionNameController.text,
//       "country_applying_for": _countryController.text,
//       "visa_type": _visaTypeController.text,
//       "origin": _originController.text,
//       "destination": _destinationController.text,
//       "return_date": _returnDateController.text,
//       "no_of_travellers": int.tryParse(_noOfTravellersController.text) ?? 1,
//       "co_applicant_list": _coApplicants
//           .map((applicant) => {
//                 "name": applicant.nameController.text,
//                 "phone": applicant.phoneController.text,
//                 "dob": applicant.dobController.text,
//                 "address": applicant.addressController.text,
//                 "email": applicant.emailController.text,
//               })
//           .toList(),
//     };

//     // TODO: Call API
//     debugPrint(bookingData.toString());

//     await Future.delayed(const Duration(seconds: 1));

//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(widget.bookingToEdit != null
//             ? 'Booking Updated Successfully'
//             : 'Booking Created Successfully'),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );

//     Navigator.pop(context, bookingData);
//   }

//   // UI Builders
//   Widget _buildBasicInfoTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildProductCard(),
//           const SizedBox(height: 24),
//           _buildSectionTitle('Customer Information', Icons.person_outline),
//           const SizedBox(height: 16),
//           _buildCustomerSearchSection(),
//           const SizedBox(height: 24),
//           _buildSectionTitle('Booking Details', Icons.calendar_today_outlined),
//           const SizedBox(height: 16),
//           _buildCard(
//             child: Column(
//               children: [
//                 CustomDateField(
//                   controller: _bookingDateController,
//                   label: 'Booking Date',
//                   isRequired: true,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomDateField(
//                   controller: _expectedClosureDateController,
//                   label: 'Expected Closure Date',
//                   isRequired: true,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _notesController,
//                   label: 'Notes / Special Requirements',
//                   maxLines: 3,
//                   readOnly: widget.isViewMode,
//                   prefixIcon: Icons.note_outlined,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCustomerSearchSection() {
//     return _buildCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!widget.isViewMode) ...[
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _customerSearchController,
//                     decoration: InputDecoration(
//                       labelText: 'Search Customer',
//                       hintText: 'Search by name or phone',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[50],
//                     ),
//                     onChanged: _searchCustomers,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 IconButton(
//                   icon: const Icon(Icons.person_add, color: Colors.blue),
//                   tooltip: 'Create New Customer',
//                   onPressed: () {
//                     // TODO: Show create customer dialog
//                   },
//                 ),
//               ],
//             ),
//             if (_isSearching && _filteredCustomerList.isNotEmpty) ...[
//               const SizedBox(height: 12),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 constraints: const BoxConstraints(maxHeight: 200),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: _filteredCustomerList.length,
//                   itemBuilder: (context, index) {
//                     final customer = _filteredCustomerList[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor:
//                             AppColors.primaryColor.withOpacity(0.1),
//                         child: Icon(
//                           Icons.person,
//                           size: 20,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                       title: Text(
//                         customer.name ?? '',
//                         style: const TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       subtitle: Text(customer.phone ?? ''),
//                       trailing: const Icon(Icons.chevron_right, size: 20),
//                       onTap: () => _selectCustomer(customer),
//                     );
//                   },
//                 ),
//               ),
//             ],
//             const SizedBox(height: 16),
//             const Divider(),
//             const SizedBox(height: 16),
//           ],

//           // Customer form fields
//           CustomTextFormField(
//             controller: _customerNameController,
//             label: 'Customer Name',
//             isRequired: true,
//             readOnly: widget.isViewMode,
//             prefixIcon: Icons.person_outline,
//           ),
//           const SizedBox(height: 16),
//           CustomTextFormField(
//             controller: _customerPhoneController,
//             label: 'Customer Phone',
//             keyboardType: TextInputType.phone,
//             isRequired: true,
//             readOnly: widget.isViewMode,
//             prefixIcon: Icons.phone_outlined,
//           ),
//           const SizedBox(height: 16),
//           CustomTextFormField(
//             controller: _customerAddressController,
//             label: 'Customer Address',
//             maxLines: 2,
//             readOnly: widget.isViewMode,
//             prefixIcon: Icons.location_on_outlined,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPricingTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle('Price Components', Icons.receipt_long_outlined),
//           const SizedBox(height: 16),
//           ..._priceComponents.asMap().entries.map((entry) {
//             return _buildPriceComponentCard(entry.key, entry.value);
//           }).toList(),
//           if (!widget.isViewMode) ...[
//             _buildAddButton('Add Price Component', _addPriceComponent),
//             const SizedBox(height: 24),
//           ],
//           _buildSectionTitle('Tax Configuration', Icons.calculate_outlined),
//           const SizedBox(height: 16),
//           _buildCard(
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: _gstPercentageController,
//                   label: 'Default GST Percentage (%)',
//                   keyboardType: TextInputType.number,
//                   readOnly: widget.isViewMode,
//                   onChanged: (_) => _recalculate(),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _cgstPercentageController,
//                         label: 'Default CGST Percentage (%)',
//                         keyboardType: TextInputType.number,
//                         readOnly: widget.isViewMode,
//                         onChanged: (_) => _recalculate(),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _sgstPercentageController,
//                         label: 'Default SGST Percentage (%)',
//                         keyboardType: TextInputType.number,
//                         readOnly: widget.isViewMode,
//                         onChanged: (_) => _recalculate(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           _buildSectionTitle(
//               'Loan Information', Icons.account_balance_outlined),
//           const SizedBox(height: 16),
//           _buildCard(
//             child: CustomTextFormField(
//               controller: _loanAmountController,
//               label: 'Loan Amount Requested (₹)',
//               keyboardType: TextInputType.number,
//               readOnly: widget.isViewMode,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentsTab() {
//     final grandTotal = _calculateGrandTotal();
//     double totalScheduled = 0;
//     for (var schedule in _paymentSchedules) {
//       totalScheduled += double.tryParse(schedule.amountController.text) ?? 0;
//     }

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle('Initial Transaction', Icons.receipt_outlined),
//           const SizedBox(height: 16),
//           _buildCard(
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: _paidAmountController,
//                   label: 'Paid Amount (₹)',
//                   keyboardType: TextInputType.number,
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _paymentMethodController,
//                   label: 'Payment Method',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _transactionIdController,
//                   label: 'Transaction ID',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _transactionRemarksController,
//                   label: 'Remarks',
//                   maxLines: 2,
//                   readOnly: widget.isViewMode,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           _buildSectionTitle('Payment Schedule', Icons.schedule_outlined),
//           const SizedBox(height: 16),
//           ..._paymentSchedules.asMap().entries.map((entry) {
//             return _buildPaymentScheduleCard(entry.key, entry.value);
//           }).toList(),
//           if (!widget.isViewMode) ...[
//             _buildAddButton('Add Payment Schedule', _addPaymentSchedule),
//             const SizedBox(height: 24),
//           ],
//           _buildPaymentSummaryCard(grandTotal, totalScheduled),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailsTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle('Travel/Education Details', Icons.flight_outlined),
//           const SizedBox(height: 16),
//           _buildCard(
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: _courseNameController,
//                   label: 'Course Name',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _institutionNameController,
//                   label: 'Institution Name',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _countryController,
//                   label: 'Country Applying For',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _visaTypeController,
//                   label: 'Visa Type',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _originController,
//                   label: 'Origin',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _destinationController,
//                   label: 'Destination',
//                   readOnly: widget.isViewMode,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomDateField(
//                   controller: _returnDateController,
//                   label: 'Return Date',
//                   isRequired: false,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _noOfTravellersController,
//                   label: 'Number of Travellers',
//                   keyboardType: TextInputType.number,
//                   readOnly: widget.isViewMode,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           _buildSectionTitle('Co-Applicants', Icons.group_outlined),
//           const SizedBox(height: 16),
//           ..._coApplicants.asMap().entries.map((entry) {
//             return _buildCoApplicantCard(entry.key, entry.value);
//           }).toList(),
//           if (!widget.isViewMode)
//             _buildAddButton('Add Co-Applicant', _addCoApplicant),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle('Booking Summary', Icons.summarize_outlined),
//           const SizedBox(height: 16),
//           _buildInfoCard(
//             title: 'Customer Details',
//             icon: Icons.person,
//             children: [
//               _buildInfoRow('Name', _customerNameController.text),
//               _buildInfoRow('Phone', _customerPhoneController.text),
//               _buildInfoRow('Address', _customerAddressController.text),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildInfoCard(
//             title: 'Product Details',
//             icon: Icons.shopping_bag,
//             children: [
//               _buildInfoRow('Product', widget.product.name ?? ''),
//               _buildInfoRow('Code', widget.product.code ?? ''),
//               _buildInfoRow('Booking Date', _bookingDateController.text),
//               _buildInfoRow(
//                   'Closure Date', _expectedClosureDateController.text),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildFinancialSummaryCard(),
//         ],
//       ),
//     );
//   }

//   // Card Builders
//   Widget _buildPriceComponentCard(int index, PriceComponentHelper component) {
//     final componentSubtotal = _calculateComponentSubtotal(component);
//     final componentGST = _calculateComponentGST(component);
//     final componentCGST = _calculateComponentCGST(component);
//     final componentSGST = _calculateComponentSGST(component);
//     final componentTotal =
//         componentSubtotal + componentGST + componentCGST + componentSGST;

//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 2,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//             color: AppColors.primaryColor.withOpacity(0.2), width: 1.5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         Icons.receipt_long,
//                         color: AppColors.primaryColor,
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Text(
//                       'Component ${index + 1}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (!widget.isViewMode)
//                   IconButton(
//                     icon: const Icon(Icons.delete_outline,
//                         color: Colors.red, size: 20),
//                     onPressed: () => _removePriceComponent(index),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             CustomTextFormField(
//               controller: component.titleController,
//               label: 'Component Title',
//               readOnly: widget.isViewMode,
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: component.amountController,
//               label: 'Amount (₹)',
//               keyboardType: TextInputType.number,
//               readOnly: widget.isViewMode,
//               onChanged: (_) => _recalculate(),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     controller: component.gstController,
//                     label: 'GST %',
//                     keyboardType: TextInputType.number,
//                     readOnly: widget.isViewMode,
//                     onChanged: (_) => _recalculate(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: CustomTextFormField(
//                     controller: component.cgstController,
//                     label: 'CGST %',
//                     keyboardType: TextInputType.number,
//                     readOnly: widget.isViewMode,
//                     onChanged: (_) => _recalculate(),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: CustomTextFormField(
//                     controller: component.sgstController,
//                     label: 'SGST %',
//                     keyboardType: TextInputType.number,
//                     readOnly: widget.isViewMode,
//                     onChanged: (_) => _recalculate(),
//                   ),
//                 ),
//               ],
//             ),

//             // Offers Section
//             const SizedBox(height: 16),
//             const Divider(),
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.local_offer,
//                         color: Colors.orange.shade700, size: 18),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Offers (${component.offers.length})',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: Colors.orange.shade900,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (!widget.isViewMode)
//                   TextButton.icon(
//                     onPressed: () => _addOfferToComponent(component),
//                     icon: const Icon(Icons.add, size: 18),
//                     label: const Text('Add Offer'),
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.orange.shade700,
//                     ),
//                   ),
//               ],
//             ),

//             // Offers List
//             if (component.offers.isNotEmpty) ...[
//               const SizedBox(height: 12),
//               ...component.offers.asMap().entries.map((offerEntry) {
//                 return _buildOfferCardInComponent(
//                   component,
//                   offerEntry.key,
//                   offerEntry.value,
//                 );
//               }).toList(),
//             ],

//             // Component Summary
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Column(
//                 children: [
//                   _buildComponentSummaryRow('Base Amount',
//                       double.tryParse(component.amountController.text) ?? 0),
//                   if (component.offers.isNotEmpty)
//                     _buildComponentSummaryRow(
//                         'Discount',
//                         (double.tryParse(component.amountController.text) ??
//                                 0) -
//                             componentSubtotal,
//                         isNegative: true),
//                   _buildComponentSummaryRow(
//                       'After Discount', componentSubtotal),
//                   _buildComponentSummaryRow('GST', componentGST),
//                   _buildComponentSummaryRow('CGST', componentCGST),
//                   _buildComponentSummaryRow('SGST', componentSGST),
//                   const Divider(height: 16),
//                   _buildComponentSummaryRow('Component Total', componentTotal,
//                       isBold: true, color: Colors.green.shade700),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOfferCardInComponent(
//     PriceComponentHelper component,
//     int offerIndex,
//     OfferHelper offer,
//   ) {
//     final componentAmount =
//         double.tryParse(component.amountController.text) ?? 0;
//     double calculatedAmount = 0;

//     if (offer.isPercentage) {
//       final percent = double.tryParse(offer.discountController.text) ?? 0;
//       calculatedAmount = (componentAmount * percent) / 100;
//     } else {
//       calculatedAmount = double.tryParse(offer.discountController.text) ?? 0;
//     }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.orange.shade50,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.orange.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Offer ${offerIndex + 1}',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.orange.shade900,
//                 ),
//               ),
//               if (!widget.isViewMode)
//                 IconButton(
//                   icon: const Icon(Icons.close, size: 16),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                   color: Colors.red,
//                   onPressed: () =>
//                       _removeOfferFromComponent(component, offerIndex),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           CustomTextFormField(
//             controller: offer.offerNameController,
//             label: 'Offer Name',
//             readOnly: widget.isViewMode,
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: CustomTextFormField(
//                   controller: offer.discountController,
//                   label: offer.isPercentage
//                       ? 'Discount (%)'
//                       : 'Discount Amount (₹)',
//                   keyboardType: TextInputType.number,
//                   readOnly: widget.isViewMode,
//                   onChanged: (_) => _recalculate(),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               if (!widget.isViewMode)
//                 Expanded(
//                   child: DropdownButtonFormField<bool>(
//                     value: offer.isPercentage,
//                     decoration: const InputDecoration(
//                       labelText: 'Type',
//                       border: OutlineInputBorder(),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     ),
//                     items: const [
//                       DropdownMenuItem(value: true, child: Text('%')),
//                       DropdownMenuItem(value: false, child: Text('₹')),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         offer.isPercentage = value ?? true;
//                         _recalculate();
//                       });
//                     },
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Discount Amount: ₹${calculatedAmount.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.green.shade700,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildComponentSummaryRow(
//     String label,
//     double amount, {
//     bool isBold = false,
//     bool isNegative = false,
//     Color? color,
//   }) {
//     final displayAmount = isNegative ? -amount : amount;
//     final textColor =
//         color ?? (isNegative ? Colors.red.shade700 : Colors.grey.shade700);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               fontSize: isBold ? 14 : 13,
//               color: textColor,
//             ),
//           ),
//           Text(
//             '₹${displayAmount.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//               fontSize: isBold ? 14 : 13,
//               color: textColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentScheduleCard(int index, PaymentScheduleHelper schedule) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade200),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Payment ${index + 1}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 if (!widget.isViewMode)
//                   IconButton(
//                     icon: const Icon(Icons.delete_outline,
//                         color: Colors.red, size: 20),
//                     onPressed: () => _removePaymentSchedule(index),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: schedule.paymentTypeController,
//               label: 'Payment Type',
//               readOnly: widget.isViewMode,
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomDateField(
//                     controller: schedule.dueDateController,
//                     label: 'Due Date',
//                     isRequired: true,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: CustomTextFormField(
//                     controller: schedule.amountController,
//                     label: 'Amount (₹)',
//                     keyboardType: TextInputType.number,
//                     readOnly: widget.isViewMode,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCoApplicantCard(int index, CoApplicantHelper applicant) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade200),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Co-Applicant ${index + 1}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 if (!widget.isViewMode)
//                   IconButton(
//                     icon: const Icon(Icons.delete_outline,
//                         color: Colors.red, size: 20),
//                     onPressed: () => _removeCoApplicant(index),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: applicant.nameController,
//               label: 'Full Name',
//               readOnly: widget.isViewMode,
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: applicant.phoneController,
//               label: 'Phone Number',
//               keyboardType: TextInputType.phone,
//               readOnly: widget.isViewMode,
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: applicant.emailController,
//               label: 'Email',
//               keyboardType: TextInputType.emailAddress,
//               readOnly: widget.isViewMode,
//             ),
//             const SizedBox(height: 12),
//             CustomDateField(
//               controller: applicant.dobController,
//               label: 'Date of Birth',
//               isRequired: false,
//             ),
//             const SizedBox(height: 12),
//             CustomTextFormField(
//               controller: applicant.addressController,
//               label: 'Address',
//               maxLines: 2,
//               readOnly: widget.isViewMode,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard() {
//     return Card(
//       elevation: 0,
//       color: AppColors.primaryColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(
//                 Icons.card_giftcard,
//                 color: Colors.white,
//                 size: 32,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Selected Product',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     widget.product.name ?? 'Product',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     widget.product.code ?? '',
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 '₹${widget.product.sellingPrice ?? 0}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentSummaryCard(double grandTotal, double totalScheduled) {
//     final balance = grandTotal - totalScheduled;

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blue.shade50, Colors.purple.shade50],
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.account_balance_wallet, color: Colors.blue.shade700),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Payment Summary',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             _buildSummaryRow('Grand Total', grandTotal, isBold: true),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Total Scheduled', totalScheduled),
//             const Divider(height: 16),
//             _buildSummaryRow('Balance Due', balance,
//                 isBold: true,
//                 color: balance > 0
//                     ? Colors.orange.shade700
//                     : Colors.green.shade700),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFinancialSummaryCard() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blue.shade50, Colors.purple.shade50],
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.account_balance_wallet, color: Colors.blue.shade700),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Financial Summary',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             _buildSummaryRow('Total Amount', _calculateTotalAmount()),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Total Discount', _calculateTotalDiscount(),
//                 isNegative: true),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Total GST', _calculateTotalGST()),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Total CGST', _calculateTotalCGST()),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Total SGST', _calculateTotalSGST()),
//             const Divider(height: 24),
//             _buildSummaryRow('Grand Total', _calculateGrandTotal(),
//                 isBold: true, color: Colors.green.shade700),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Card(
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade200),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(icon, color: AppColors.primaryColor, size: 20),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCard({required Widget child}) {
//     return Card(
//       elevation: 0,
//       color: AppColors.blueNeutralColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade200),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: child,
//       ),
//     );
//   }

//   Widget _buildAddButton(String text, VoidCallback onPressed) {
//     return OutlinedButton.icon(
//       onPressed: onPressed,
//       icon: const Icon(Icons.add),
//       label: Text(text),
//       style: OutlinedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 48),
//         side: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
//         foregroundColor: AppColors.primaryColor,
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, color: AppColors.primaryColor, size: 24),
//         const SizedBox(width: 12),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value.isNotEmpty ? value : '-',
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(
//     String label,
//     double amount, {
//     bool isBold = false,
//     bool isNegative = false,
//     Color? color,
//   }) {
//     final displayAmount = isNegative ? -amount : amount;
//     final textColor =
//         color ?? (isNegative ? Colors.red.shade700 : Colors.grey.shade800);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             fontSize: isBold ? 16 : 14,
//             color: textColor,
//           ),
//         ),
//         Text(
//           '₹${displayAmount.toStringAsFixed(2)}',
//           style: TextStyle(
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//             fontSize: isBold ? 18 : 15,
//             color: textColor,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isViewMode = widget.isViewMode;
//     final isEditMode = widget.bookingToEdit != null;
//     final screenTitle = isViewMode
//         ? 'View Booking'
//         : isEditMode
//             ? 'Edit Booking'
//             : 'Create Booking';

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.75;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.85;
//           } else if (maxWidth < 600) {
//             dialogWidth = maxWidth;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1400,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Header
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 16,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.85),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.book_online_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 screenTitle,
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 widget.product.name ?? 'Product Booking',
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.close_rounded,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Tab Bar
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade50,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade200),
//                       ),
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       isScrollable: true,
//                       labelColor: AppColors.primaryColor,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: AppColors.primaryColor,
//                       indicatorWeight: 3,
//                       tabs: _tabs,
//                     ),
//                   ),

//                   // Content
//                   Expanded(
//                     child: Form(
//                       key: _formKey,
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           _buildBasicInfoTab(),
//                           _buildPricingTab(),
//                           _buildPaymentsTab(),
//                           _buildDetailsTab(),
//                           _buildSummaryTab(),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // Action Buttons
//                   if (!isViewMode)
//                     Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border(
//                           top: BorderSide(color: Colors.grey.shade200),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: CustomActionButton(
//                               text: 'Cancel',
//                               icon: Icons.close_rounded,
//                               textColor: Colors.grey.shade700,
//                               onPressed: () => Navigator.pop(context),
//                               borderColor: Colors.grey.shade300,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             flex: 2,
//                             child: CustomActionButton(
//                               text: isEditMode
//                                   ? 'Update Booking'
//                                   : 'Create Booking',
//                               icon: Icons.check_circle_outline,
//                               isFilled: true,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   AppColors.primaryColor,
//                                   AppColors.primaryColor.withOpacity(0.8),
//                                 ],
//                               ),
//                               onPressed: _saveBooking,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _customerSearchController.dispose();
//     _customerNameController.dispose();
//     _customerPhoneController.dispose();
//     _customerAddressController.dispose();
//     _bookingDateController.dispose();
//     _expectedClosureDateController.dispose();
//     _notesController.dispose();
//     _gstPercentageController.dispose();
//     _cgstPercentageController.dispose();
//     _sgstPercentageController.dispose();
//     _loanAmountController.dispose();
//     _paidAmountController.dispose();
//     _paymentMethodController.dispose();
//     _transactionIdController.dispose();
//     _transactionRemarksController.dispose();
//     _courseNameController.dispose();
//     _institutionNameController.dispose();
//     _countryController.dispose();
//     _visaTypeController.dispose();
//     _originController.dispose();
//     _destinationController.dispose();
//     _returnDateController.dispose();
//     _noOfTravellersController.dispose();

//     for (var component in _priceComponents) {
//       component.dispose();
//     }
//     for (var schedule in _paymentSchedules) {
//       schedule.dispose();
//     }
//     for (var applicant in _coApplicants) {
//       applicant.dispose();
//     }

//     super.dispose();
//   }
// }

// // Helper Classes
// class PriceComponentHelper {
//   final TextEditingController titleController;
//   final TextEditingController amountController;
//   final TextEditingController gstController;
//   final TextEditingController cgstController;
//   final TextEditingController sgstController;
//   final List<OfferHelper> offers = [];

//   PriceComponentHelper({
//     String? title,
//     double? amount,
//     double? gstPercent,
//     double? cgstPercent,
//     double? sgstPercent,
//   })  : titleController = TextEditingController(text: title ?? ''),
//         amountController =
//             TextEditingController(text: (amount ?? 0).toString()),
//         gstController =
//             TextEditingController(text: (gstPercent ?? 18).toString()),
//         cgstController =
//             TextEditingController(text: (cgstPercent ?? 9).toString()),
//         sgstController =
//             TextEditingController(text: (sgstPercent ?? 9).toString());

//   void dispose() {
//     titleController.dispose();
//     amountController.dispose();
//     gstController.dispose();
//     cgstController.dispose();
//     sgstController.dispose();
//     for (var offer in offers) {
//       offer.dispose();
//     }
//   }
// }

// class OfferHelper {
//   final TextEditingController offerNameController;
//   final TextEditingController discountController;
//   bool isPercentage;

//   OfferHelper({
//     String? offerName,
//     double? discountAmount,
//     this.isPercentage = false,
//   })  : offerNameController = TextEditingController(text: offerName ?? ''),
//         discountController =
//             TextEditingController(text: (discountAmount ?? 0).toString());

//   void dispose() {
//     offerNameController.dispose();
//     discountController.dispose();
//   }
// }

// class PaymentScheduleHelper {
//   final TextEditingController paymentTypeController;
//   final TextEditingController dueDateController;
//   final TextEditingController amountController;

//   PaymentScheduleHelper({
//     String? paymentType,
//     DateTime? dueDate,
//     double? amount,
//   })  : paymentTypeController =
//             TextEditingController(text: paymentType ?? 'Advance'),
//         dueDateController = TextEditingController(
//             text: dueDate != null
//                 ? DateFormat('yyyy-MM-dd').format(dueDate)
//                 : ''),
//         amountController =
//             TextEditingController(text: (amount ?? 0).toString());

//   void dispose() {
//     paymentTypeController.dispose();
//     dueDateController.dispose();
//     amountController.dispose();
//   }
// }

// class CoApplicantHelper {
//   final TextEditingController nameController;
//   final TextEditingController phoneController;
//   final TextEditingController emailController;
//   final TextEditingController dobController;
//   final TextEditingController addressController;

//   CoApplicantHelper({
//     String? name,
//     String? phone,
//     String? email,
//     DateTime? dob,
//     String? address,
//   })  : nameController = TextEditingController(text: name ?? ''),
//         phoneController = TextEditingController(text: phone ?? ''),
//         emailController = TextEditingController(text: email ?? ''),
//         dobController = TextEditingController(
//             text: dob != null ? DateFormat('yyyy-MM-dd').format(dob) : ''),
//         addressController = TextEditingController(text: address ?? '');

//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     dobController.dispose();
//     addressController.dispose();
//   }
// }
