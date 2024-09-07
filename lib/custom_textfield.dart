import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved; // Add onSaved callback
  final Color borderColor;
  final Color focusedBorderColor;
  final Color labelColor;
  final Color hintColor;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.onSaved, // Add onSaved parameter
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.labelColor = Colors.black,
    this.hintColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: labelColor),
        hintStyle: TextStyle(color: hintColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor),
        ),
      ),
      validator: validator,
      onSaved: onSaved, // Assign onSaved callback
    );
  }
}
