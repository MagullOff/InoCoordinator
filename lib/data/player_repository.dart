import 'dart:convert';

import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/data/model/player_stats.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class PlayerRepository {
  Future<PlayerStats> getPlayerStats(Credentials credentials) async {
    var url = Uri.http(Config.BaseUrl, 'stats/player/me');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }

    return PlayerStats.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<void> capturePoint(Credentials credentials, String code) async {
    var url = Uri.http(Config.BaseUrl, 'capture/$code');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
  }
}
