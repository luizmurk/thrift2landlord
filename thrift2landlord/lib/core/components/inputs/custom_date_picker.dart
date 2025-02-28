import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select Date',
          border: OutlineInputBorder(),
        ),
        child: Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
