import 'dart:convert';

import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/data/model/player.dart';

import 'model/event.dart';
import 'package:http/http.dart' as http;

import 'model/point.dart';

class OrganizerRepository {
  final String urlBase = '10.0.2.2:6000';

  Future<List<Event>> getOrganizerEvents(Credentials credentials) async {
    var url = Uri.http(urlBase, 'events/me');

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
    var url = Uri.http(urlBase, 'events/$eventId');

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
    var url = Uri.http(urlBase, 'point/event/$eventId');

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${credentials.id}@${credentials.passcode}',
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
    var url = Uri.http(urlBase, 'player/event/$eventId');

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
}