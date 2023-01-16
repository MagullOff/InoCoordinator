class EventStats {
  late String id;
  late String name;
  late int averageCapturePercentage;
  late int completePercentage;

  EventStats(
      {required this.id,
      required this.name,
      required this.averageCapturePercentage,
      required this.completePercentage});

  EventStats.fromJson(Map<String, dynamic> body) {
    id = body['id'];
    name = body['name'];
    completePercentage = body['completion_amount'];
    averageCapturePercentage = body['average_completion_amount'];
  }
}
