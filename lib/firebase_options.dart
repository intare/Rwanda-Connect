// Firebase configuration for Rwanda Connect
// Generated from google-services.json and GoogleService-Info.plist

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLGBjCbB1mGz_SIYK3MqjIZCgP_rDa7Bs',
    appId: '1:481567131894:android:a34d6af92ed76c075c84d7',
    messagingSenderId: '481567131894',
    projectId: 'rwanda-connect-dcf48',
    storageBucket: 'rwanda-connect-dcf48.firebasestorage.app',
    databaseURL: 'https://rwanda-connect-dcf48-default-rtdb.firebaseio.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCz5ryUffiYSpRRxbXM43kXx0OEThbXhqA',
    appId: '1:481567131894:ios:de4f1a3e9b32988b5c84d7',
    messagingSenderId: '481567131894',
    projectId: 'rwanda-connect-dcf48',
    storageBucket: 'rwanda-connect-dcf48.firebasestorage.app',
    databaseURL: 'https://rwanda-connect-dcf48-default-rtdb.firebaseio.com',
    iosBundleId: 'com.newtimes.rwandaconnect',
  );

  // Web configuration - add your web app config from Firebase Console if needed
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLGBjCbB1mGz_SIYK3MqjIZCgP_rDa7Bs',
    appId: '1:481567131894:android:a34d6af92ed76c075c84d7',
    messagingSenderId: '481567131894',
    projectId: 'rwanda-connect-dcf48',
    storageBucket: 'rwanda-connect-dcf48.firebasestorage.app',
    authDomain: 'rwanda-connect-dcf48.firebaseapp.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCz5ryUffiYSpRRxbXM43kXx0OEThbXhqA',
    appId: '1:481567131894:ios:de4f1a3e9b32988b5c84d7',
    messagingSenderId: '481567131894',
    projectId: 'rwanda-connect-dcf48',
    storageBucket: 'rwanda-connect-dcf48.firebasestorage.app',
    databaseURL: 'https://rwanda-connect-dcf48-default-rtdb.firebaseio.com',
    iosBundleId: 'com.newtimes.rwandaconnect',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLGBjCbB1mGz_SIYK3MqjIZCgP_rDa7Bs',
    appId: '1:481567131894:android:a34d6af92ed76c075c84d7',
    messagingSenderId: '481567131894',
    projectId: 'rwanda-connect-dcf48',
    storageBucket: 'rwanda-connect-dcf48.firebasestorage.app',
  );
}
