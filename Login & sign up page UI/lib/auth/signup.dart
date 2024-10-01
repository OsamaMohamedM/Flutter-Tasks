import 'package:flutter/material.dart';
import 'package:untitled4/components/custombuttonauth.dart';
import 'package:untitled4/components/customlogoauth.dart';
import 'package:untitled4/components/textformfield.dart';

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

  void _submitForm() {
    if (formstate.currentState?.validate() ?? false) {
      print("Username: ${username.text}");
      print("Email: ${email.text}");
      print("Password: ${password.text}");
      Navigator.of(context).pushReplacementNamed("login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(height: 10),
              const Text(
                "Sign up to continue using the app",
                style: TextStyle(color: Colors.grey),
              ),
              Container(height: 20),
              Form(
                key: formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Username",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hinttext: "Enter your username",
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hinttext: "Enter your email",
                      mycontroller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    Container(height: 10),
                    const Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hinttext: "Enter your password",
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
                    Container(height: 10),
                    const Text(
                      "Confirm password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      hinttext: "Confirm your password",
                      mycontroller: confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (confirmPassword.value !=password.value) {
                          return 'Passwords does not match';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: CustomButtonAuth(
                    title: "Sign Up",
                    onPressed: _submitForm,
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
                      text: "Login",
                      style: TextStyle(
                        color: Colors.orange,
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
