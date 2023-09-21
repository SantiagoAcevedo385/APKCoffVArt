import 'package:flutter/material.dart';

class InputCampo extends StatelessWidget {
  const InputCampo({
    Key? key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.style, // Acepta un estilo de texto opcional
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextStyle? style; 
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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