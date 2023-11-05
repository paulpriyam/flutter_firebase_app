import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/post_screen.dart';
import 'package:flutter_firebase/ui/sign_up.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/custom_button.dart';
import 'package:flutter_firebase/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Login Screen",
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
                isLoading: isLoading,
                buttonText: "Login",
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    _auth
                        .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString())
                        .then((value) {
                      setState(() {
                        isLoading = false;
                        Utility().showToastMessage(
                            "${value.user!.email}successfully logged in",
                            false);
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen()));
                    }).onError((error, stackTrace) {
                      setState(() {
                        isLoading = false;
                        Utility().showToastMessage(error.toString(), true);
                      });
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dont't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: const Text("Sign Up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
