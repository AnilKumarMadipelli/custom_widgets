import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  CustomDatePicker({
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        if (constraints.maxWidth < 600) {
          // Mobile small screens
          width = 200;
          height = 50;
        } else if (constraints.maxWidth < 1200) {
          // Medium screens
          width = 300;
          height = 60;
        } else {
          // Large screens and desktops
          width = 400;
          height = 70;
        }

        final double padding = width * 0.05; // Responsive padding
        final double borderRadius = width * 0.03; // Responsive border radius
        final double fontSize = width * 0.04; // Responsive font size

        return GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomText(
                  '${_selectedDate.toLocal()}'.split(' ')[0], // Display the date
                  style: TextStyle(fontSize: fontSize),
                ),
                Icon(Icons.calendar_today, size: fontSize * 1.5),
              ],
            ),
          ),
        );
      },
    );
  }
}
