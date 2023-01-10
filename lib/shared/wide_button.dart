import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../themes.dart';

enum ButtonType { primary, secondary }

class WideButton extends StatelessWidget {
  final void Function()? onClick;
  late Color background;
  late Color primary;
  final String title;
  WideButton(
      {super.key,
      this.onClick,
      required this.title,
      required ButtonType buttonType}) {
    primary = Themes.backGround;
    background = Themes.primary;
    if (buttonType == ButtonType.primary) {
      primary = Themes.primary;
      background = Themes.backGround;
    }
  }

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
