import 'package:flutter/material.dart';

class TimelineResultCard extends StatelessWidget {
  final String title;
  final String result;

  const TimelineResultCard({
    super.key,
    required this.title,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("$title\n\n$result"),
      ),
    );
  }
}
