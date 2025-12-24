// services/booking_invoice_generator.dart
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';

class BookingInvoiceGenerator {
  static Future<dynamic> generateInvoice(BookingModel booking) async {
    final pdf = pw.Document();

    // Add pages
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildHeader(booking),
          pw.SizedBox(height: 20),
          _buildCompanyAndCustomerInfo(booking),
          pw.SizedBox(height: 20),
          _buildProductInfo(booking),
          pw.SizedBox(height: 20),
          _buildPriceComponents(booking),
          pw.SizedBox(height: 20),
          _buildFinancialSummary(booking),
          pw.SizedBox(height: 20),
          _buildPaymentSchedule(booking),
          pw.SizedBox(height: 20),
          _buildPaymentSummary(booking),
          pw.SizedBox(height: 20),
          _buildTermsAndConditions(),
          pw.SizedBox(height: 20),
          _buildFooter(),
        ],
      ),
    );

    final bytes = await pdf.save();

    if (kIsWeb) {
      // For Web: Download using browser
      return _downloadOnWeb(bytes, booking);
    } else {
      // For Mobile: Save to file
      return _saveOnMobile(bytes, booking);
    }
  }

  // Web download
  static void _downloadOnWeb(List<int> bytes, BookingModel booking) {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download',
          'booking_invoice_${booking.id ?? DateTime.now().millisecondsSinceEpoch}.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  // Mobile save
  static Future<File> _saveOnMobile(
      List<int> bytes, BookingModel booking) async {
    final output = await getTemporaryDirectory();
    final file = File(
        '${output.path}/booking_invoice_${booking.id ?? DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  static String _formatCurrency(double? amount) {
    if (amount == null) return 'Rs. 0.00';
    return 'Rs. ${amount.toStringAsFixed(2)}';
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date);
  }

  static pw.Widget _buildHeader(BookingModel booking) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [PdfColors.purple700, PdfColors.purple500],
        ),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'BOOKING INVOICE',
            style: const pw.TextStyle(
              fontSize: 28,
              color: PdfColors.white,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            'Tax Invoice',
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.white,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildCompanyAndCustomerInfo(BookingModel booking) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Company Info
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'FROM',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Your Company Name',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 4),
                pw.Text('MG Road, Kozhikode',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.Text('Kerala - 673001',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 4),
                pw.Text('Phone: +91 XXX XXX XXXX',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.Text('Email: info@company.com',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.Text('GSTIN: 32XXXXXXXXXXXXX',
                    style: const pw.TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
        pw.SizedBox(width: 20),
        // Customer Info
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'BILL TO',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  booking.customerName ?? 'N/A',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 4),
                pw.Text(booking.customerAddress ?? 'N/A',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 4),
                pw.Text('Phone: ${booking.customerPhone ?? "N/A"}',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Invoice Date:',
                            style: const pw.TextStyle(
                                fontSize: 9, color: PdfColors.grey600)),
                        pw.Text(_formatDate(booking.bookingDate),
                            style: const pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Due Date:',
                            style: const pw.TextStyle(
                                fontSize: 9, color: PdfColors.grey600)),
                        pw.Text(_formatDate(booking.expectedClosureDate),
                            style: const pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildProductInfo(BookingModel booking) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.blue200),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Product/Service',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                booking.productName ?? 'N/A',
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blue900,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Booking ID',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                booking.id ?? 'N/A',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPriceComponents(BookingModel booking) {
    if (booking.priceComponents == null || booking.priceComponents!.isEmpty) {
      return pw.SizedBox();
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PRICE BREAKDOWN',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.purple700,
          ),
        ),
        pw.SizedBox(height: 10),
        ...booking.priceComponents!.map((component) {
          // Calculate component totals
          final baseAmount = component.amount ?? 0;
          double totalDiscount = 0;
          if (component.offersApplied != null) {
            for (var offer in component.offersApplied!) {
              totalDiscount += offer.discountAmount ?? 0;
            }
          }
          final afterDiscount = baseAmount - totalDiscount;
          final gst = (afterDiscount * (component.gstPercent ?? 0)) / 100;
          final cgst = (afterDiscount * (component.cgstPercent ?? 0)) / 100;
          final sgst = (afterDiscount * (component.sgstPercent ?? 0)) / 100;
          final componentTotal = afterDiscount + gst + cgst + sgst;

          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      component.title ?? 'Component',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                    pw.Text(
                      _formatCurrency(componentTotal),
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.green700,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 4),
                _buildDetailRow('Base Amount', _formatCurrency(baseAmount)),
                if (totalDiscount > 0) ...[
                  _buildDetailRow('Discount', _formatCurrency(-totalDiscount),
                      isNegative: true),
                  _buildDetailRow(
                      'After Discount', _formatCurrency(afterDiscount)),
                ],
                _buildDetailRow(
                    'GST (${component.gstPercent}%)', _formatCurrency(gst)),
                _buildDetailRow(
                    'CGST (${component.cgstPercent}%)', _formatCurrency(cgst)),
                _buildDetailRow(
                    'SGST (${component.sgstPercent}%)', _formatCurrency(sgst)),

                // Offers applied
                if (component.offersApplied != null &&
                    component.offersApplied!.isNotEmpty) ...[
                  pw.SizedBox(height: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.orange50,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Applied Offers:',
                          style: const pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.orange900,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        ...component.offersApplied!.map(
                          (offer) => pw.Padding(
                            padding: const pw.EdgeInsets.only(top: 2),
                            child: pw.Text(
                              '- ${offer.offerName ?? "Discount"}: ${_formatCurrency(offer.discountAmount)}',
                              style: const pw.TextStyle(
                                  fontSize: 8, color: PdfColors.orange900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  static pw.Widget _buildDetailRow(String label, String value,
      {bool isNegative = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 9,
              color: isNegative ? PdfColors.red700 : PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFinancialSummary(BookingModel booking) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.blue200, width: 1.5),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'FINANCIAL SUMMARY',
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.purple700,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Divider(color: PdfColors.blue200),
          pw.SizedBox(height: 6),
          _buildSummaryRow(
              'Total Amount', _formatCurrency(booking.totalAmount)),
          _buildSummaryRow(
              'Total Discount', _formatCurrency(-(booking.discountAmount ?? 0)),
              isNegative: true),
          _buildSummaryRow('Total GST', _formatCurrency(booking.gstAmount)),
          _buildSummaryRow('Total CGST', _formatCurrency(booking.cgstAmount)),
          _buildSummaryRow('Total SGST', _formatCurrency(booking.sgstAmount)),
          pw.SizedBox(height: 6),
          pw.Divider(color: PdfColors.blue200),
          pw.SizedBox(height: 6),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'GRAND TOTAL',
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.purple900,
                ),
              ),
              pw.Text(
                _formatCurrency(booking.grandTotal),
                style: const pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.green700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryRow(String label, String value,
      {bool isNegative = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 10,
              color: isNegative ? PdfColors.red700 : PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentSchedule(BookingModel booking) {
    if (booking.paymentSchedule == null || booking.paymentSchedule!.isEmpty) {
      return pw.SizedBox();
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PAYMENT SCHEDULE',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.purple700,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
            4: const pw.FlexColumnWidth(2),
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.purple700),
              children: [
                _buildTableHeader('#'),
                _buildTableHeader('Payment Type'),
                _buildTableHeader('Due Date'),
                _buildTableHeader('Amount'),
                _buildTableHeader('Status'),
              ],
            ),
            // Rows
            ...booking.paymentSchedule!.asMap().entries.map((entry) {
              final index = entry.key;
              final payment = entry.value;
              final isPending = true; // TODO: Add payment status logic

              return pw.TableRow(
                decoration: pw.BoxDecoration(
                  color: index % 2 == 0 ? PdfColors.grey50 : PdfColors.white,
                ),
                children: [
                  _buildTableCell((index + 1).toString()),
                  _buildTableCell(payment.paymentType ?? 'N/A'),
                  _buildTableCell(_formatDate(payment.dueDate)),
                  _buildTableCell(_formatCurrency(payment.amount)),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color:
                            isPending ? PdfColors.orange50 : PdfColors.green50,
                        borderRadius: pw.BorderRadius.circular(4),
                        border: pw.Border.all(
                          color: isPending
                              ? PdfColors.orange300
                              : PdfColors.green300,
                        ),
                      ),
                      child: pw.Text(
                        isPending ? 'PENDING' : 'PAID',
                        style: pw.TextStyle(
                          fontSize: 8,
                          color: isPending
                              ? PdfColors.orange900
                              : PdfColors.green900,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(
          fontSize: 10,
          color: PdfColors.white,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildPaymentSummary(BookingModel booking) {
    // Calculate totals
    double totalScheduled = 0;
    if (booking.paymentSchedule != null) {
      for (var payment in booking.paymentSchedule!) {
        totalScheduled += payment.amount ?? 0;
      }
    }
    final initialPaid = booking.transaction?.paidAmount ?? 0;
    final totalPaid = totalScheduled + initialPaid;
    final grandTotal = booking.grandTotal ?? 0;
    final balance = grandTotal - totalPaid;

    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [PdfColors.orange50, PdfColors.orange100],
        ),
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.orange300, width: 1.5),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'PAYMENT SUMMARY',
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.orange900,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Divider(color: PdfColors.orange300),
          pw.SizedBox(height: 6),
          _buildPaymentSummaryRow(
              'Initial Payment', _formatCurrency(initialPaid)),
          _buildPaymentSummaryRow(
              'Scheduled Payments', _formatCurrency(totalScheduled)),
          _buildPaymentSummaryRow('Total Paid', _formatCurrency(totalPaid)),
          pw.SizedBox(height: 6),
          pw.Divider(color: PdfColors.orange300),
          pw.SizedBox(height: 6),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'BALANCE DUE',
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.orange900,
                ),
              ),
              pw.Text(
                _formatCurrency(balance),
                style: pw.TextStyle(
                  fontSize: 16,
                  color: balance > 0 ? PdfColors.red700 : PdfColors.green700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPaymentSummaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  static pw.Widget _buildTermsAndConditions() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'TERMS & CONDITIONS',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            '- Payment should be made as per the schedule mentioned above.\n'
            '- Late payment charges may apply for overdue amounts.\n'
            '- All prices are inclusive of applicable taxes.\n'
            '- Refunds and cancellations are subject to company policy.\n'
            '- Please retain this invoice for your records.',
            style: const pw.TextStyle(fontSize: 8, height: 1.5),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey400),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Thank you for your business!',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.purple700,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'For any queries, please contact us at info@company.com',
                  style:
                      const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Authorized Signature',
                  style:
                      const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(
                    border:
                        pw.Border(top: pw.BorderSide(color: PdfColors.grey400)),
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'This is a computer-generated invoice and does not require a physical signature.',
          style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey600),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }
}
