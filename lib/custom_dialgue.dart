import 'package:flutter/material.dart';

import 'custom_button.dart';

class ResponsiveDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String? cancelButtonText;
  final String? submitButtonText;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final List<Widget>? additionalActions; // For any additional actions

  const ResponsiveDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelButtonText,
    this.submitButtonText,
    this.onCancel,
    this.onSubmit,
    this.additionalActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600; // Adjust threshold as needed

        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: isWideScreen ? 500 : double.infinity, // Responsive width
            child: content,
          ),
          actions: <Widget>[
            if (cancelButtonText != null)
              CustomButton(
                text: cancelButtonText!,
                onPressed: () {
                  if (onCancel != null) onCancel!();
                  Navigator.of(context).pop();
                },
                primaryColor: Colors.red, // Customize the color if needed
                elevation: 6.0,
              ),
            if (submitButtonText != null)
              CustomButton(
                text: submitButtonText!,
                onPressed: () {
                  if (onSubmit != null) onSubmit!();
                  Navigator.of(context).pop();
                },
                primaryColor: Colors.green, // Customize the color if needed
                elevation: 6.0,
              ),
            if (additionalActions != null) ...additionalActions!,
          ],
        );
      },
    );
  }
}

