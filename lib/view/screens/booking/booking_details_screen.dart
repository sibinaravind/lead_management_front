import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/booking/booking_controller.dart';
import 'add_edit_booking_screen.dart';
import 'widget/add_transaction_popup.dart';
import 'widget/booking_basic_info_tab.dart';
import 'widget/booking_documents_tab.dart';
import 'widget/booking_invoice_usage_helper.dart';
import 'widget/booking_pricing_tab.dart';
import 'widget/booking_payment_tab.dart';
import 'widget/booking_customer_tab.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({
    super.key,
    required this.bookingId,
  });

  final String bookingId;

  @override
  State<BookingDetailsScreen> createState() => _BookingProfileScreenState();
}

class _BookingProfileScreenState extends State<BookingDetailsScreen> {
  final bookingController = Get.find<BookingController>();
  int _selectedTabIndex = 0;
  BookingModel? _booking;
  bool _isLoading = true;
  List<Map<String, dynamic>> _tabs = [];

  @override
  void initState() {
    super.initState();
    _initializeBooking();
  }

  Future<void> _initializeBooking() async {
    await Future.delayed(const Duration(seconds: 1));

    _initializeTabs();
    setState(() {});
  }

  Future<void> _initializeTabs() async {
    _booking = await bookingController.getBookingById(widget.bookingId);

    _tabs = [
      {
        'icon': Icons.info_outline,
        'label': 'Basic Info',
        'widget': BookingBasicInfoTab(booking: _booking ?? BookingModel()),
      },
      {
        'icon': Icons.person,
        'label': 'Details',
        'widget': BookingCustomerTab(booking: _booking ?? BookingModel()),
      },
      {
        'icon': Icons.attach_money,
        'label': 'Pricing',
        'widget': BookingPricingTab(booking: _booking ?? BookingModel()),
      },
      {
        'icon': Icons.payment,
        'label': 'Payments',
        'widget': BookingPaymentsTab(booking: _booking ?? BookingModel()),
      },
      {
        'icon': Icons.description_outlined,
        'label': 'Documents',
        'widget': BookingDocumentsTab(booking: _booking ?? BookingModel()),
      },
    ];
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      backgroundColor: AppColors.backgroundColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withOpacity(0.85),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.book_online,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: _isLoading
                              ? 'Loading...'
                              : _booking?.productName ?? 'Booking Details',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        if (!_isLoading)
                          CustomText(
                            text: 'Booking ID: ${_booking?.bookingId ?? ''}',
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!_isLoading)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomText(
                        text: _booking?.status ?? 'PROCESSING',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    elevation: 8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24,
                    ),
                    onSelected: (value) async {
                      if (value == 'add_transaction') {
                        showDialog(
                          context: context,
                          builder: (context) => AddTransactionPopup(
                            bookingId: _booking?.id ?? '',
                          ),
                        );
                      } else if (value == 'edit_booking') {
                        showDialog(
                          context: context,
                          builder: (context) => AddEditBookingScreen(
                            bookingToEdit: _booking,
                            isViewMode: true,
                          ),
                        );
                      } else if (value == 'download_invoice') {
                        await BookingInvoiceHelper.previewInvoice(
                            context, _booking ?? BookingModel());
                        // await BookingInvoiceHelper.downloadInvoice(
                        //     context, _booking ?? BookingModel());
                      }

                      //  else if (value == 'send_email') {
                      //   await BookingInvoiceHelper.shareInvoice(
                      //       context, _booking ?? BookingModel());
                      // }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'add_transaction',
                        child: Row(
                          children: [
                            Icon(Icons.payment,
                                size: 20, color: AppColors.darkVioletColour),
                            SizedBox(width: 10),
                            CustomText(text: 'Add Transaction'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit_booking',
                        child: Row(
                          children: [
                            Icon(Icons.edit,
                                size: 20, color: AppColors.blueSecondaryColor),
                            SizedBox(width: 10),
                            CustomText(text: 'Edit Booking'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'download_invoice',
                        child: Row(
                          children: [
                            Icon(Icons.download,
                                size: 20, color: AppColors.greenSecondaryColor),
                            SizedBox(width: 10),
                            CustomText(text: 'Download Invoice'),
                          ],
                        ),
                      ),

                      // const PopupMenuItem(
                      //   value: 'send_email',
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.email,
                      //           size: 20,
                      //           color: AppColors.orangeSecondaryColor),
                      //       SizedBox(width: 10),
                      //       CustomText(text: 'Send Email'),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (_, __) => const CustomShimmerWidget(
                          height: 100,
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: isDesktop ? _desktopLayout() : _mobileLayout(),
                  ),
          ],
        ),
      ),
    );
  }

  /// Desktop Layout (Left Tabs + Right Content)
  Widget _desktopLayout() {
    return Row(
      children: [
        Container(
          width: 260,
          color: AppColors.primaryColor,
          child: ListView.builder(
            itemCount: _tabs.length,
            itemBuilder: (_, index) {
              final isSelected = _selectedTabIndex == index;
              return ListTile(
                leading: Icon(
                  _tabs[index]['icon'],
                  color: isSelected ? Colors.white : Colors.white38,
                ),
                title: CustomText(
                  text: _tabs[index]['label'],
                  color: isSelected ? Colors.white : Colors.white38,
                ),
                selected: isSelected,
                selectedTileColor: Colors.white.withOpacity(0.1),
                onTap: () => setState(() => _selectedTabIndex = index),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _tabs[_selectedTabIndex]['widget'],
            ),
          ),
        ),
      ],
    );
  }

  /// Mobile Layout (Horizontal Tabs)
  Widget _mobileLayout() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (_, index) {
                final isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade200,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _tabs[index]['icon'],
                          size: 18,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          text: _tabs[index]['label'],
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _tabs[_selectedTabIndex]['widget'],
            ),
          ),
        ),
      ],
    );
  }
}

