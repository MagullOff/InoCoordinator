import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception("not signed in");
  }

  Future<String> loginPlayer(String passcode) async {
    var url = Uri.http(Config.BaseUrl, 'player/login');

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'code': passcode}));
    if (response.statusCode != 200) {
      throw Exception("cannot sign in!");
    }
    return jsonDecode(response.body)['id'];
  }

  Future<String> loginOrganizer(String passcode) async {
    var url = Uri.http(Config.BaseUrl, 'organizer/login');

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'code': passcode}));
    if (response.statusCode != 200) {
      throw Exception("cannot sign in!");
    }
    return jsonDecode(response.body)['id'];
  }

  Future<String> signUp(String username) async {
    var url = Uri.http(Config.BaseUrl, 'organizer/add');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'name': username, 'email': "essa@net"}));
    if (response.statusCode != 200) {
      throw Exception("cannot sign up!");
    }
    return jsonDecode(response.body)['access_code'].toString();
  }

  Future<void> signOut() async {
    print('attempting signout');
    await Future.delayed(Duration(seconds: 3));
  }
}
