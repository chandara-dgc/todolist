import 'package:check_list_app/config/flavors.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  final Flavor flavor;
  DefaultFirebaseOptions({required this.flavor});

  FirebaseOptions getFirebaseOptions() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidFlavor();
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  FirebaseOptions _androidFlavor() {
    switch (flavor) {
      case Flavor.dev:
      case Flavor.staging:
        return androidDev;
      case Flavor.prod:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this flavor.',
        );
    }
  }

  static const FirebaseOptions androidDev = FirebaseOptions(
    apiKey: 'AIzaSyCXo9LWJ8QMagEHOwy1552GoYxfy_EDqac',
    appId: '1:973087984612:android:b000275fae3f8faacd15f1',
    messagingSenderId: '973087984612',
    projectId: 'check-list-app-dev-e3775',
    storageBucket: 'check-list-app-dev-e3775.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDScCL1eQh64e_Xs_lL2cBtVWD1aGGjRA4',
    appId: '1:130720269859:android:e8e2357fc3dde2842bd396',
    messagingSenderId: '130720269859',
    projectId: 'check-list-app-b9ba1',
    storageBucket: 'check-list-app-b9ba1.appspot.com',
  );
}