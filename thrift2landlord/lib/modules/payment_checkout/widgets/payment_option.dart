part of '../index.dart';

class _PaymentOptionsWidget extends StatefulWidget {
  final VoidCallback onFormValidated;
  final String listingId;
  final double listingAmount;

  const _PaymentOptionsWidget({
    required this.onFormValidated,
    required this.listingId,
    required this.listingAmount,
  });

  @override
  __PaymentOptionsWidgetState createState() => __PaymentOptionsWidgetState();
}

class __PaymentOptionsWidgetState extends State<_PaymentOptionsWidget> {
  final _formKey = GlobalKey<FormState>();
  final PaymentCheckoutController controller =
      Get.put(PaymentCheckoutController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.updateListingDetails(widget.listingId, widget.listingAmount);
    return DefaultTabController(
      length: 2,
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            bool isValid = _formKey.currentState?.validate() ?? false;
            if (isValid) {
              widget.onFormValidated();
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              onTap: (index) {
                controller.setIsInstallment(index == 0);
              },
              tabs: [
                Tab(text: "Pay in Installments"),
                Tab(text: "One Time Payment"),
              ],
            ),
            SizedBox(height: AppSizes.primaryGapHeight),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  _buildInstallmentTab(),
                  _buildOneTimePaymentTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstallmentTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSizes.primaryGapHeight),
          _buildSectionTitle("Time Frame/Months"),
          Obx(
            () => CustomDropdown(
              value: controller.installmentMonths.value > 0
                  ? controller.installmentMonths.value.toString()
                  : null,
              items: ["2", "4", "6", "8", "10"],
              onChanged: (value) {
                if (value != null) {
                  controller.updateInstallmentPlan(
                    int.parse(value),
                    controller.monthlyPaymentDate.value ?? DateTime.now(),
                  );
                }
              },
              labelText: "Select Time Frame",
            ),
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          _buildSectionTitle("Monthly Payment Date"),
          SizedBox(height: AppSizes.primaryGapHeight),
          CustomDatePicker(
            selectedDate: DateTime.now(),
            onDateSelected: (date) {
              controller.updateInstallmentPlan(
                controller.installmentMonths.value,
                date,
              );
            },
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          _buildSectionTitle("Amount (Per Installment)"),
          Obx(
            () => CustomTextField(
              controller: TextEditingController(
                text: controller.installmentPaymentPlan.value?.amount
                        .toStringAsFixed(2) ??
                    "0.00",
              ),
              hintText: "Amount",
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOneTimePaymentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Total Amount"),
        Obx(
          () => CustomTextField(
            controller: TextEditingController(
              text: controller.amount.value.toStringAsFixed(2),
            ),
            hintText: "Amount",
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
        ),
        SizedBox(height: AppSizes.secondaryGapHeight),
      ],
    );
  }
}
