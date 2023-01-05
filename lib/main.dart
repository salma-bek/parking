import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/views/home.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfffbfdff),

        brightness: Brightness.light,
        cardColor: const Color(0xfff2f9fc),
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xfffa5e3c),
          secondary: const Color(0xffb0d9d7),
          background: const Color(0xfffbfdff),
        ),
        textTheme: TextTheme(
            headline1: TextStyle(color: Color(0xff305c5b)),
            bodyText1: TextStyle(color: Color(0xff8e8e96))),
      ),
      darkTheme: ThemeData(
        cardColor: Color(0xFF424242),
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xff121212),
        //  brightness: Brightness.dark,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xfffa5e3c),
          secondary: const Color(0xffb0d9d7),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }

}