import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submission_status.dart';
import 'login/bloc/login_bloc.dart';

Widget redirectHyperlink(BuildContext context, String text, String route) {
  return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, route);
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline3,
        textAlign: TextAlign.right,
      ));
}

InputDecoration inputDecoration(BuildContext context, String message) {
  return InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0)),
      label: Text(
        message,
        style: Theme.of(context).textTheme.headline3,
      ));
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
