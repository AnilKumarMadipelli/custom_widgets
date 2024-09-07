import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final double elevation;
  final String? navigateToScreen;
  final bool showAppBar;
  final Widget? customMenu; // Add a customMenu for large screens

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.actions,
    this.leading,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.navigateToScreen,
    this.showAppBar = true,
    this.customMenu, // Custom menu widget
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return showAppBar
        ? AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading ?? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else if (navigateToScreen != null) {
            Navigator.pushReplacementNamed(context, navigateToScreen!);
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
      actions: screenWidth >= 1200
          ? [
        if (customMenu != null) customMenu!, // Show custom menu for large screens
      ]
          : actions, // Show actions for small screens
    )
        : const SizedBox.shrink(); // Return an empty widget when AppBar is not shown
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
