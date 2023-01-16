import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../../shared/model/event_stats.dart';
import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerEventStatsView extends StatelessWidget {
  final EventStats eventStats;
  const OrganizerEventStatsView({super.key, required this.eventStats});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildCard(context, eventStats));
  }

  Widget _buildCard(BuildContext context, EventStats eventStats) {
    return PageWithWatermark(
        appBar: Themes.defaultAppBar(title: eventStats.name),
        child: _buildButtons(context, eventStats));
  }

  Widget _buildButtons(BuildContext context, EventStats eventStats) {
    return Column(
      children: [
        Expanded(
            flex: 4,
            child: Row(children: [
              Expanded(
                  child: _buildPercentageComponent(
                      eventStats.averageCapturePercentage,
                      'is the average game completion rate')),
              Expanded(
                  child: _buildPercentageComponent(
                      eventStats.completePercentage,
                      'is how much players finished the game'))
            ])),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: _buildPlayersButton(context, eventStats.id),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: _buildPointsButton(context, eventStats.id),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPercentageComponent(int percentage, String text) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 150),
        Text(
          '$percentage%',
          style: Themes.textTheme().headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Themes.textTheme().headline6,
        )
      ],
    ));
  }

  Widget _buildPlayersButton(BuildContext context, String eventId) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context
                .read<OrganizerBloc>()
                .add(GetEventPlayers(eventId: eventId));
          },
          child: const Card(
            child: Center(
              child: Text('Show\nPlayers',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPointsButton(BuildContext context, String eventId) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<OrganizerBloc>().add(GetEventPoints(eventId: eventId));
          },
          child: const Card(
            child: Center(
              child: Text('Show\nPoints',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
            ),
          ),
        );
      },
    );
  }
}
