import 'package:flutter/material.dart';

import '../services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List results = [];
  bool loading = false;

  void _onSearch(String value) async {
    if (value.length < 2) {
      setState(() => results = []);
      return;
    }

    setState(() => loading = true);

    try {
      final data = await SearchService.search(value);
      setState(() {
        results = data;
        loading = false;
      });
    } catch (e) {
      loading = false;
      debugPrint('❌ ERROR: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Cities / Villages')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: _onSearch,
              decoration: const InputDecoration(
                hintText: 'Type city / village',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          if (loading) const CircularProgressIndicator(),

          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(
                    '${item['district']}, ${item['state_name']}',
                  ),
                  trailing: Text(item['urban_status']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}