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
    apiKey: 'AIzaSyA_LOY_wG3F8azLC0wwMb0XrBSogrM-OAM',
    appId: '1:294062943565:web:fc0b8fb5b5d9a6ee141b04',
    messagingSenderId: '294062943565',
    projectId: 'sticker-grasser-test',
    authDomain: 'sticker-grasser-test.firebaseapp.com',
    storageBucket: 'sticker-grasser-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6kZsOZcp8gzRusdZYlSCBFa8tkgBPIkE',
    appId: '1:294062943565:android:787cbf3b52650374141b04',
    messagingSenderId: '294062943565',
    projectId: 'sticker-grasser-test',
    storageBucket: 'sticker-grasser-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd8cjpeqVkjL_4YyWBVNBFubre3trxuy8',
    appId: '1:294062943565:ios:e618400eaa96df17141b04',
    messagingSenderId: '294062943565',
    projectId: 'sticker-grasser-test',
    storageBucket: 'sticker-grasser-test.appspot.com',
    iosBundleId: 'com.example.enitProjectApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCd8cjpeqVkjL_4YyWBVNBFubre3trxuy8',
    appId: '1:294062943565:ios:4b0715ce7be38771141b04',
    messagingSenderId: '294062943565',
    projectId: 'sticker-grasser-test',
    storageBucket: 'sticker-grasser-test.appspot.com',
    iosBundleId: 'com.example.enitProjectApp.RunnerTests',
  );
}
