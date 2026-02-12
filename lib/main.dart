import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/dock_page.dart';
//testing
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// Main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DockPage(),
    );
  }
}
