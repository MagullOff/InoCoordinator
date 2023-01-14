import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/default_floating_button.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../data/model/player.dart';
import '../../themes.dart';

class OrganizerEventPlayersView extends StatelessWidget {
  final List<Player> players;
  final String eventName;
  final String eventId;
  const OrganizerEventPlayersView(
      {super.key,
      required this.players,
      required this.eventName,
      required this.eventId});

  @override
  Widget build(BuildContext context) {
    return _buildCard(context, players, eventName);
  }

  Widget _buildCard(
      BuildContext context, List<Player> players, String eventName) {
    return PageWithWatermark(
        floatingActionButton: DefaultFloatingButton(
          icon: Icons.person_add_rounded,
          onTap: () {
            context.read<OrganizerBloc>().add(GetAddPlayerForm(eventId));
          },
        ),
        appBar: Themes.defaultAppBar(
          title: eventName,
        ),
        child: SingleChildScrollView(
          child: Column(children: [_buildList(context, players)]),
        ));
  }

  Widget _buildList(BuildContext context, List<Player> list) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListViewBuilder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListItem(
                onTap: () => {
                  context
                      .read<OrganizerBloc>()
                      .add(GetPlayerStats(playerId: list[index].id))
                },
                leading: Icons.person,
                subtitle: 'Access code: ${list[index].code}',
                title: list[index].name,
                trailingIcon: Icons.chevron_right,
              );
            },
          ),
        );
      },
    );
  }
}
