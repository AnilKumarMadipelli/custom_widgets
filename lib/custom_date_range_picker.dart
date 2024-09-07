import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTimeRange initialDateRange;
  final ValueChanged<DateTimeRange> onDateRangeSelected;

  CustomDateRangePicker({
    required this.initialDateRange,
    required this.onDateRangeSelected,
  });

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTimeRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange;
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDateRange != null && pickedDateRange != _selectedDateRange) {
      setState(() {
        _selectedDateRange = pickedDateRange;
      });
      widget.onDateRangeSelected(_selectedDateRange);
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
          width = 300;
          height = 60;
        } else if (constraints.maxWidth < 1200) {
          // Medium screens
          width = 400;
          height = 70;
        } else {
          // Large screens and desktops
          width = 500;
          height = 80;
        }

        final double padding = width * 0.05; // Responsive padding
        final double borderRadius = width * 0.03; // Responsive border radius
        final double fontSize = width * 0.04; // Responsive font size

        return GestureDetector(
          onTap: _selectDateRange,
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
                Expanded(
                  child: CustomText(
                    _selectedDateRange == DateTimeRange(start: DateTime(2000), end: DateTime(2100))
                        ? 'Select date range'
                        : '${_selectedDateRange.start.toLocal()} to ${_selectedDateRange.end.toLocal()}',
                    style: TextStyle(fontSize: fontSize),
                    isSmall: false,
                    isHeader: false,
                    isDefault: true,
                    isSelected: false,
                  ),
                ),
                Icon(Icons.calendar_today, size: fontSize),
              ],
            ),
          ),
        );
      },
    );
  }
}
