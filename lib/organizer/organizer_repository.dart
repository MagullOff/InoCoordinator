import 'dart:convert';

import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/shared/model/player.dart';

import '../config.dart';
import '../shared/model/event.dart';
import 'package:http/http.dart' as http;

import '../shared/model/event_stats.dart';
import '../shared/model/player_stats.dart';
import '../shared/model/point.dart';

class OrganizerRepository {
  Future<List<Event>> getOrganizerEvents(Credentials credentials) async {
    var url = Uri.http(Config.baseUrl, 'event/me');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    List<Event> result = [];
    jsonDecode(utf8.decode(response.bodyBytes))
        .forEach((jsonEvent) => result.add(Event.fromJson(jsonEvent)));
    return result;
  }

  Future<String> getMyName(Credentials credentials) async {
    var url = Uri.http(Config.baseUrl, 'organizer/me');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    return jsonDecode(utf8.decode(response.bodyBytes))['name'];
  }

  Future<EventStats> getEvent(Credentials credentials, String eventId) async {
    var url = Uri.http(Config.baseUrl, '/stats/event/$eventId');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    return EventStats.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<List<Point>> getPoints(Credentials credentials, String eventId) async {
    var url = Uri.http(Config.baseUrl, 'point/event/$eventId');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    List<Point> result = [];
    jsonDecode(utf8.decode(response.bodyBytes))
        .forEach((jsonEvent) => result.add(Point.fromJson(jsonEvent)));
    return result;
  }

  Future<List<Player>> getPlayers(
      Credentials credentials, String eventId) async {
    var url = Uri.http(Config.baseUrl, 'player/event/$eventId');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    List<Player> result = [];
    jsonDecode(utf8.decode(response.bodyBytes))
        .forEach((jsonEvent) => result.add(Player.fromJson(jsonEvent)));
    return result;
  }

  Future<void> addPlayer(
      Credentials credentials, String playerName, String eventId) async {
    var url = Uri.http(Config.baseUrl, 'player/$eventId');

    await http.post(url,
        headers: <String, String>{
          'Authorization': '${credentials.id}@${credentials.passcode}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'name': playerName}));
  }

  Future<void> addPoint(
      Credentials credentials, String pointName, String eventId) async {
    var url = Uri.http(Config.baseUrl, 'point/$eventId');

    await http.post(url,
        headers: <String, String>{
          'Authorization': '${credentials.id}@${credentials.passcode}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'name': pointName}));
  }

  Future<void> addEvent(Credentials credentials, String eventName) async {
    var url = Uri.http(Config.baseUrl, 'event');

    await http.post(url,
        headers: <String, String>{
          'Authorization': '${credentials.id}@${credentials.passcode}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'name': eventName}));
  }

  Future<PlayerStats> getPlayerStats(
      Credentials credentials, String playerId) async {
    var url = Uri.http(Config.baseUrl, 'stats/player/$playerId');

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
}
