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

class OrganizerAddPlayerView extends StatelessWidget {
  final String eventId;
  OrganizerAddPlayerView({super.key, required this.eventId});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPlayerBloc(
          eventId: eventId,
          organizerBloc: context.read<OrganizerBloc>(),
          organizerRepository: context.read<OrganizerRepository>()),
      child: PageWithWatermark(
          appBar: Themes.defaultAppBar(),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            _submitButton(),
            _playerForm(),
          ])),
    );
  }

  Widget _playerForm() {
    return SubmissionForm(
      formKey: _formKey,
      title: 'Enter username of the new player',
      input: _usernameField(),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<AddPlayerBloc, AddPlayerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            validator: (value) =>
                state.isValidUsername ? null : 'Invalid username',
            onChanged: (value) {
              context
                  .read<AddPlayerBloc>()
                  .add(AddPlayerUsernameChanged(value));
            },
            decorationText: "Username",
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<AddPlayerBloc, AddPlayerState>(
      builder: (context, state) {
        return WideButton(
          onClick: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AddPlayerBloc>().add(AddPlayerSubmitted());
            }
          },
          title: 'Submit',
          buttonType: ButtonType.primary,
        );
      },
    );
  }
}
