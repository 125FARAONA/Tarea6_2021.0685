// Rozenny Pie Valentin / 2021-0685 / Tarea 6

import 'package:flutter/material.dart';
import 'package:tarea6_2021_0685/screens/tools_screen.dart';

void main() {
  runApp(const ToolboxApp());
}

class ToolboxApp extends StatelessWidget {
  const ToolboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToolsScreen(),
    );
  }
}
