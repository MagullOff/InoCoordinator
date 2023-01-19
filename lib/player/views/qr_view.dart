import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../shared/functions/show_snackbar.dart';
import '../../themes.dart';

class QrScanView extends StatelessWidget {
  final MobileScannerController cameraController = MobileScannerController();
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
