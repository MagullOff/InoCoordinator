import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/organizer_events_view.dart';
import 'package:ino_coordinator/organizer/organizer_player_stats_view.dart';

import 'organizer_bloc.dart';
import 'organizer_events_stats_view.dart';

class OrganizerNavigator extends StatelessWidget {
  const OrganizerNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Navigator(pages: [
          if (state is OrganizerLoading || state is OrganizerError)
            MaterialPage(child: CircularProgressIndicator()),
          if (state is OrganizerLoadedEvents ||
              state is OrganizerLoadedEventStats ||
              state is OrganizerLoadedPlayerStats) ...[
            MaterialPage(child: OrganizerEventsView()),
            if (state is OrganizerLoadedEventStats ||
                state is OrganizerLoadedPlayerStats) ...[
              MaterialPage(child: OrganizerEventStatsView()),
              if (state is OrganizerLoadedPlayerStats)
                MaterialPage(child: OrganizerPlayerStatsView())
            ]
          ]
        ]);
      },
    );
  }
}
