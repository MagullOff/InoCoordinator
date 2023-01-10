import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../shared/submission_form.dart';
import '../../shared/text_input_field.dart';
import '../../shared/wide_button.dart';
import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerAddPointView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  OrganizerAddPointView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
        appBar: Themes.defaultAppBar(),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          _submitButton(),
          _pointForm(),
        ]));
  }

  Widget _pointForm() {
    return SubmissionForm(
      formKey: _formKey,
      title: 'Enter the name of the new point',
      input: _usernameField(),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            inputType: InputType.numeric,
            validator: (value) => null,
            onChanged: (value) => {
              //TODO: logic
            },
            decorationText: "Point name",
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return WideButton(
          onClick: () {
            if (_formKey.currentState?.validate() ?? false) {
              //TODO logic
            }
          },
          title: 'Submit',
          buttonType: ButtonType.primary,
        );
      },
    );
  }
}
