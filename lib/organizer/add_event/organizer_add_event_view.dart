import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/signup/bloc/signup_bloc.dart';
import 'package:ino_coordinator/data/organizer_repository.dart';
import 'package:ino_coordinator/organizer/add_player/bloc/add_player_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/themes.dart';

import '../../shared/submission_form.dart';
import '../../shared/text_input_field.dart';
import '../../shared/wide_button.dart';
import 'bloc/add_event_bloc.dart';

class OrganizerAddEventView extends StatelessWidget {
  OrganizerAddEventView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEventBloc(
          organizerBloc: context.read<OrganizerBloc>(),
          organizerRepository: context.read<OrganizerRepository>()),
      child: PageWithWatermark(
          appBar: Themes.defaultAppBar(),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            _submitButton(),
            _eventForm(),
          ])),
    );
  }

  Widget _eventForm() {
    return SubmissionForm(
      formKey: _formKey,
      title: 'Enter name of the new event',
      input: _eventNameField(),
    );
  }

  Widget _eventNameField() {
    return BlocBuilder<AddEventBloc, AddEventState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            validator: (value) =>
                state.isValidEventName ? null : 'Invalid event name',
            onChanged: (value) {
              context.read<AddEventBloc>().add(AddEventNameChanged(value));
            },
            decorationText: "Username",
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<AddEventBloc, AddEventState>(
      builder: (context, state) {
        return WideButton(
          onClick: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AddEventBloc>().add(AddEventSubmitted());
            }
          },
          title: 'Submit',
          buttonType: ButtonType.primary,
        );
      },
    );
  }
}
