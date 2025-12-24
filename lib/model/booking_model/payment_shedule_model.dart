import 'package:overseas_front_end/utils/functions/format_date.dart';

class PaymentScheduleModel {
  String? paymentType;
  DateTime? dueDate;
  double? amount;
  String? status;
  double? paidAmount;
  String? paidAt;

  PaymentScheduleModel({
    this.paymentType,
    this.dueDate,
    this.amount,
    this.status,
    this.paidAmount,
    this.paidAt,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleModel(
      paymentType: json['payment_type'],
      dueDate:
          json['due_date'] != null ? DateTime.tryParse(json['due_date']) : null,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'],
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      paidAt:
          json['paid_at'] != null ? formatDatetoString(json['paid_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_type': paymentType,
      'due_date': dueDate?.toIso8601String(),
      'amount': amount,
    };
  }
}
