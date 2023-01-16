import 'package:flutter/material.dart';

import '../themes.dart';

class DefaultFloatingButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  const DefaultFloatingButton({super.key, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Themes.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          )),
    );
  }
}
