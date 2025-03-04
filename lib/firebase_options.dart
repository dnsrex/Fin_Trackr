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
    apiKey: 'AIzaSyC-yxCuXcRpVP9KeABbq34ztIvPB5u3v1c',
    appId: '1:880934070854:web:190053a2ff3db34c747847',
    messagingSenderId: '880934070854',
    projectId: 'fin-track-9321d',
    authDomain: 'fin-track-9321d.firebaseapp.com',
    storageBucket: 'fin-track-9321d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAl5gS1mipqbWPbN2PIEjE7Zyd7UL3IBz8',
    appId: '1:880934070854:android:76c673eeed730b56747847',
    messagingSenderId: '880934070854',
    projectId: 'fin-track-9321d',
    storageBucket: 'fin-track-9321d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiLMATDpk7jrrXl-FW5DPMZ90ySlLpLKs',
    appId: '1:880934070854:ios:c52276291bdf771c747847',
    messagingSenderId: '880934070854',
    projectId: 'fin-track-9321d',
    storageBucket: 'fin-track-9321d.appspot.com',
    iosClientId: '880934070854-b775nan7pfiu5pg8f86d42k63hpq517t.apps.googleusercontent.com',
    iosBundleId: 'com.example.finTrackr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAiLMATDpk7jrrXl-FW5DPMZ90ySlLpLKs',
    appId: '1:880934070854:ios:fcbef02a2c70f420747847',
    messagingSenderId: '880934070854',
    projectId: 'fin-track-9321d',
    storageBucket: 'fin-track-9321d.appspot.com',
    iosClientId: '880934070854-r81q2mrehqbv6bkjiras0h6phc9ambkf.apps.googleusercontent.com',
    iosBundleId: 'com.example.finTrackr.RunnerTests',
  );
}