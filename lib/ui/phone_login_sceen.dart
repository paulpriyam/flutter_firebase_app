import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/verify_code_screen.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/custom_button.dart';
import 'package:flutter_firebase/widgets/custom_text_field.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

final phoneController = TextEditingController();
var _formKey = GlobalKey<FormState>();
final auth = FirebaseAuth.instance;
bool isLoading = false;

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Login"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: CustomTextField(
                myController: phoneController,
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                isPassword: false,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Phone number is empty";
                  } else if (value.length < 10) {
                    return "Enter a valid Phone Number";
                  }
                  return null;
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonTxt(
              isLoading: isLoading,
              buttonText: "Login",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text.toString(),
                      verificationCompleted: (_) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      verificationFailed: (exception) {
                        setState(() {
                          isLoading = false;
                        });
                        Utility()
                            .showToastMessage(exception.code.toString(), true);
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verificationId: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (error) {
                        setState(() {
                          isLoading = false;
                        });
                        Utility().showToastMessage(error.toString(), true);
                      });
                }
              })
        ],
      ),
    );
  }
}
