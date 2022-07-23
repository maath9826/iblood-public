import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool isOptional;
  final String? errorMessage;
  final void Function(String)? onChange;

  const CustomField({
    required this.label,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.isOptional = false,
    this.errorMessage,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: isOptional ? label + ' (optional)' : label,
          border: const OutlineInputBorder(),
          errorText: errorMessage),
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: isOptional
          ? (_) => null
          : validator ??
              (value) {
                if (value == null || value.isEmpty) return 'this field is required';
              },
    );
  }
}
