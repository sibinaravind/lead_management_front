class PaymentScheduleModel {
  String? paymentType;
  DateTime? dueDate;
  double? amount;

  PaymentScheduleModel({
    this.paymentType,
    this.dueDate,
    this.amount,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleModel(
      paymentType: json['payment_type'],
      dueDate:
          json['due_date'] != null ? DateTime.tryParse(json['due_date']) : null,
      amount: (json['amount'] as num?)?.toDouble(),
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
