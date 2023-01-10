import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../themes.dart';

class ShowCode extends StatelessWidget {
  const ShowCode({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
      appBar: Themes.defaultAppBar(),
      child: Center(
        child: Text(code),
      ),
    );
  }
}
