import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/data/model/point.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerEventPointsView extends StatelessWidget {
  const OrganizerEventPointsView({super.key});

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
              (state as OrganizerLoadedEventPoints).points,
              state.eventStats.name);
        },
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, List<Point> points, String eventName) {
    return PageWithWatermark(
        floatingActionButton: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 104, 159, 56),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add_location_alt_rounded,
              size: 30,
              color: Colors.white,
            )),
        appBar: Themes.defaultAppBar(title: eventName),
        child: SingleChildScrollView(
          child: Column(children: [_buildList(context, points)]),
        ));
  }

  Widget _buildList(BuildContext context, List<Point> list) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListViewBuilder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListItem(
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
