import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/organizer_bloc.dart';

import '../model/event.dart';

class OrganizerEventsView extends StatelessWidget {
  const OrganizerEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<OrganizerBloc, OrganizerState>(
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
              context, (state as OrganizerLoadedEvents).events, 'Piotrek32');
        },
      ),
    ));
  }

  Widget _buildCard(BuildContext context, List<Event> events, String name) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          children: [_buildTitle(context, name), _buildList(context, events)]),
    ));
  }

  Widget _buildList(BuildContext context, List<Event> list) {
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
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event,
                        color: textColor,
                      ),
                    ],
                  ),
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
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Center(
        child: Text('Welcome $title!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}
