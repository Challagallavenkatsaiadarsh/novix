import 'package:flutter/material.dart';

import '../core/timeline_parser.dart';
import '../models/timeline_query.dart';
import '../screens/result_screen.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onSearch(BuildContext context, String userInput) {
    TimelineQuery q = TimelineParser.parse(userInput);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(query: q),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novix"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SearchBarWidget(onSearch: onSearch),
      ),
    );
  }
}
