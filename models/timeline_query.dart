class TimelineQuery {
  final String query;
  final String timeline;
  final int? year;

  TimelineQuery({
    required this.query,
    required this.timeline,
    this.year,
  });
}
