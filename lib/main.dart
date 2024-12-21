import 'package:flutter/material.dart';
import 'contents/pages/jingle_page.dart';
import 'theme/material_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(const TextTheme());
    return MaterialApp(
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: JinglePage()
    );
  }
}
