import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/timeline_query.dart';

class ApiService {
  static Future<String> fetchAnswer(TimelineQuery query) async {
    final prompt = """
You are NOVIX: a time-based answer engine.
User asked: "${query.query}"

Give structured output:
1. PAST (before today)
2. PRESENT (current status)
3. FUTURE (next 50 years)
4. LIFE IMPACT
5. ALTERNATE POSSIBILITIES

Timeline detected: ${query.timeline}
Year requested: ${query.year ?? "none"}
""";

    final response = await http.post(
     Uri.parse("http://10.0.2.2:3000/ask"),   // ✔ LOCAL BACKEND URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"prompt": prompt}),
    );

    return jsonDecode(response.body)["answer"];
  }
}
