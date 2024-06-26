import 'package:cpnz/src/views/main_menu.dart';
import 'package:cpnz/src/views/patrol_logs.dart';
import 'package:cpnz/src/views/patrol_map.dart';
import 'package:cpnz/src/views/view_log.dart';
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
      '/logs': (context) => const PatrolLogs(),
      '/view_log': (context) => const ViewLog(),
    });
  }
}
