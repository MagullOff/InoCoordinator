import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';

import '../../data/model/player.dart';

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
    return Scaffold(
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
        appBar: AppBar(
          title: Text(eventName),
        ),
        body: SingleChildScrollView(
          child: Column(children: [_buildList(context, players)]),
        ));
  }

  Widget _buildList(BuildContext context, List<Player> list) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
            physics: ScrollPhysics(parent: null),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              var textColor = Color.fromARGB(255, 55, 55, 55);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(64, 0, 0, 0),
                            spreadRadius: 2,
                            blurRadius: 4)
                      ],
                    ),
                    child: ListTile(
                      onTap: () => {
                        context
                            .read<OrganizerBloc>()
                            .add(GetPlayerStats(userId: list[index].id))
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: textColor,
                          ),
                        ],
                      ),
                      subtitle: Text('Access code: ${list[index].code}'),
                      title: Text(list[index].name,
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chevron_right,
                            color: textColor,
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        );
      },
    );
  }
}
