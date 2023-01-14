import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/organizer/views/organizer_event_players_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_event_points_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_events_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_player_stats_view.dart';

import 'views/organizer_events_stats_view.dart';

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
