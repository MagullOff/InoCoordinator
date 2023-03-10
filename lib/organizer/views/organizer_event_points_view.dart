import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/shared/model/point.dart';
import 'package:ino_coordinator/shared/components/default_floating_button.dart';
import 'package:ino_coordinator/shared/components/list_item.dart';
import 'package:ino_coordinator/shared/components/list_view_builder.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerEventPointsView extends StatelessWidget {
  final List<Point> points;
  final String eventName;
  final String eventId;
  const OrganizerEventPointsView(
      {super.key,
      required this.eventId,
      required this.points,
      required this.eventName});

  @override
  Widget build(BuildContext context) {
    return _buildCard(context, points, eventName);
  }

  Widget _buildCard(
      BuildContext context, List<Point> points, String eventName) {
    return PageWithWatermark(
        floatingActionButton: DefaultFloatingButton(
          icon: Icons.add_location_alt_rounded,
          onTap: () {
            context.read<OrganizerBloc>().add(GetAddPointForm(eventId));
          },
        ),
        appBar: Themes.defaultAppBar(title: eventName),
        child: SingleChildScrollView(
          child: Column(children: [_buildList(context, points)]),
        ));
  }

  Widget _buildList(BuildContext context, List<Point> list) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListViewBuilder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListItem.fromTheme(
                leading: Icons.location_on,
                subtitle: 'Scan code: ${list[index].code}',
                title: list[index].name,
              );
            },
          ),
        );
      },
    );
  }
}
