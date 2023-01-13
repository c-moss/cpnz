import 'package:cpnz/src/views/patrol_app.dart';
import 'package:flutter/material.dart';
import 'package:cpnz/src/util/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const PatrolApp());
}
