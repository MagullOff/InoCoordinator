import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../shared/functions/show_snackbar.dart';
import '../../themes.dart';

class QrScanView extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();
  QrScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: Themes.defaultAppBar(
            title: 'Scan the code',
            actions: [
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
                iconSize: 20.0,
                onPressed: () => cameraController.switchCamera(),
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                iconSize: 20.0,
                onPressed: () =>
                    context.read<PlayerBloc>().add(GetPlayerStats()),
              ),
            ],
          ),
          body: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  showSnackBar(context, 'invalid code');
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
