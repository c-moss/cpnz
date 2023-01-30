import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  static const _textStyleButton = TextStyle(fontSize: 18);
  static final _buttonStyleMenu =
      ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56));
  static const _verticalSpacer = SizedBox(height: 32);

  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 150),
      child: Column(children: [
        Image.asset('assets/cpnz_logo.png'),
        _verticalSpacer,
        ElevatedButton(
          onPressed: (() => Navigator.pushNamed(context, "/map")),
          style: _buttonStyleMenu,
          child: const Text(
            "Start Patrol",
            style: _textStyleButton,
          ),
        ),
        _verticalSpacer,
        OutlinedButton(
            onPressed: (() => Navigator.pushNamed(context, "/logs")),
            style: _buttonStyleMenu,
            child: const Text(
              "View completed patrol logs",
              style: _textStyleButton,
            ))
      ]),
    ));
  }
}
