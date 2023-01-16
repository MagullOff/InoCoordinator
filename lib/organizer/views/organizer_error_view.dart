import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';
import 'package:ino_coordinator/themes.dart';

class OrganizerErrorView extends StatelessWidget {
  final Exception error;
  const OrganizerErrorView({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
        appBar: Themes.defaultAppBar(),
        child: Center(
            child: Text(error.toString(),
                textAlign: TextAlign.center,
                style: Themes.textTheme().headline2)));
  }
}
