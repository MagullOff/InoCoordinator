import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/themes.dart';

import '../../shared/wide_button.dart';

class OrganizerAddPlayerView extends StatelessWidget {
  OrganizerAddPlayerView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
        appBar: Themes.defaultAppBar(),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          _submitButton(),
          //_addPlayerForm(),
        ]));
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
