import 'package:flutter/material.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../../themes.dart';

class LoadingView extends StatelessWidget {
  final bool isAppBarEnabled;
  const LoadingView({super.key, this.isAppBarEnabled = true});

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
        appBar: isAppBarEnabled ? Themes.defaultAppBar() : null,
        child: Center(
          child: CircularProgressIndicator(
            color: Themes.primary,
          ),
        ));
  }
}
