// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBT0vRBojOm0y8h2wxQdg12uoEqXQZGWME',
    appId: '1:1076162802573:android:2dd000a026cb345314c3c4',
    messagingSenderId: '1076162802573',
    projectId: 'foodapp-29b5f',
    databaseURL: 'https://foodapp-29b5f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodapp-29b5f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiQVjADNpDHJP_8XmVCkzwUKTSKD68GRE',
    appId: '1:1076162802573:ios:10c8d98f80ccdbd314c3c4',
    messagingSenderId: '1076162802573',
    projectId: 'foodapp-29b5f',
    databaseURL: 'https://foodapp-29b5f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'foodapp-29b5f.appspot.com',
    iosBundleId: 'com.example.deliveryFood',
  );
}