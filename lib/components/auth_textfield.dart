import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  String? Function(String? value)? validator;
  final TextEditingController controller;
  final bool useDefaultValidation;

  AuthTextField({
    super.key,
    required this.hintText,
    required this.obsecureText,
    required this.controller,
    this.validator, // Por padrão, validator é null
    this.useDefaultValidation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        validator: (useDefaultValidation) ? defaultFieldValidator : validator,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }

  String? defaultFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode ser vazio!';
    }
    return null;
  }
}
