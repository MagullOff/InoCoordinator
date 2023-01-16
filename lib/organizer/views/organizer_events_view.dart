import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../model/event.dart';
import '../../shared/default_floating_button.dart';

class OrganizerEventsView extends StatelessWidget {
  final List<Event> events;
  const OrganizerEventsView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildCard(context, events, 'Piotrek32'));
  }

  Widget _buildCard(BuildContext context, List<Event> events, String name) {
    return PageWithWatermark(
        floatingActionButton: DefaultFloatingButton(
          icon: Icons.add,
          onTap: () {
            context.read<OrganizerBloc>().add(GetAddEventForm());
          },
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            _buildTitle(context, name),
            _buildList(context, events)
          ]),
        ));
  }

  Widget _buildList(BuildContext context, List<Event> list) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListViewBuilder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListItem(
                  onTap: () => {
                    context
                        .read<OrganizerBloc>()
                        .add(GetEventStats(eventId: list[index].id))
                  },
                  leading: Icons.event,
                  title: list[index].name,
                  trailingIcon: Icons.chevron_right,
                );
              }),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Center(
        child: Text('Welcome $title!',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}
