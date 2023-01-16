import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';

class OrganizerNavigator extends StatelessWidget {
  const OrganizerNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Navigator(
          pages: state.pages,
          onPopPage: (route, result) {
            context.read<OrganizerBloc>().add(PopPage());
            return route.didPop(result);
          },
        );
      },
    );
  }
}
