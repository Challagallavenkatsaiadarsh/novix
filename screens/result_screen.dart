import 'package:flutter/material.dart';

import '../core/api_service.dart';
import '../models/timeline_query.dart';

class ResultScreen extends StatefulWidget {
  final TimelineQuery query;

  const ResultScreen({super.key, required this.query});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String past = "Loading past...";
  String present = "Loading present...";
  String future = "Loading future...";
  String life = "Loading life...";
  String alternate = "Loading alternate...";

  bool _loading = true;
  String _error = "";

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    try {
      setState(() {
        _loading = true;
      });

      // ApiService.fetchAnswer returns a single text placeholder by default.
      // For now we call it once and duplicate into sections.
      final String raw = await ApiService.fetchAnswer(widget.query);

      // In a real backend you would return structured JSON for each section.
      // For this prototype we split the returned text into sections using simple labels,
      // or simply place same content into all sections so UI works.
      setState(() {
        past = raw;
        present = raw;
        future = raw;
        life = raw;
        alternate = raw;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Widget _sectionCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.query;

    return Scaffold(
      appBar: AppBar(
        title: Text(q.query),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text("Error: $_error"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      _sectionCard("PAST", past),
                      _sectionCard("PRESENT", present),
                      _sectionCard("FUTURE", future),
                      _sectionCard("LIFE IMPACT", life),
                      _sectionCard("ALTERNATE POSSIBILITIES", alternate),
                      const SizedBox(height: 16),
                      Text("Detected timeline: ${q.timeline}", style: Theme.of(context).textTheme.bodySmall),
                      if (q.year != null) Text("Year: ${q.year}", style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
    );
  }
}
