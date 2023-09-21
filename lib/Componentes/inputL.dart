import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  const InputComponent(
      {Key? key,
      required this.label,
      required this.controller,
      this.value,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.validator})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? value;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value == '' ? null : value,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
      validator: validator,
    );
  }
}
