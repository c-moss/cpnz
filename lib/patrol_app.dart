import 'package:cpnz/main_menu.dart';
import 'package:cpnz/patrol_map.dart';
import 'package:flutter/material.dart';

class PatrolApp extends StatefulWidget {
  const PatrolApp({super.key});

  @override
  State<PatrolApp> createState() => _PatrolAppState();
}

class _PatrolAppState extends State<PatrolApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'PatrolApp', initialRoute: '/', routes: {
      '/': (context) => const MainMenu(),
      '/map': (context) => const PatrolMap(),
    });
  }
}
