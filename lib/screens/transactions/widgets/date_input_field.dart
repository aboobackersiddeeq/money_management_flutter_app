import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const DateInputField({
    super.key,
    required this.controller,
    this.label = 'Select Date',
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );
      if (picked != null) {
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        // labelText: label,
        hintText: label,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      validator: (value) =>
                      value == null || value.trim().isEmpty  ? "Enter your date" : null,
      onTap: () => _selectDate(context) ,
    );
  }
}
