import 'package:flutter/material.dart';

import 'screens/search_screen.dart';

void main() {
  runApp(const NovixApp());
}

class NovixApp extends StatelessWidget {
  const NovixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SearchScreen(),
    );
  }
}