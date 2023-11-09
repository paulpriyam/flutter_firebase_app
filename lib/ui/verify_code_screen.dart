// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/post_screen.dart';
import 'package:flutter_firebase/widgets/custom_button.dart';
import 'package:flutter_firebase/widgets/custom_text_field.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

final codeController = TextEditingController();
bool isLoading = false;
final _auth = FirebaseAuth.instance;
var _fromKey = GlobalKey<FormState>();

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _fromKey,
              child: CustomTextField(
                  myController: codeController,
                  labelText: "Verification COde",
                  hintText: "Enter 6 digit verification code",
                  isPassword: false,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "verification code is empty";
                    } else if (value.length < 6) {
                      return "verification code must be of 6 digit";
                    }
                    return null;
                  })),
          const SizedBox(
            height: 30,
          ),
          CustomButtonTxt(
              isLoading: isLoading,
              buttonText: "Verify",
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                var credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: codeController.text.toString());
                try {
                  await _auth.signInWithCredential(credential);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostScreen()));
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                }
              })
        ],
      ),
    );
  }
}
