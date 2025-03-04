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
    apiKey: 'AIzaSyAHB8bFVoqxCFq1K7WLIBdyW542hOFJf9M',
    appId: '1:356244775603:web:87cfa0e380fc43131f06c6',
    messagingSenderId: '356244775603',
    projectId: 'taskproject-cf711',
    authDomain: 'taskproject-cf711.firebaseapp.com',
    storageBucket: 'taskproject-cf711.appspot.com',
    measurementId: 'G-8MG0W0HWZZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARz1NpS9yR8PvGfUvx0EzQl_Yc4StdaR8',
    appId: '1:356244775603:android:47b370872709a16c1f06c6',
    messagingSenderId: '356244775603',
    projectId: 'taskproject-cf711',
    storageBucket: 'taskproject-cf711.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgGxHAOYnD4UYfhs9AFEKyb-O12SQm_ao',
    appId: '1:356244775603:ios:25755bee97b4a00e1f06c6',
    messagingSenderId: '356244775603',
    projectId: 'taskproject-cf711',
    storageBucket: 'taskproject-cf711.appspot.com',
    iosBundleId: 'com.example.taskproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgGxHAOYnD4UYfhs9AFEKyb-O12SQm_ao',
    appId: '1:356244775603:ios:25755bee97b4a00e1f06c6',
    messagingSenderId: '356244775603',
    projectId: 'taskproject-cf711',
    storageBucket: 'taskproject-cf711.appspot.com',
    iosBundleId: 'com.example.taskproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHB8bFVoqxCFq1K7WLIBdyW542hOFJf9M',
    appId: '1:356244775603:web:2b1b10ae97ff03e21f06c6',
    messagingSenderId: '356244775603',
    projectId: 'taskproject-cf711',
    authDomain: 'taskproject-cf711.firebaseapp.com',
    storageBucket: 'taskproject-cf711.appspot.com',
    measurementId: 'G-9BSZ4Y5BHL',
  );
}
