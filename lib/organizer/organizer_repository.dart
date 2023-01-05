import 'dart:convert';

import 'package:ino_coordinator/cubit/session_cubit.dart';

import '../model/event.dart';
import 'package:http/http.dart' as http;

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
}
