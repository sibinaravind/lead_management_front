import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';

import 'booking_invoice_generator.dart';

class BookingInvoiceHelper {
  /// Generate and show preview with download option
  static Future<void> generateAndSaveInvoice(
    BuildContext context,
    BookingModel booking,
  ) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Generate PDF
      final result = await BookingInvoiceGenerator.generateInvoice(booking);

      // Close loading
      if (context.mounted) Navigator.of(context).pop();

      // Show preview dialog with download button
      if (context.mounted) {
        await _showPreviewDialog(context, booking, result);
      }
    } catch (e) {
      // Close loading if open
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Show error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Show preview dialog with download and share options
  static Future<void> _showPreviewDialog(
    BuildContext context,
    BookingModel booking,
    dynamic pdfData,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade700,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.receipt_long, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Invoice Preview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // PDF Preview
              Expanded(
                child: kIsWeb
                    ? _buildWebPreview(pdfData)
                    : _buildMobilePreview(pdfData),
              ),

              // Action Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Download Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _downloadPdf(context, booking, pdfData);
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Share Button (Mobile only)
                    if (!kIsWeb)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await _sharePdf(context, booking, pdfData);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),

                    // Print Button
                    if (!kIsWeb) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await _printPdf(context, booking, pdfData);
                          },
                          icon: const Icon(Icons.print),
                          label: const Text('Print'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build web preview using iframe
  static Widget _buildWebPreview(dynamic pdfData) {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf, size: 64, color: Colors.grey.shade600),
            const SizedBox(height: 16),
            Text(
              'PDF Preview',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click Download to save the invoice',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  /// Build mobile preview using PdfPreview widget
  static Widget _buildMobilePreview(dynamic pdfData) {
    return PdfPreview(
      build: (format) async => pdfData.readAsBytes(),
      allowSharing: false,
      allowPrinting: false,
      canChangePageFormat: false,
      canChangeOrientation: false,
      canDebug: false,
    );
  }

  /// Download PDF
  static Future<void> _downloadPdf(
    BuildContext context,
    BookingModel booking,
    dynamic pdfData,
  ) async {
    try {
      if (kIsWeb) {
        // Web: Trigger download again
        await BookingInvoiceGenerator.generateInvoice(booking);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invoice downloaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Mobile: File is already saved, show success
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invoice saved to: ${pdfData.path}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Share PDF
  static Future<void> _sharePdf(
    BuildContext context,
    BookingModel booking,
    dynamic pdfData,
  ) async {
    try {
      await Share.shareXFiles(
        [XFile(pdfData.path)],
        subject: 'Booking Invoice - ${booking.productName}',
        text: 'Please find attached your booking invoice.',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Print PDF
  static Future<void> _printPdf(
    BuildContext context,
    BookingModel booking,
    dynamic pdfData,
  ) async {
    try {
      await Printing.layoutPdf(
        onLayout: (format) async => pdfData.readAsBytes(),
        name: 'booking_invoice_${booking.id}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error printing invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Preview invoice (works on both web and mobile)
  static Future<void> previewInvoice(
    BuildContext context,
    BookingModel booking,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      if (kIsWeb) {
        // On web, just download again (preview not available)
        await BookingInvoiceGenerator.generateInvoice(booking);
        if (context.mounted) Navigator.of(context).pop();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Invoice downloaded. Please check your downloads folder.'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      } else {
        // On mobile, use printing package to preview
        final file = await BookingInvoiceGenerator.generateInvoice(booking);
        if (context.mounted) Navigator.of(context).pop();

        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
          name: 'booking_invoice_${booking.id}.pdf',
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error previewing invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Share invoice (Mobile only - not available on web)
  static Future<void> shareInvoice(
    BuildContext context,
    BookingModel booking,
  ) async {
    if (kIsWeb) {
      // Share not supported on web
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Share feature is not available on web. Use download instead.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final file = await BookingInvoiceGenerator.generateInvoice(booking);
      if (context.mounted) Navigator.of(context).pop();

      // Share the PDF
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Booking Invoice - ${booking.productName}',
        text: 'Please find attached your booking invoice.',
      );
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Print invoice (works on both platforms)
  static Future<void> printInvoice(
    BuildContext context,
    BookingModel booking,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      if (kIsWeb) {
        // On web, generate and the browser will handle print
        await BookingInvoiceGenerator.generateInvoice(booking);
        if (context.mounted) Navigator.of(context).pop();
      } else {
        // On mobile, use printing package
        final file = await BookingInvoiceGenerator.generateInvoice(booking);
        if (context.mounted) Navigator.of(context).pop();

        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
          name: 'booking_invoice_${booking.id}.pdf',
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error printing invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
