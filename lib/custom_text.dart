import 'package:flutter/material.dart';
import 'package:responsive_scafold/responsive_size.dart';

class CustomText extends StatelessWidget {
  final String text; // Make text a required positional parameter
  final bool isHeader;
  final bool isDefault;
  final bool isSmall;
  final bool isSelected;
  final TextStyle? style; // Add a style parameter
  double? screenWidth;

  CustomText(
      this.text, {
        this.isHeader = false,
        this.isDefault = true,
        this.isSmall = false,
        this.isSelected = false,
        this.style, // Initialize style
        this.screenWidth,
      });

  @override
  Widget build(BuildContext context) {
    screenWidth = ResponsiveUtil.getWidth(context);

    TextStyle textStyle;

    if (style != null) {
      textStyle = style!;
    } else if (isHeader) {
      textStyle = Theme.of(context).textTheme.headline6!;
    } else if (isSmall) {
      textStyle = Theme.of(context).textTheme.bodySmall!;
    } else {
      textStyle = Theme.of(context).textTheme.bodyText1!;
    }

    // Adjust text style based on `isSelected`
    textStyle = textStyle.copyWith(
      color: isSelected ? Colors.blue : (isDefault ? Colors.black : Colors.grey),
      fontSize: _getResponsiveFontSize(),
    );

    return Text(
      text,
      style: textStyle,
    );
  }

  double _getResponsiveFontSize() {
    if (screenWidth != null) {
      if (screenWidth! < 600) {
        return isSmall ? 12 : 16;
      } else if (screenWidth! < 1200) {
        return isSmall ? 14 : 18;
      } else {
        return isSmall ? 16 : 20;
      }
    } else {
      // Default responsive sizes for typical screen sizes
      return isSmall ? 12 : 16;
    }
  }
}
