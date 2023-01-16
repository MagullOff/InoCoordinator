import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/model/event.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerEventStatsView extends StatelessWidget {
  final Event eventStats;
  const OrganizerEventStatsView({super.key, required this.eventStats});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildCard(context, eventStats));
  }

  Widget _buildCard(BuildContext context, Event eventStats) {
    return PageWithWatermark(
        appBar: Themes.defaultAppBar(),
        child: Column(
          children: [
            _buildTitle(context, eventStats.name),
            _buildButtons(context, eventStats.id)
          ],
        ));
  }

  Widget _buildButtons(BuildContext context, String eventId) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
      child: Center(
          child: Row(
        children: [
          _buildPlayersButton(context, eventId),
          _buildPointsButton(context, eventId)
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
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
            child: SizedBox(
              width: 150,
              height: 100,
              child: Center(
                child: Text('Show Players',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ),
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
            child: SizedBox(
              width: 150,
              height: 100,
              child: Center(
                child: Text('Show Points',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Center(
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}
