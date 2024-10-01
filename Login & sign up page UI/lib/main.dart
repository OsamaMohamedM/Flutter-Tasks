
import 'package:flutter/material.dart';
import 'package:untitled4/auth/login.dart';
import 'package:untitled4/auth/signup.dart';



void main() async {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: {
        "signup" : (context) => const SignUp() ,
        "login" : (context) => const Login()
      },
    );
  }
}
