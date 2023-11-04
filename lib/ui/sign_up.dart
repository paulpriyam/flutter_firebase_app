import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade200])),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text("Login Up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
