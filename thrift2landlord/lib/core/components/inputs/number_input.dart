part of '../index.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const NumberTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  _NumberTextFieldState createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  String selectedCountryCode = "+234"; // Default country code (Nigeria)
  String selectedCountryFlag = "🇳🇬"; // Default flag (Nigeria)

  void _selectCountry() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      builder: (context) => CountryPickerBottomSheet(),
    );

    if (result != null) {
      setState(() {
        selectedCountryCode = result['code']!;
        selectedCountryFlag = result['flag']!;
      });

      // Ensure the phone number always has the country code
      widget.controller.text =
          "$selectedCountryCode ${widget.controller.text.replaceAll(RegExp(r'^\+\d+\s'), '')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      keyboardType: TextInputType.phone,
      validator: widget.validator,
      prefixIcon: GestureDetector(
        onTap: _selectCountry,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedCountryFlag, style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 4.w),
              Text(
                selectedCountryCode,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryPickerBottomSheet extends StatelessWidget {
  final List<Map<String, String>> countries = [
    {"name": "Nigeria", "code": "+234", "flag": "🇳🇬"},
    {"name": "United States", "code": "+1", "flag": "🇺🇸"},
    {"name": "United Kingdom", "code": "+44", "flag": "🇬🇧"},
    {"name": "India", "code": "+91", "flag": "🇮🇳"},
    {"name": "Canada", "code": "+1", "flag": "🇨🇦"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Country", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12.h),
          ...countries.map((country) => ListTile(
                leading:
                    Text(country["flag"]!, style: TextStyle(fontSize: 24.sp)),
                title: Text(country["name"]!),
                trailing: Text(country["code"]!,
                    style: Theme.of(context).textTheme.bodyLarge),
                onTap: () {
                  Navigator.pop(context, country);
                },
              )),
        ],
      ),
    );
  }
}
