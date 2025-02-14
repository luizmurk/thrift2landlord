import 'package:flutter/material.dart';

import '../components/index.dart';
import '../themes/app_sizes.dart';

class SampleFormScreen extends StatefulWidget {
  @override
  _SampleFormScreenState createState() => _SampleFormScreenState();
}

class _SampleFormScreenState extends State<SampleFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  // Dropdown State
  String? selectedRole;
  final List<String> roles = ["Buyer", "Seller", "Investor"];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      print("Name: ${nameController.text}");
      print("Email: ${emailController.text}");
      print("Number: ${numberController.text}");
      print("Role: $selectedRole");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.primaryPadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Input
            CustomTextField(
              controller: nameController,
              hintText: "Enter your name",
              prefixIcon: Icon(Icons.person),
              validator: (value) =>
                  value!.isEmpty ? "Name cannot be empty" : null,
            ),
            SizedBox(height: AppSizes.primaryGapHeight),

            // Email Input
            EmailTextField(
              controller: emailController,
              hintText: "Enter your email",
            ),
            SizedBox(height: AppSizes.primaryGapHeight),

            // Number Input
            NumberTextField(
              controller: numberController,
              hintText: "Enter your phone number",
            ),
            SizedBox(height: AppSizes.primaryGapHeight),

            // Dropdown
            CustomDropdown(
              value: selectedRole,
              items: roles,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
              labelText: "Select Role",
            ),
            SizedBox(height: AppSizes.primaryGapHeight * 1.5),

            // Submit Button
            CustomPrimaryButton(
              text: "Submit",
              onPressed: () {
                _submitForm();
              },
              isLoading: false,
            )
          ],
        ),
      ),
    );
  }
}
