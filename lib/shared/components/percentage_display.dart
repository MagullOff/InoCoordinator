import 'package:flutter/material.dart';

import '../../themes.dart';

class PercentageDisplay extends StatelessWidget {
  final int progressPercent;
  const PercentageDisplay({super.key, required this.progressPercent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 10, color: Themes.primary),
      ),
      child: Center(
          child: Text('$progressPercent%\ncomplete',
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    );
  }
}
