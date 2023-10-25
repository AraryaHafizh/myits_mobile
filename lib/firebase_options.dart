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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCVpEIlI-2PlWPrz4Ebm7ymTtdDif_j-UY',
    appId: '1:182633516681:web:f50384145302c4e05d0058',
    messagingSenderId: '182633516681',
    projectId: 'myits-mobile',
    authDomain: 'myits-mobile.firebaseapp.com',
    databaseURL: 'https://myits-mobile-default-rtdb.firebaseio.com',
    storageBucket: 'myits-mobile.appspot.com',
    measurementId: 'G-FR0ZH6G7Q4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTFpq7fZ44m6NTZZCwukFfMZWHThyYX7g',
    appId: '1:182633516681:android:ddce32406b9a7ea05d0058',
    messagingSenderId: '182633516681',
    projectId: 'myits-mobile',
    databaseURL: 'https://myits-mobile-default-rtdb.firebaseio.com',
    storageBucket: 'myits-mobile.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALu9cn0QPVP_UZhF7h8Di45O9Ei0Zyo7s',
    appId: '1:182633516681:ios:2ae66a539c8704d15d0058',
    messagingSenderId: '182633516681',
    projectId: 'myits-mobile',
    databaseURL: 'https://myits-mobile-default-rtdb.firebaseio.com',
    storageBucket: 'myits-mobile.appspot.com',
    iosBundleId: 'com.example.myitsPortall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALu9cn0QPVP_UZhF7h8Di45O9Ei0Zyo7s',
    appId: '1:182633516681:ios:248e27779870eb925d0058',
    messagingSenderId: '182633516681',
    projectId: 'myits-mobile',
    databaseURL: 'https://myits-mobile-default-rtdb.firebaseio.com',
    storageBucket: 'myits-mobile.appspot.com',
    iosBundleId: 'com.example.myitsPortall.RunnerTests',
  );
}
