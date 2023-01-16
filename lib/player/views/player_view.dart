import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:ino_coordinator/player/player_repository.dart';
import 'package:ino_coordinator/model/player_stats.dart';
import 'package:ino_coordinator/shared/default_floating_button.dart';
import 'package:ino_coordinator/shared/list_item.dart';
import 'package:ino_coordinator/shared/list_view_builder.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/shared/percentage_display.dart';
import 'package:ino_coordinator/themes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
                } else if (state is PlayerCapture) {
                  return _buildCaptureView();
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
      floatingActionButton: DefaultFloatingButton(
          icon: Icons.qr_code_2,
          onTap: () {
            context.read<PlayerBloc>().add(BeginPointCapture());
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCaptureView() {
    MobileScannerController cameraController = MobileScannerController();
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: Themes.defaultAppBar(
            title: 'Scan the code',
            actions: [
              IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off, color: Colors.grey);
                      case TorchState.on:
                        return const Icon(Icons.flash_on, color: Colors.yellow);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.toggleTorch(),
              ),
              IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front);
                      case CameraFacing.back:
                        return const Icon(Icons.camera_rear);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),
          body: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  context.read<PlayerBloc>().add(GetPlayerStats());
                } else {
                  final String code = barcode.rawValue!;
                  context.read<PlayerBloc>().add(CapturePoint(code));
                }
              }),
        );
      },
    );
  }
}
