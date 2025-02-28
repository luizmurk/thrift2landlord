class InstallmentPlanModel {
  final int timeFrame;
  final DateTime monthlyPaymentDate;
  final double amount;

  InstallmentPlanModel({
    required this.timeFrame,
    required this.monthlyPaymentDate,
    required this.amount,
  });

  factory InstallmentPlanModel.fromMap(Map<String, dynamic> map) {
    return InstallmentPlanModel(
      timeFrame: map['timeFrame'] ?? 0,
      monthlyPaymentDate: DateTime.parse(
          map['monthlyPaymentDate'] ?? DateTime.now().toIso8601String()),
      amount: (map['amount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeFrame': timeFrame,
      'monthlyPaymentDate': monthlyPaymentDate.toIso8601String(),
      'amount': amount,
    };
  }
}
