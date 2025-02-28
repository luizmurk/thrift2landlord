part of '../index.dart';

class _BankTransferWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Name",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          controller: TextEditingController(),
          hintText: "Enter account name",
          validator: (value) =>
              value!.isEmpty ? "Account name cannot be empty" : null,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Account Number",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          controller: TextEditingController(),
          hintText: "Enter account number",
          validator: (value) =>
              value!.isEmpty ? "Account number cannot be empty" : null,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Bank",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          controller: TextEditingController(),
          hintText: "Enter bank name",
          validator: (value) =>
              value!.isEmpty ? "Bank name cannot be empty" : null,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        Text(
          "Amount",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
        CustomTextField(
          controller: TextEditingController(),
          hintText: "Enter amount",
          validator: (value) =>
              value!.isEmpty ? "Amount cannot be empty" : null,
        ),
        SizedBox(height: AppSizes.primaryGapHeight),
        CustomPrimaryButton(
          text: "Upload Payment Invoice",
          onPressed: () {
            // Handle invoice upload
          },
        ),
      ],
    );
  }
}
