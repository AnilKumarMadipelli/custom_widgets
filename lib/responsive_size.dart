import 'package:flutter/material.dart';

class ResponsiveUtil {
  static double getHeight(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (screenSize.width <= 600) {
      // Small screens (phones)
      return 50;
    } else if (screenSize.width <= 1200) {
      // Medium screens (tablets)
      return 70;
    } else if (screenSize.width <= 1800) {
      // Large screens (small desktops)
      return 90;
    } else {
      // Web/desktop screens
      return 100;
    }
  }

  static double getWidth(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (screenSize.width <= 600) {
      // Small screens (phones)
      return 100;
    } else if (screenSize.width <= 1200) {
      // Medium screens (tablets)
      return 150;
    } else if (screenSize.width <= 1800) {
      // Large screens (small desktops)
      return 200;
    } else {
      // Web/desktop screens
      return 250;
    }
  }

  /*    final double height = ResponsiveUtil.getHeight(context);
    final double width = ResponsiveUtil.getWidth(context);*/
}
