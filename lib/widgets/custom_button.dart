import 'package:flutter/material.dart';

class CustomButtonTxt extends StatelessWidget {
  final String buttonText;
  VoidCallback onTap;
  bool isLoading;
  CustomButtonTxt(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient:
                LinearGradient(colors: [Colors.blue, Colors.blue.shade200])),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
