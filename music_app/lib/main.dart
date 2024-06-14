// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import

import 'package:firebase_core/firebase_core.dart'; //Firebase library
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/pages/auth_page.dart';

import 'pages/home_page.dart';
import 'package:music_app/pages/social_login_page.dart';

//Firebase stuff here

//May need to be Future
void main() async {
  // await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // Will be necessary if we later have a web version
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "",
  //           appId: "",
  //           messagingSenderId: "",
  //           projectId: ""));
  // }

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBWpprpLDoDMSQKHWgW0qwuOqksfLKMtt4',
          appId: '1:1084813227333:ios:480d4b336a7a88742cfa2c',
          messagingSenderId: '1084813227333',
          projectId: 'deepmusic-app'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Music App',
      routes: {
        '/': (context) =>
            AuthPage(), //Could add another screen to decide if user logged in or not
        '/login': (context) => SocialLoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
