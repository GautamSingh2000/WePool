import 'package:flutter/material.dart';
import 'package:wepool/pages/auth/LoginScreen.dart';
import 'package:wepool/pages/auth/PreSignupScreen.dart';
import 'package:wepool/pages/GlobalScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins'
      ),
      // home: PreSignupScreen(), // Set PreSignupScreen as the home screen
      home: GlobalScreen(), // Set PreSignupScreen as the home screen
    );
  }
}
