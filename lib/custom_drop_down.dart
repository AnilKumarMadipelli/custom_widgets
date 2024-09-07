import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomPopupMenu<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final TextStyle selectedItemStyle;
  final TextStyle unselectedItemStyle;
  final Color borderColor;

  CustomPopupMenu({
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.hint,
    this.selectedItemStyle = const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    this.unselectedItemStyle = const TextStyle(color: Colors.black),
    this.borderColor = Colors.grey,
  });

  @override
  _CustomPopupMenuState<T> createState() => _CustomPopupMenuState<T>();
}

class _CustomPopupMenuState<T> extends State<CustomPopupMenu<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
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

        return GestureDetector(
          onTap: () => _showPopupMenu(context, width),
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  _selectedItem?.toString() ?? widget.hint ?? 'Select an item',
                  style: _selectedItem == null ? widget.unselectedItemStyle : widget.selectedItemStyle,
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPopupMenu(BuildContext context, double width) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double height = renderBox.size.height;

    final T? selected = await showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + height,
        offset.dx + width,
        offset.dy,
      ),
      items: widget.items.map((T item) {
        final isSelected = item == _selectedItem;
        return PopupMenuItem<T>(
          value: item,
          child: SizedBox(
            width: width,
            child: CustomText(
              item.toString(),
              style: isSelected ? widget.selectedItemStyle : widget.unselectedItemStyle,
            ),
          ),
        );
      }).toList(),
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: 300, // You can set a max height for the menu
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedItem = selected;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(selected);
      }
    }
  }
}
