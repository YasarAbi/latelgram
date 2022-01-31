import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latelgram/responsive/mobile_screen_layout.dart';
import 'package:latelgram/responsive/responsive_layout_screen.dart';
import 'package:latelgram/responsive/web_screen_layout.dart';
import 'package:latelgram/screens/login_screen.dart';
import 'package:latelgram/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBSO02xCzFmbrDrakciTeiqt5j3YU5WQs4", 
      appId: "1:520601938746:web:cffb787eeb7a6db69bbe03", 
      messagingSenderId: "520601938746", 
      projectId: "letelgram",
      storageBucket: "letelgram.appspot.com")
  );
  } else {
    await Firebase.initializeApp;
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaTelGram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      /// home: ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout())
      home: LoginScreen(),
    );
  }
}