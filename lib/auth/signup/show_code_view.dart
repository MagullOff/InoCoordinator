import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

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
          SizedBox(
            height: 100,
          ),
          Text(
            'Your sign up code',
            textAlign: TextAlign.center,
            style: Themes.textTheme().headline2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Please remember to write it down!',
            textAlign: TextAlign.center,
            style: Themes.textTheme().headline4,
          ),
          SizedBox(
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
