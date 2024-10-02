import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? color;
  final String? image;
  const CustomButtonAuth({super.key, this.onPressed, required this.title,this.color,this.image});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color:(color ?? Colors.grey) ,
      textColor: Colors.white,
      onPressed: onPressed,
      child:( image==null ? Text(title):
          Row(mainAxisAlignment:MainAxisAlignment.center,children: [Container(width:15 ,child: Image.asset("$image",fit: BoxFit.fill,)), Text(title),],
      )),
    );
  }
}
