import '../models/timeline_query.dart';

class TimelineParser {
  static TimelineQuery parse(String input) {
    input = input.toLowerCase();

    // Detect year
    final regex = RegExp(r'\b\d{1,4}\b');
    int? year;
    if (regex.hasMatch(input)) {
      year = int.parse(regex.firstMatch(input)!.group(0)!);
    }

    // Timeline detection
    String timeline = 'present';

    if (year != null) {
     if (year > DateTime.now().year) {
  timeline = 'future';
} else if (year < DateTime.now().year) {
  timeline = 'past';
}
    }

    return TimelineQuery(
      query: input,
      timeline: timeline,
      year: year,
    );
  }
}
