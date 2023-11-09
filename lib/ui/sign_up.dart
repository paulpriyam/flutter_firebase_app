import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/login_screen.dart';
import 'package:flutter_firebase/ui/phone_login_sceen.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/custom_button.dart';
import 'package:flutter_firebase/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SignUp Screen",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      myController: emailController,
                      labelText: "Email",
                      hintText: "Enter Email Here",
                      isPassword: false,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Email is empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      myController: passwordController,
                      labelText: "Password",
                      hintText: "Enter Passowrd ",
                      isPassword: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Password is empty";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 16,
            ),
            CustomButtonTxt(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  _auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString())
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Utility().showToastMessage(
                        "${value.user!.email} Successfully created", false);
                    Timer(const Duration(seconds: 2), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      isLoading = false;
                    });
                    Utility().showToastMessage(error.toString(), true);
                  });
                }
              },
              isLoading: isLoading,
              buttonText: "Sign Up",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text("Login Up"))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Want to sign in with phone number?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneLoginScreen()));
                    },
                    child: const Text(
                      "Click Here",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
