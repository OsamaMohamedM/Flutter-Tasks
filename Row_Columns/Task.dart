import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text.rich(TextSpan(children: [
                TextSpan(
                  text: "HOT DRINKS",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: " Partition",
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ])),
              const SizedBox(height: 20),
              // First Item
              buildMenuItem(
                imagePath: "images/capitiono.png",
                title: "CAPPUCCINO",
                price: "40 L.E",
              ),
              const SizedBox(height: 20),
              // Second Item
              buildMenuItem(
                imagePath: "images/2.png",
                title: "COFFEE",
                price: "30 L.E",
              ),
              const SizedBox(height: 20),
              // Third Item
              buildMenuItem(
                imagePath: "images/3.png",
                title: "MOCHA",
                price: "40 L.E",
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildMenuItem({
    required String imagePath,
    required String title,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
             SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 40),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
