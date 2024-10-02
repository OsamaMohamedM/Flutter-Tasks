import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/components/custombuttonauth.dart';
import 'package:untitled4/components/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth == null) {
      return;
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("homepage");
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              Container(height: 10),
              CustomTextForm(
                hintText: "ُEnter Your Email",
                mycontroller: email,
              ),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              Container(height: 10),
              CustomTextForm(
                  hintText: "ُEnter Your Password", mycontroller: password),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              width: 500,
              child: CustomButtonAuth(
                title: "Login",
                onPressed: () async {
                  try {
                    final userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    if (userCredential.user != null &&
                        userCredential.user!.emailVerified)
                      Navigator.of(context).pushReplacementNamed("homepage");
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please verify your email")),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    String message;
                    switch (e.code) {
                      case "user-not-found":
                        message = "User not found";
                        break;
                      case "wrong-password":
                        message = "Wrong password";
                        break;
                      default:
                        message = "An error occurred. Please try again.";
                        break;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 500,
              child: CustomButtonAuth(
                title: "Login with goggle",
                onPressed: signInWithGoogle,
                image: "images/4.png",
              ),
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("signup");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
