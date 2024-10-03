import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                provider.toggleTheme(false);

                });
              },
              child: const Text('Make background green'),
            ),  ElevatedButton(
              onPressed: () {
                setState(() {
                provider.toggleTheme(true);
                });
              },
              child: const Text('Make background blue'),
            ),
          ],
        ),
      ),
    );
  }
}
