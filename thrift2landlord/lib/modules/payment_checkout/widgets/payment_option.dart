part of '../index.dart';

class _PaymentOptionsWidget extends StatefulWidget {
  final VoidCallback onFormValidated;
  final String? amount;

  const _PaymentOptionsWidget({
    required this.onFormValidated,
    required this.amount,
  });

  @override
  __PaymentOptionsWidgetState createState() => __PaymentOptionsWidgetState();
}

class __PaymentOptionsWidgetState extends State<_PaymentOptionsWidget> {
  final _formKey = GlobalKey<FormState>();
  String? selectedTimeFrame;
  DateTime? selectedDate;
  String? amount;
  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // ✅ Wrap with DefaultTabController
      length: 2,
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            _isFormValid = _formKey.currentState?.validate() ?? false;
            if (_isFormValid) {
              widget.onFormValidated();
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              tabs: [
                Tab(text: "Pay in Installments"),
                Tab(text: "One Time Payment"),
              ],
            ),
            SizedBox(height: AppSizes.primaryGapHeight),
            SizedBox(
              height: 300, // Ensure height is set to prevent layout errors
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
          CustomDropdown(
            value: selectedTimeFrame,
            items: ["2", "4", "6", "8", "10"],
            onChanged: (value) {
              setState(() {
                selectedTimeFrame = value.toString();
              });
            },
            labelText: "Select Time Frame",
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          _buildSectionTitle("Monthly Payment Date"),
          SizedBox(height: AppSizes.primaryGapHeight),
          CustomDatePicker(
            selectedDate: selectedDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
          _buildSectionTitle("Amount"),
          CustomTextField(
            controller: TextEditingController(text: amount),
            hintText: "Enter amount",
            validator: (value) =>
                value!.isEmpty ? "Amount cannot be empty" : null,
            onChanged: (value) {
              setState(() {
                amount = value;
              });
            },
          ),
          SizedBox(height: AppSizes.primaryGapHeight),
        ],
      ),
    );
  }

  Widget _buildOneTimePaymentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Amount"),
        CustomTextField(
          controller: TextEditingController(text: widget.amount.toString()),
          hintText: "Enter amount",
          validator: (value) =>
              value!.isEmpty ? "Amount cannot be empty" : null,
          onChanged: (value) {
            setState(() {
              amount = value;
            });
          },
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
