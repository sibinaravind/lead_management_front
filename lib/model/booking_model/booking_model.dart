// models/BookingModel_model.dart
// Removed unused import 'dart:convert';

import 'package:overseas_front_end/model/booking_model/booking_applied_offer_model.dart';
import 'package:overseas_front_end/model/booking_model/co_applicant_model.dart';
import 'package:overseas_front_end/model/booking_model/payment_shedule_model.dart';
import 'package:overseas_front_end/model/booking_model/price_component_model.dart';
import 'package:overseas_front_end/model/booking_model/transaction_model.dart';

class BookingModel {
  String? id;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? officerId;
  String? customerAddress;
  String? productId;
  String? productName;
  DateTime? bookingDate;
  DateTime? expectedClosureDate;
  double? totalAmount;
  double? gstPercentage;
  double? gstAmount;
  double? cgstPercentage;
  double? cgstAmount;
  double? sgstPercentage;
  double? sgstAmount;
  double? grandTotal;
  double? discountAmount;
  TransactionModel? transaction;
  List<BookingAppliedOfferModel>? offersApplied;
  List<PaymentScheduleModel>? paymentSchedule;
  double? loanAmountRequested;
  String? notes;
  String? courseName;
  String? institutionName;
  String? countryApplyingFor;
  String? visaType;
  String? origin;
  String? status;
  String? destination;
  DateTime? returnDate;
  int? noOfTravellers;
  List<CoApplicantModel>? coApplicantList;
  List<PriceComponentModel>? priceComponents;

  BookingModel({
    this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.officerId,
    this.customerAddress,
    this.productId,
    this.productName,
    this.bookingDate,
    this.expectedClosureDate,
    this.totalAmount,
    this.gstPercentage,
    this.gstAmount,
    this.cgstPercentage,
    this.cgstAmount,
    this.sgstPercentage,
    this.sgstAmount,
    this.grandTotal,
    this.discountAmount,
    this.transaction,
    this.offersApplied,
    this.paymentSchedule,
    this.loanAmountRequested,
    this.notes,
    this.courseName,
    this.institutionName,
    this.countryApplyingFor,
    this.visaType,
    this.origin,
    this.status,
    this.destination,
    this.returnDate,
    this.noOfTravellers,
    this.coApplicantList,
    this.priceComponents,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      officerId: json['officer_id'],
      customerAddress: json['customer_address'],
      productId: json['product_id'],
      status: json['status'],
      productName: json['product_name'],
      bookingDate: json['booking_date'] != null
          ? DateTime.tryParse(json['booking_date'])
          : null,
      expectedClosureDate: json['expected_closure_date'] != null
          ? DateTime.tryParse(json['expected_closure_date'])
          : null,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      gstPercentage: (json['gst_percentage'] as num?)?.toDouble(),
      gstAmount: (json['gst_amount'] as num?)?.toDouble(),
      cgstPercentage: (json['cgst_percentage'] as num?)?.toDouble(),
      cgstAmount: (json['cgst_amount'] as num?)?.toDouble(),
      sgstPercentage: (json['sgst_percentage'] as num?)?.toDouble(),
      sgstAmount: (json['sgst_amount'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      transaction: json['transaction'] != null
          ? TransactionModel.fromJson(json['transaction'])
          : null,
      offersApplied: json['offers_applied'] != null
          ? List<BookingAppliedOfferModel>.from(json['offers_applied']
              .map((x) => BookingAppliedOfferModel.fromJson(x)))
          : null,
      paymentSchedule: json['payment_schedule'] != null
          ? List<PaymentScheduleModel>.from(json['payment_schedule']
              .map((x) => PaymentScheduleModel.fromJson(x)))
          : null,
      loanAmountRequested: (json['loan_amount_requested'] as num?)?.toDouble(),
      notes: json['notes'],
      courseName: json['course_name'],
      institutionName: json['institution_name'],
      countryApplyingFor: json['country_applying_for'],
      visaType: json['visa_type'],
      origin: json['origin'],
      destination: json['destination'],
      returnDate: json['return_date'] != null
          ? DateTime.tryParse(json['return_date'])
          : null,
      noOfTravellers: json['no_of_travellers'],
      priceComponents: json['price_components'] != null
          ? List<PriceComponentModel>.from(json['price_components']
              .map((x) => PriceComponentModel.fromJson(x)))
          : null,
      coApplicantList: json['co_applicant_list'] != null
          ? List<CoApplicantModel>.from(json['co_applicant_list']
              .map((x) => CoApplicantModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'officer_id': officerId,
      'customer_address': customerAddress,
      'product_id': productId,
      'status': status,
      'product_name': productName,
      'booking_date': bookingDate?.toIso8601String(),
      'expected_closure_date': expectedClosureDate?.toIso8601String(),
      'total_amount': totalAmount,
      'gst_percentage': gstPercentage,
      'gst_amount': gstAmount,
      'cgst_percentage': cgstPercentage,
      'cgst_amount': cgstAmount,
      'sgst_percentage': sgstPercentage,
      'sgst_amount': sgstAmount,
      'grand_total': grandTotal,
      'discount_amount': discountAmount,
      'transaction': transaction?.toJson(),
      'offers_applied': offersApplied?.map((x) => x.toJson()).toList(),
      'payment_schedule': paymentSchedule?.map((x) => x.toJson()).toList(),
      'loan_amount_requested': loanAmountRequested,
      'notes': notes,
      'course_name': courseName,
      'institution_name': institutionName,
      'country_applying_for': countryApplyingFor,
      'visa_type': visaType,
      'origin': origin,
      'destination': destination,
      'return_date': returnDate?.toIso8601String(),
      'no_of_travellers': noOfTravellers,
      'co_applicant_list': coApplicantList?.map((x) => x.toJson()).toList(),
      'price_components': priceComponents?.map((x) => x.toJson()).toList(),
    };
  }
}
