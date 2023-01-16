import 'package:flutter/material.dart';

import '../themes.dart';

class SubmissionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final Widget input;
  const SubmissionForm(
      {super.key,
      required this.formKey,
      required this.title,
      required this.input});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Themes.textTheme().headline2,
                ),
                const SizedBox(
                  height: 20,
                ),
                input
              ],
            ),
          ),
        ],
      ),
    );
  }
}
