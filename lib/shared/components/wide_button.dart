import 'package:flutter/material.dart';

import '../../themes.dart';

enum ButtonType { primary, secondary }

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

  WideButton.fromTheme(
      {Key? key,
      void Function()? onClick,
      required String title,
      required ButtonType buttonType})
      : this(
            key: key,
            onClick: onClick,
            title: title,
            primary: buttonType == ButtonType.primary
                ? Themes.backGround
                : Themes.primary,
            background: buttonType == ButtonType.secondary
                ? Themes.backGround
                : Themes.primary);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
          onPressed: onClick,
          child: Text(title)),
    );
  }
}
