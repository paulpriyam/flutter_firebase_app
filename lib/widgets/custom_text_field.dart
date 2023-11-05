

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.myController,
      required this.labelText,
      required this.hintText,
      required this.isPassword,
      required this.validate});

  final TextEditingController myController;
  final String labelText;
  final String hintText;
  final bool isPassword;
  String? Function(String?) validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        validator: validate,
        obscureText: isPassword ? true : false,
        controller: myController,
        decoration: InputDecoration(
            prefixIcon: isPassword
                ? const Icon(Icons.password)
                : const Icon(Icons.email),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
      ),
    );
  }
}
