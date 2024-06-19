// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTXMNFTq3V0gfmAVb2bLOi3bYNPQexzxw',
    appId: '1:1095345467507:web:8f510b18eda0de981d3a06',
    messagingSenderId: '1095345467507',
    projectId: 'fir-lms-ea385',
    authDomain: 'fir-lms-ea385.firebaseapp.com',
    storageBucket: 'fir-lms-ea385.appspot.com',
    measurementId: 'G-KNE8YXBZMC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDg6GDXK6nur8LuVkxPv5f2QZjRbS_ykwk',
    appId: '1:1095345467507:android:59bcade50e1804621d3a06',
    messagingSenderId: '1095345467507',
    projectId: 'fir-lms-ea385',
    storageBucket: 'fir-lms-ea385.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCp4_frK4g-BPdGPi5kz0ai_eHNwOh-x0',
    appId: '1:1095345467507:ios:f0f501fb6e5a5e071d3a06',
    messagingSenderId: '1095345467507',
    projectId: 'fir-lms-ea385',
    storageBucket: 'fir-lms-ea385.appspot.com',
    iosBundleId: 'com.example.firebaseLms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCp4_frK4g-BPdGPi5kz0ai_eHNwOh-x0',
    appId: '1:1095345467507:ios:f0f501fb6e5a5e071d3a06',
    messagingSenderId: '1095345467507',
    projectId: 'fir-lms-ea385',
    storageBucket: 'fir-lms-ea385.appspot.com',
    iosBundleId: 'com.example.firebaseLms',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTXMNFTq3V0gfmAVb2bLOi3bYNPQexzxw',
    appId: '1:1095345467507:web:7c5b6dbe13322b9c1d3a06',
    messagingSenderId: '1095345467507',
    projectId: 'fir-lms-ea385',
    authDomain: 'fir-lms-ea385.firebaseapp.com',
    storageBucket: 'fir-lms-ea385.appspot.com',
    measurementId: 'G-6PDDTTP8T5',
  );
}