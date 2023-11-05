import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/login_screen.dart';
import 'package:flutter_firebase/ui/post_screen.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    var user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostScreen()));
      });
    } else {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        timer.cancel();
      });
    }
  }
}
