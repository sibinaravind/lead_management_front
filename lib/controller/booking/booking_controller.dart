// controller/billing/billing_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/shared/constants.dart';

import '../../core/services/api_service.dart';
import '../../model/booking_model/booking_model.dart';
import '../../view/widgets/widgets.dart';

class BookingController extends GetxController {
  final ApiService _apiService = ApiService();

  // Observables
  var isLoading = false.obs;
  var bookingList = <BookingModel>[].obs;
  var selectedBooking = BookingModel().obs;
  var filteredBookingList = <BookingModel>[].obs;

  // Filters
  var searchQuery = ''.obs;
  var filterStatus = 'ALL'.obs;
  var filterDateFrom = Rx<DateTime?>(null);
  var filterDateTo = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    // fetchBillingList();
  }

//   // Fetch all billing
//   Future<void> fetchBillingList() async {
//     try {
//       isLoading(true);
//       final response = await _apiService.get('/billing');

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.body;
//         billingList.assignAll(
//             data.map((item) => BillingModel.fromJson(item)).toList());
//         applyFilters();
//       }
//     } catch (e) {
//       print('Error fetching billing list: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to load billing data',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }

  // Get billing by ID
  Future<BookingModel?> getBookingById(String id) async {
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().getAllFilterdLeads,
          fromJson: (json) => BookingModel.fromJson(json));
      BookingModel? result;
      response.fold(
        (failure) {
          throw Exception(failure);
        },
        (loadedClients) {
          selectedBooking.value = loadedClients;
          result = loadedClients;
        },
      );
      return result;
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    }
  }

  Future<bool?> createBooking(
      BookingModel booking, BuildContext context) async {
    try {
      final response = await _apiService.postRequest(
        endpoint: Constant().bookingCreate,
        body: booking.toJson()..removeWhere((key, value) => value == null),
        fromJson: (json) => json,
      );
      bool? result = false;
      response.fold(
        (failure) {
          throw failure;
        },
        (booking) {
          Navigator.of(context).pop();
          CustomSnackBar.showMessage("Success", "Booking created successfully",
              backgroundColor: Colors.green);
          result = true;
        },
      );
      return result;
    } catch (e) {
      Navigator.of(context).pop();
      CustomSnackBar.showMessage("Error", e.toString(),
          backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateBooking(
      BuildContext context, BookingModel booking, String id) async {
    try {
      final response = await _apiService.patchRequest(
        endpoint: '${Constant().bookingEdit}/$id',
        body: booking.toJson()..removeWhere((key, value) => value == null),
        fromJson: (json) => json,
      );
      return response.fold(
        (failure) {
          throw failure;
        },
        (createdLead) {
          // // Find the lead in customerMatchingList with the same id and replace it
          // final leadsList = customerMatchingList.value.leads;
          // if (leadsList != null) {
          //   final index = leadsList.indexWhere((l) => l.id == leads.id);
          //   if (index != -1) {
          //     leadsList[index] = leads;
          //     customerMatchingList.refresh();
          //   }
          // }
          Navigator.of(context).pop();
          CustomSnackBar.showMessage("Success", "Booking Updated successfully",
              backgroundColor: Colors.green);
          return true;
        },
      );
    } catch (e) {
      Navigator.of(context).pop();
      CustomSnackBar.showMessage("Error", "$e", backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

//   // Delete billing
//   Future<bool> deleteBilling(String id) async {
//     try {
//       isLoading(true);
//       final response = await _apiService.delete('/billing/$id');

//       if (response.statusCode == 200) {
//         Get.snackbar(
//           'Success',
//           'Billing deleted successfully',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print('Error deleting billing: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to delete billing',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Update payment status
//   Future<bool> updatePaymentStatus({
//     required String billingId,
//     required String paymentId,
//     required String status,
//     String? paymentMethod,
//     String? transactionId,
//   }) async {
//     try {
//       isLoading(true);

//       final updateData = {
//         'payment_id': paymentId,
//         'status': status,
//         if (paymentMethod != null) 'payment_method': paymentMethod,
//         if (transactionId != null) 'transaction_id': transactionId,
//         'paid_at': DateTime.now().toIso8601String(),
//       };

//       final response = await _apiService.put(
//         '/billing/$billingId/payment',
//         updateData,
//       );

//       if (response.statusCode == 200) {
//         // Update local data
//         final index = billingList.indexWhere((b) => b.id == billingId);
//         if (index != -1) {
//           billingList[index].updatePaymentStatus(
//             paymentId,
//             status,
//             paymentMethod: paymentMethod,
//             transactionId: transactionId,
//           );
//           billingList.refresh();
//         }

//         Get.snackbar(
//           'Success',
//           'Payment status updated',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print('Error updating payment: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to update payment',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Apply filters
//   void applyFilters() {
//     filteredBillingList.assignAll(billingList.where((billing) {
//       bool matchesSearch = true;
//       bool matchesStatus = true;
//       bool matchesDate = true;

//       // Search filter
//       if (searchQuery.isNotEmpty) {
//         final query = searchQuery.value.toLowerCase();
//         matchesSearch =
//             billing.customerName?.toLowerCase().contains(query) == true ||
//                 billing.customerPhone?.contains(query) == true ||
//                 billing.productName?.toLowerCase().contains(query) == true;
//       }

//       // Status filter
//       if (filterStatus.value != 'ALL') {
//         matchesStatus =
//             billing.paymentStatus?.toUpperCase() == filterStatus.value;
//       }

//       // Date filter
//       if (filterDateFrom.value != null && filterDateTo.value != null) {
//         if (billing.bookingDate != null) {
//           matchesDate = billing.bookingDate!.isAfter(filterDateFrom.value!) &&
//               billing.bookingDate!.isBefore(filterDateTo.value!);
//         } else {
//           matchesDate = false;
//         }
//       }

//       return matchesSearch && matchesStatus && matchesDate;
//     }).toList());
//   }

//   // Set search query
//   void setSearchQuery(String query) {
//     searchQuery.value = query;
//     applyFilters();
//   }

//   // Set filter status
//   void setFilterStatus(String status) {
//     filterStatus.value = status;
//     applyFilters();
//   }

//   // Set date filter
//   void setDateFilter(DateTime? from, DateTime? to) {
//     filterDateFrom.value = from;
//     filterDateTo.value = to;
//     applyFilters();
//   }

//   // Clear filters
//   void clearFilters() {
//     searchQuery.value = '';
//     filterStatus.value = 'ALL';
//     filterDateFrom.value = null;
//     filterDateTo.value = null;
//     filteredBillingList.assignAll(billingList);
//   }

//   // Get statistics
//   Map<String, dynamic> getStatistics() {
//     double totalRevenue = 0;
//     double pendingAmount = 0;
//     int totalBills = billingList.length;
//     int paidBills = 0;
//     int pendingBills = 0;

//     for (var billing in billingList) {
//       totalRevenue += billing.paidAmount ?? 0;
//       pendingAmount += billing.pendingAmount ?? 0;

//       if (billing.paymentStatus == 'PAID') {
//         paidBills++;
//       } else if (billing.paymentStatus == 'PENDING') {
//         pendingBills++;
//       }
//     }

//     return {
//       'total_revenue': totalRevenue,
//       'pending_amount': pendingAmount,
//       'total_bills': totalBills,
//       'paid_bills': paidBills,
//       'pending_bills': pendingBills,
//       'partial_bills': totalBills - paidBills - pendingBills,
//     };
//   }

//   // Generate invoice number
//   String generateInvoiceNumber() {
//     final now = DateTime.now();
//     final year = now.year.toString().substring(2);
//     final month = now.month.toString().padLeft(2, '0');
//     final day = now.day.toString().padLeft(2, '0');
//     final random = (DateTime.now().millisecondsSinceEpoch % 10000)
//         .toString()
//         .padLeft(4, '0');

//     return 'INV-$year$month$day-$random';
//   }
// }
}
