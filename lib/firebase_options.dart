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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAHU1iUtEBO8psIe0Nsc4cyA9GAjPXnU-0',
    appId: '1:1098586347627:web:81af4d311214704331792e',
    messagingSenderId: '1098586347627',
    projectId: 'almanac-of-wisdom',
    authDomain: 'almanac-of-wisdom.firebaseapp.com',
    storageBucket: 'almanac-of-wisdom.appspot.com',
    measurementId: 'G-BQ5WZ5TP0R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaTG4fH4yI_FHvxIsTXqSUTHaBVof0jxU',
    appId: '1:1098586347627:android:03614c11a1cb4b4731792e',
    messagingSenderId: '1098586347627',
    projectId: 'almanac-of-wisdom',
    storageBucket: 'almanac-of-wisdom.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLDJV_vuuuDaHI6l8omb6yVdKCaje8TPs',
    appId: '1:1098586347627:ios:b890576aa6c6fc9831792e',
    messagingSenderId: '1098586347627',
    projectId: 'almanac-of-wisdom',
    storageBucket: 'almanac-of-wisdom.appspot.com',
    iosBundleId: 'com.example.almanacOfWisdom',
  );
}
