import 'dart:convert';

import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/data/model/player.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';

import '../config.dart';
import 'model/event.dart';
import 'package:http/http.dart' as http;

import 'model/player_stats.dart';
import 'model/point.dart';

class OrganizerRepository {
  Future<List<Event>> getOrganizerEvents(Credentials credentials) async {
    var url = Uri.http(Config.BaseUrl, 'event/me');

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

  Future<Event> getEvent(Credentials credentials, String eventId) async {
    var url = Uri.http(Config.BaseUrl, 'event/$eventId');

    var response = await http.get(
      url,
      headers: <String, String>{
        //TODO: change endpoint
        //'Authorization': '${credentials.id}@${credentials.passcode}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error fetching the data!");
    }
    return Event.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<List<Point>> getPoints(Credentials credentials, String eventId) async {
    var url = Uri.http(Config.BaseUrl, 'point/event/$eventId');

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
    var url = Uri.http(Config.BaseUrl, 'player/event/$eventId');

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
    var url = Uri.http(Config.BaseUrl, 'player/$eventId');

    await http.post(url,
        headers: <String, String>{
          'Authorization': '${credentials.id}@${credentials.passcode}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'name': playerName}));
  }

  Future<void> addPoint(
      Credentials credentials, String playerName, String eventId) async {
    var url = Uri.http(Config.BaseUrl, 'point/$eventId');

    await http.post(url,
        headers: <String, String>{
          'Authorization': '${credentials.id}@${credentials.passcode}',
        },
        body: jsonEncode(<String, dynamic>{'name': playerName}));
  }

  Future<PlayerStats> getPlayerStats(
      Credentials credentials, String playerId) async {
    var url = Uri.http(Config.BaseUrl, 'stats/player/$playerId');

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
