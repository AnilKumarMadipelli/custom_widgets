import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? heroTag;
  final String? tooltip;
  final double elevation;
  final Color? backgroundColor;
  final Color? iconColor;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.heroTag,
    this.tooltip,
    this.elevation = 2.0, // Default elevation value
    this.backgroundColor,
    this.iconColor,
    this.iconSize = 24.0, // Default icon size
    this.padding = const EdgeInsets.all(8.0), // Default padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Center(
        child: Material(
          color: backgroundColor ?? Colors.transparent,
          elevation: elevation,
          shape: CircleBorder(),
          child: IconButton(
            icon: Icon(icon, color: iconColor ?? Colors.black, size: iconSize),
            onPressed: onPressed,
            padding: padding,
            splashRadius: 24.0, // Adjust splash radius if needed
          ),
        ),
      ),
    );
  }
}
