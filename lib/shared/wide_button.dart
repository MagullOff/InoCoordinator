import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../themes.dart';

class WideButton extends StatelessWidget {
  final void Function()? onClick;
  final Color background;
  final Color primary;
  final String title;
  const WideButton(
      {super.key,
      this.onClick,
      required this.background,
      required this.primary,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(64, 0, 0, 0),
              spreadRadius: 2,
              blurRadius: 4)
        ],
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: background,
              foregroundColor: primary,
              minimumSize: const Size.fromHeight(50),
              textStyle: Themes.textTheme().button),
          child: Text(title),
          onPressed: onClick),
    );
  }
}
