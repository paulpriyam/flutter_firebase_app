import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    splashService.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is splash screen"),
    );
  }
}
