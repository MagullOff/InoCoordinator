import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../form_submission_status.dart';
import '../login/login_bloc.dart';

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

Widget icon() {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 90, 0, 30),
    width: 120,
    height: 120,
    alignment: Alignment.center,
    child: Image.asset('images/icon512.png'),
  );
}

Widget submitButton(String message, GlobalKey<FormState> formKey) {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )
          : ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(message),
            );
    },
  );
}

Widget codeField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) =>
              state.isValidPassCode ? null : "Passcode length is not correct",
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPassCodeChanged(passCode: value)),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.0)),
              label: Text(
                'Pass code',
                style: Theme.of(context).textTheme.headline3,
              )),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      );
    },
  );
}

AppBar appBar(BuildContext context) {
  return AppBar(
    title: const Text('InoCoordinator'),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
    toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
    titleTextStyle: Theme.of(context).textTheme.headline1,
  );
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
