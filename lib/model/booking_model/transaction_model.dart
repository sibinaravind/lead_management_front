class TransactionModel {
  double? paidAmount;
  String? paymentMethod;
  String? transactionId;
  String? remarks;

  TransactionModel({
    this.paidAmount,
    this.paymentMethod,
    this.transactionId,
    this.remarks,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paid_amount': paidAmount,
      'payment_method': paymentMethod,
      'transaction_id': transactionId,
      'remarks': remarks,
    };
  }
}
