class PaymentModel {
  final String paymentId;
  final double amount;
  final DateTime date;
  final String status;

  PaymentModel({
    required this.paymentId,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      paymentId: map['paymentId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      status: map['status'] ?? 'pending',
    );
  }
}
