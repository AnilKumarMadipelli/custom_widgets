import 'package:flutter/material.dart';
import 'custom_text.dart'; // Ensure you import the CustomText widget

class CustomButton extends StatelessWidget {
  final bool? isLoading; // Nullable
  final bool? isEnabled; // Nullable
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon; // Nullable
  final double elevation; // Customizable elevation
  final Color primaryColor; // Customizable primary color
  final Color? iconColor; // Customizable icon color
  final double? iconSize; // Customizable icon size
  final Color? loadingIndicatorColor; // Customizable loading indicator color
  final BorderSide? borderSide; // Customizable border color and width

  const CustomButton({
    Key? key,
    this.isLoading, // Nullable
    this.isEnabled, // Nullable
    this.onPressed,
    required this.text,
    this.icon, // Nullable
    this.elevation = 4.0, // Default elevation value
    this.primaryColor = Colors.blue, // Default primary color
    this.iconColor, // Customizable icon color
    this.iconSize, // Customizable icon size
    this.loadingIndicatorColor, // Customizable loading indicator color
    this.borderSide, // Customizable border color and width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the final enabled state
    final bool finalIsEnabled = isEnabled ?? true;
    final bool finalIsLoading = isLoading ?? false;

    return ElevatedButton(
      onPressed: finalIsEnabled && !finalIsLoading ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          finalIsEnabled ? primaryColor : Colors.grey,
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
            if (states.contains(MaterialState.hovered)) {
              return primaryColor.withOpacity(0.5);
            }
            return null; // Defer to the default
          },
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: borderSide ?? BorderSide.none, // Apply border style
        )),
        elevation: MaterialStateProperty.all(elevation), // Set the elevation here
      ),
      child: finalIsLoading
          ? SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: loadingIndicatorColor ?? Colors.white, // Customize loading indicator color
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? Colors.white, size: iconSize), // Customize icon color and size
            const SizedBox(width: 8),
          ],
          CustomText(
            text,
          ),
        ],
      ),
    );
  }
}
