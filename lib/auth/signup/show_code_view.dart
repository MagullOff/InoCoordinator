import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../../themes.dart';

class ShowCodeView extends StatelessWidget {
  const ShowCodeView({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
      appBar: Themes.defaultAppBar(),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            'Your sign up code',
            textAlign: TextAlign.center,
            style: Themes.textTheme().headline2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Please remember to write it down!',
            textAlign: TextAlign.center,
            style: Themes.textTheme().headline4,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            code,
            textAlign: TextAlign.center,
            style: Themes.textTheme().caption,
          ),
        ],
      ),
    );
  }
}
