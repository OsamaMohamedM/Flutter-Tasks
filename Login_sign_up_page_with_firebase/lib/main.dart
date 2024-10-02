import 'package:flutter/material.dart';
import 'package:untitled4/auth/login.dart';
import 'package:untitled4/auth/signup.dart';
import 'package:untitled4/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user)
    {
      if(user==null)print("Is sgined out");
      else print("sign in");
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: (FirebaseAuth.instance.currentUser==null ? Login() : Homepage() ),
      routes: {
        "signup": (context) => const SignUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const Homepage(),
      },
    );
  }
}
