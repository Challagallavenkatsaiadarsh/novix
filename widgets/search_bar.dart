import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(BuildContext, String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Ask anything about past, present or 50-year future...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              widget.onSearch(context, controller.text);
            }
          },
          child: const Text("Search"),
        )
      ],
    );
  }
}
