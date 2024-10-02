import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText ;
  final TextEditingController mycontroller ;
  final String? Function(String?)? validator;
  const CustomTextForm({super.key, required this.hintText, required this.mycontroller,  this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator,
      controller: mycontroller ,
      decoration: InputDecoration(
          hintText:hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey))),
    );
  }
}
