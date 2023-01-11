import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../data/model/player.dart';
import '../../themes.dart';

class OrganizerEventPlayersView extends StatelessWidget {
  const OrganizerEventPlayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizerBloc, OrganizerState>(
      listener: (context, state) {
        if (state is OrganizerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
      },
      child: BlocBuilder<OrganizerBloc, OrganizerState>(
        builder: (context, state) {
          return _buildCard(
              context,
              (state as OrganizerLoadedEventPlayers).players,
              state.eventStats.name);
        },
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, List<Player> players, String eventName) {
    return PageWithWatermark(
        floatingActionButton: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 104, 159, 56),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_add_alt,
              size: 30,
              color: Colors.white,
            )),
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