// // screens/booking_details_screen.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../model/booking_model/booking_model.dart';

// class BookingDetailsScreen extends StatelessWidget {
//   final BookingModel booking;

//   const BookingDetailsScreen({Key? key, required this.booking})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//     final dateFormat = DateFormat('dd MMM yyyy');

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text('BookingModel Details'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.blue[800],
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               // Navigate to edit screen
//               _navigateToEditScreen(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Card
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           booking.productName,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                         Chip(
//                           label: Text(
//                             booking.grandTotal >= 100000
//                                 ? 'Premium'
//                                 : 'Standard',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           backgroundColor: Colors.blue[700],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'BookingModel ID: ${booking.id.substring(0, 8)}...',
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Customer Information
//             _buildSectionHeader('Customer Information', Icons.person),
//             _buildInfoCard([
//               _buildInfoRow('Name', booking.customerName),
//               _buildInfoRow('Phone', booking.customerPhone),
//               _buildInfoRow('Address', booking.customerAddress),
//             ]),

//             // BookingModel Information
//             _buildSectionHeader(
//                 'BookingModel Information', Icons.calendar_today),
//             _buildInfoCard([
//               _buildInfoRow(
//                   'BookingModel Date', dateFormat.format(booking.bookingDate)),
//               _buildInfoRow('Expected Closure',
//                   dateFormat.format(booking.expectedClosureDate)),
//               _buildInfoRow('Officer ID', booking.officerId),
//             ]),

//             // Travel Details
//             _buildSectionHeader('Travel Details', Icons.flight),
//             _buildInfoCard([
//               _buildInfoRow('Destination', booking.destination),
//               _buildInfoRow('Origin', booking.origin),
//               _buildInfoRow(
//                   'Return Date', dateFormat.format(booking.returnDate)),
//               _buildInfoRow(
//                   'No. of Travellers', booking.noOfTravellers.toString()),
//               _buildInfoRow('Visa Type', booking.visaType),
//               _buildInfoRow('Country', booking.countryApplyingFor),
//             ]),

//             // Financial Details
//             _buildSectionHeader('Financial Details', Icons.attach_money),
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     _buildAmountRow(
//                         'Total Amount', booking.totalAmount, currencyFormat),
//                     _buildAmountRow(
//                         'Discount', -booking.discountAmount, currencyFormat),
//                     _buildAmountRow('GST (${booking.gstPercentage}%)',
//                         booking.gstAmount, currencyFormat),
//                     const Divider(),
//                     _buildAmountRow(
//                         'Grand Total', booking.grandTotal, currencyFormat,
//                         isTotal: true),
//                     const SizedBox(height: 16),
//                     _buildAmountRow('Loan Requested',
//                         booking.loanAmountRequested, currencyFormat),
//                     _buildAmountRow('Paid Amount',
//                         booking.transaction.paidAmount, currencyFormat),
//                     const Divider(),
//                     _buildAmountRow(
//                         'Balance Due',
//                         booking.grandTotal - booking.transaction.paidAmount,
//                         currencyFormat),
//                   ],
//                 ),
//               ),
//             ),

//             // Payment Schedule
//             _buildSectionHeader('Payment Schedule', Icons.schedule),
//             ...booking.paymentSchedule
//                 .map((schedule) => _buildPaymentScheduleCard(
//                     schedule, dateFormat, currencyFormat))
//                 .toList(),

//             // Transaction Details
//             _buildSectionHeader('Transaction Details', Icons.receipt),
//             _buildInfoCard([
//               _buildInfoRow(
//                   'Payment Method', booking.transaction.paymentMethod),
//               _buildInfoRow(
//                   'Transaction ID', booking.transaction.transactionId),
//               _buildInfoRow('Remarks', booking.transaction.remarks),
//             ]),

//             // Offers Applied
//             if (booking.offersApplied.isNotEmpty) ...[
//               _buildSectionHeader('Offers Applied', Icons.local_offer),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: booking.offersApplied
//                     .map(
//                       (offer) => Chip(
//                         label: Text(
//                           '${offer.offerName} - ${currencyFormat.format(offer.discountAmount)}',
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         backgroundColor: Colors.green[100],
//                       ),
//                     )
//                     .toList(),
//               ),
//             ],

//             // Co-Applicants
//             if (booking.coApplicantList.isNotEmpty) ...[
//               _buildSectionHeader('Co-Applicants', Icons.group),
//               ...booking.coApplicantList
//                   .map((coApplicant) =>
//                       _buildCoApplicantCard(coApplicant, dateFormat))
//                   .toList(),
//             ],

//             // Notes
//             if (booking.notes.isNotEmpty) ...[
//               _buildSectionHeader('Notes', Icons.note),
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     booking.notes,
//                     style: const TextStyle(color: Colors.grey[700]),
//                   ),
//                 ),
//               ),
//             ],

//             const SizedBox(height: 30),

//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.picture_as_pdf),
//                     label: const Text('Generate Invoice'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Colors.green[700],
//                     ),
//                     onPressed: () {
//                       _generateInvoice(context);
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     icon: const Icon(Icons.share),
//                     label: const Text('Share'),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       side: BorderSide(color: Colors.blue[700]!),
//                     ),
//                     onPressed: () {
//                       _shareBooking(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.blue[700]),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(List<Widget> children) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: children,
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.grey[800]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAmountRow(String label, double amount, NumberFormat format,
//       {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: isTotal ? Colors.blue[800] : Colors.grey[700],
//             ),
//           ),
//           Text(
//             format.format(amount),
//             style: TextStyle(
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               fontSize: isTotal ? 18 : 16,
//               color: isTotal ? Colors.green[700] : Colors.grey[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentScheduleCard(PaymentSchedule schedule,
//       DateFormat dateFormat, NumberFormat currencyFormat) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Colors.grey[300]!),
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: _getPaymentTypeColor(schedule.paymentType),
//           child: Icon(
//             _getPaymentTypeIcon(schedule.paymentType),
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//         title: Text(
//           schedule.paymentType,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text('Due: ${dateFormat.format(schedule.dueDate)}'),
//         trailing: Text(
//           currencyFormat.format(schedule.amount),
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCoApplicantCard(CoApplicant coApplicant, DateFormat dateFormat) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Colors.grey[300]!),
//       ),
//       child: ListTile(
//         leading: const CircleAvatar(
//           backgroundColor: Colors.blue,
//           child: Icon(Icons.person, color: Colors.white),
//         ),
//         title: Text(
//           coApplicant.name,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(coApplicant.phone),
//             Text('DOB: ${dateFormat.format(coApplicant.dob)}'),
//           ],
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.email, color: Colors.blue),
//           onPressed: () {
//             // Send email to co-applicant
//           },
//         ),
//       ),
//     );
//   }

//   Color _getPaymentTypeColor(String type) {
//     switch (type.toLowerCase()) {
//       case 'advance':
//         return Colors.orange;
//       case 'installment':
//         return Colors.blue;
//       case 'final payment':
//         return Colors.green;
//       default:
//         return Colors.purple;
//     }
//   }

//   IconData _getPaymentTypeIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'advance':
//         return Icons.payments;
//       case 'installment':
//         return Icons.credit_card;
//       case 'final payment':
//         return Icons.check_circle;
//       default:
//         return Icons.money;
//     }
//   }

//   void _navigateToEditScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BookingEditScreen(booking: booking),
//       ),
//     );
//   }

//   void _generateInvoice(BuildContext context) {
//     // Generate invoice logic
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Invoice generated successfully'),
//         backgroundColor: Colors.green[700],
//       ),
//     );
//   }

//   void _shareBooking(BuildContext context) {
//     // Share booking details
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('BookingModel details shared')),
//     );
//   }
// }
