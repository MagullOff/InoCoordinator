import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';
import 'package:ino_coordinator/shared/components/percentage_display.dart';

import '../../shared/model/player_stats.dart';
import '../../shared/components/list_item.dart';
import '../../shared/components/list_view_builder.dart';
import '../../themes.dart';
import '../bloc/organizer_bloc.dart';

class OrganizerPlayerStatsView extends StatelessWidget {
  final PlayerStats stats;
  const OrganizerPlayerStatsView({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizerBloc, OrganizerState>(
      builder: (context, state) {
        return _buildCard(context, stats);
      },
    );
  }

  Widget _buildCard(BuildContext context, PlayerStats model) {
    return PageWithWatermark(
      appBar: Themes.defaultAppBar(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(context, model.name),
            _buildCapturePercentage(context, model.capturePercentage),
            _buildList(context, model.pointList)
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }

  Widget _buildCapturePercentage(BuildContext context, int capturePercentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PercentageDisplay(progressPercent: capturePercentage),
    );
  }

  Widget _buildList(BuildContext context, List<PointStats> list) {
    return ListViewBuilder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListItem.fromTheme(
          theme: list[index].date == null
              ? ListItemTheme.primary
              : ListItemTheme.secondary,
          leading: list[index].date == null ? Icons.close : Icons.done,
          subtitle: 'Captured by ${list[index].capturePercentage}% of players',
          title: list[index].name,
          trailingText: list[index].date ?? '',
        );
      },
    );
  }
}
