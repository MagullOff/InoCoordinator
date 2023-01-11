import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:ino_coordinator/data/player_repository.dart';
import 'package:ino_coordinator/data/model/player_stats.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/shared/percentage_display.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

  Widget _buildView(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (context) {
            var sesstionCubit = context.read<SessionCubit>();
            return PlayerBloc(
                sessionCubit: sesstionCubit,
                playerRepo: context.read<PlayerRepository>(),
                playerCredentials: sesstionCubit.playerCredentials)
              ..add(GetPlayerStats());
          },
          child: BlocListener<PlayerBloc, PlayerState>(
            listener: ((context, state) {
              if (state is PlayerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }),
            child: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return _buildLoading();
                } else if (state is PlayerLoaded) {
                  return _buildCard(context, state.stats);
                } else if (state is PlayerError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }

  Widget _buildCard(BuildContext context, PlayerStats model) {
    return PageWithWatermark(
      floatingActionButton: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 104, 159, 56),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.qr_code_2,
            size: 30,
            color: Colors.white,
          )),
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
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
        return ListItem(
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

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
