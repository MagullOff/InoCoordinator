import 'package:intl/intl.dart';

class PlayerStats {
  late final String name;
  late final int capturePercentage;
  late final List<PointStats> pointList;
  PlayerStats(
      {required this.capturePercentage,
      required this.name,
      required this.pointList});

  PlayerStats.fromJson(Map<String, dynamic> body) {
    capturePercentage = body['capture_percentage'];
    name = body['name'];
    pointList = [];
    body['point_stats']
        .forEach((mapStats) => pointList.add(PointStats.fromJson(mapStats)));
  }
}

class PointStats {
  late String name;
  late int capturePercentage;
  String? date;

  PointStats({required this.capturePercentage, this.date, required this.name});

  PointStats.fromJson(Map<String, dynamic> body) {
    capturePercentage = body['capture_percentage']!;
    name = body['name']!;
    date = body['date'] == null
        ? null
        : DateFormat.Hm().format(DateTime.parse(body['date']));
  }
}
