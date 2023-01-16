import 'package:flutter/material.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWithWatermark(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
