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
    apiKey: 'AIzaSyCSW2feK_Dr0Up5hEDY28eWbimXdRHTuRM',
    appId: '1:693976377305:web:8bc5e101815b53126f1bc8',
    messagingSenderId: '693976377305',
    projectId: 'mpp-kota-depok-409104',
    authDomain: 'mpp-kota-depok-409104.firebaseapp.com',
    storageBucket: 'mpp-kota-depok-409104.appspot.com',
    measurementId: 'G-KB8QWR3MHK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAr05K8FNBehLcJasI1zczTrZs5dcAb7Zg',
    appId: '1:693976377305:android:8b55ac43fb2b34206f1bc8',
    messagingSenderId: '693976377305',
    projectId: 'mpp-kota-depok-409104',
    storageBucket: 'mpp-kota-depok-409104.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3hWp6wTTuKddWUwoYJq3wr81Pc14TdlY',
    appId: '1:693976377305:ios:87ac3a34d97e66156f1bc8',
    messagingSenderId: '693976377305',
    projectId: 'mpp-kota-depok-409104',
    storageBucket: 'mpp-kota-depok-409104.appspot.com',
    iosClientId: '693976377305-h0jhdoth953ovomcmjntpvobdtmik9ln.apps.googleusercontent.com',
    iosBundleId: 'com.mppkota.mppKotaDepok',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3hWp6wTTuKddWUwoYJq3wr81Pc14TdlY',
    appId: '1:693976377305:ios:248801c3d44cd5686f1bc8',
    messagingSenderId: '693976377305',
    projectId: 'mpp-kota-depok-409104',
    storageBucket: 'mpp-kota-depok-409104.appspot.com',
    iosClientId: '693976377305-0lrn20i0pg66t3didmf2617rpnv9hs9t.apps.googleusercontent.com',
    iosBundleId: 'com.mppkota.mppKotaDepok.RunnerTests',
  );
}
