import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Menu'),
          backgroundColor: Colors.green[700],
        ),
        body: Expanded(
          child: Column(children: [
            Image.asset('cpnz_logo'),
            const Card(
              child: Center(child: Text("Start Patrol")),
            ),
            OutlinedButton(
                onPressed: (() {}),
                child: const Text("View completed patrol logs"))
          ]),
        ));
  }
}
