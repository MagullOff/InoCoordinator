import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:ino_coordinator/player/player_repository.dart';
import 'package:ino_coordinator/player/views/qr_view.dart';
import 'package:ino_coordinator/shared/components/loading_view.dart';
import 'package:ino_coordinator/shared/model/player_stats.dart';
import 'package:ino_coordinator/shared/components/default_floating_button.dart';
import 'package:ino_coordinator/shared/components/list_item.dart';
import 'package:ino_coordinator/shared/components/list_view_builder.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';
import 'package:ino_coordinator/shared/components/percentage_display.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return const LoadingView(
                    isAppBarEnabled: false,
                  );
                } else if (state is PlayerLoaded) {
                  return _buildView(context, state.stats);
                } else {
                  return QrScanView();
                }
              },
            ),
          )),
    );
  }

  Widget _buildView(BuildContext context, PlayerStats model) {
    return PageWithWatermark(
      floatingActionButton: DefaultFloatingButton(
          icon: Icons.qr_code_2,
          onTap: () async {
            var status = await Permission.camera.status;
            if (!status.isDenied) {
              // ignore: use_build_context_synchronously
              context.read<PlayerBloc>().add(BeginPointCapture());
            }
          }),
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
