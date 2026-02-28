import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchService {
  static const String baseUrl = 'http://10.0.2.2:3000/api'; 
  // 10.0.2.2 = localhost for Android emulator

  static Future<List<dynamic>> search(String query) async {
    if (query.length < 2) return [];

    final uri = Uri.parse('$baseUrl/search?q=$query');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Search failed');
    }
  }
}