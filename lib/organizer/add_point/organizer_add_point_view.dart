import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/organizer_repository.dart';
import 'package:ino_coordinator/organizer/add_point/bloc/add_point_bloc.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../../shared/components/submission_form.dart';
import '../../shared/components/text_input_field.dart';
import '../../shared/components/wide_button.dart';
import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerAddPointView extends StatelessWidget {
  final String eventId;
  OrganizerAddPointView({super.key, required this.eventId});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPointBloc(
          eventId: eventId,
          organizerBloc: context.read<OrganizerBloc>(),
          organizerRepository: context.read<OrganizerRepository>()),
      child: PageWithWatermark(
          appBar: Themes.defaultAppBar(),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            _submitButton(),
            _pointForm(),
          ])),
    );
  }

  Widget _pointForm() {
    return SubmissionForm(
      formKey: _formKey,
      title: 'Enter the name of the new point',
      input: _nameField(),
    );
  }

  Widget _nameField() {
    return BlocBuilder<AddPointBloc, AddPointState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            validator: (value) => state.isValidName ? null : 'Invalid username',
            onChanged: (value) {
              context.read<AddPointBloc>().add(AddPointNameChanged(value));
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
        return WideButton.fromTheme(
          onClick: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AddPointBloc>().add(AddPointSubmitted());
            }
          },
          title: 'Submit',
          buttonType: ButtonType.primary,
        );
      },
    );
  }
}
