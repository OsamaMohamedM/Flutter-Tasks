import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/components/custombuttonauth.dart';
import 'package:untitled4/components/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  void _submitForm() async {
    if (formstate.currentState?.validate() ?? false) {
      try {
        final current_state = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);

        current_state.user!.sendEmailVerification();
        Navigator.of(context).pushReplacementNamed("login");
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case "Weak password":
            message = "Weak password";
            break;
          case "wrong-password":
            message = "email-already-in-use";
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(height: 5),
              const Text(
                "Start for 30 day free trial",
                style: TextStyle(color: Colors.grey),
              ),
              Container(height: 30),
              Form(
                key: formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hintText: "Enter your name",
                      mycontroller: username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
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
                      hintText: "Enter your email",
                      mycontroller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
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
                      hintText: "Enter your password",
                      mycontroller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "must be at least 8 characters",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Container(height: 10),
                    const Text(
                      "Confirm password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hintText: "Confirm your password",
                      mycontroller: confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (confirmPassword.value != password.value) {
                          return 'Passwords does not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  width: 500,
                  child: CustomButtonAuth(
                    title: "Sign Up",
                    onPressed: _submitForm,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const Text(
                  "ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــorـــــــــــــــــــــــــــــــــــــــــــــــــــ"),
              Center(
                child: SizedBox(
                  width: 500,
                  child: CustomButtonAuth(
                    title: "Sign Up with goggle",
                    onPressed: _submitForm,
                    image: "images/4.png",
                  ),
                ),
              ),
              Container(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("login");
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: "Have an account? "),
                    TextSpan(
                      text: "Try to sgin in",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ])),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
