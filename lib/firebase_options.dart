// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXpQoJBj9vMDbVJf3VOZU6T37pCSfFCVY',
    appId: '1:535870087932:android:af2d8ce3a85847c4deed79',
    messagingSenderId: '535870087932',
    projectId: 'fir-setup-ede6a',
    databaseURL: 'https://fir-setup-ede6a.firebaseio.com',
    storageBucket: 'fir-setup-ede6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGDprmU6JkyMO4kQaucJa2zvtNuHeagbo',
    appId: '1:535870087932:ios:9422a8d40b20f234deed79',
    messagingSenderId: '535870087932',
    projectId: 'fir-setup-ede6a',
    databaseURL: 'https://fir-setup-ede6a.firebaseio.com',
    storageBucket: 'fir-setup-ede6a.appspot.com',
    androidClientId: '535870087932-401ece51m8tueho7pik83qhekldfom2r.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );
}
