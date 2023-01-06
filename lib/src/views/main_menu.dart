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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(children: [
            Image.asset('assets/cpnz_logo.png'),
            ElevatedButton(
              onPressed: (() {
                Navigator.pushNamed(context, "/map");
              }),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              child: const Text("Start Patrol"),
            ),
            OutlinedButton(
                onPressed: (() {}),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("View completed patrol logs"))
          ]),
        ));
  }
}
