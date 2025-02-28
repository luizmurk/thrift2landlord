part of '../index.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final List<PaymentModel> paymentHistory;
  final double completionPercentage;
  final int monthsLeft;
  final bool isComplete;

  const PaymentHistoryWidget({
    super.key,
    required this.paymentHistory,
    required this.completionPercentage,
    required this.monthsLeft,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.primaryRadius)),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Progress',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: AppSizes.primaryGapHeight),

            // Progress Bar
            LinearProgressIndicator(
              value: completionPercentage / 100,
              backgroundColor: AppColors.offWhite,
              color: AppColors.primary,
              minHeight: AppSizes.mediumGap,
            ),
            SizedBox(height: AppSizes.primaryGapHeight),

            // Months Left & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$monthsLeft months left',
                    style: Theme.of(context).textTheme.bodyLarge),
                if (completionPercentage < 100)
                  Text('${completionPercentage.toStringAsFixed(0)}% Completed',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.primary))
              ],
            ),

            Divider(height: AppSizes.primaryGapHeight * 2),

            // Payment History List
            Text('Payment History',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: AppSizes.primaryGapHeight),

            if (paymentHistory.isEmpty)
              Center(child: Text('No payments made yet'))
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: paymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = paymentHistory[index];
                  return ListTile(
                    leading: Icon(
                      payment.status == 'successful'
                          ? Icons.check_circle
                          : Icons.pending,
                      color: payment.status == 'successful'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    title: Text(
                        '\$${payment.amount.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'),
                    subtitle:
                        Text(payment.date.toLocal().toString().split(' ')[0]),
                    trailing: Text(payment.status.capitalizeFirst ?? ''),
                  );
                },
              ),

            if (!isComplete) SizedBox(height: AppSizes.primaryGapHeight * 2),

            // Make Payment Button (only if not complete)
            if (!isComplete)
              CustomPrimaryButton(
                onPressed: () {
                  // Payment logic here
                },
                text: 'Make Payment',
              ),
          ],
        ),
      ),
    );
  }
}
