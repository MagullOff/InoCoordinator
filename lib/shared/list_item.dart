import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../themes.dart';

enum ListItemTheme { primary, secondary }

class ListItem extends StatelessWidget {
  final void Function()? onTap;
  final IconData? leading;
  final String subtitle;
  final String title;
  final String? trailingText;
  final IconData? trailingIcon;
  late Color textColor;
  late Color mainColor;
  ListItem(
      {super.key,
      this.onTap,
      this.leading,
      this.subtitle = '',
      required this.title,
      ListItemTheme theme = ListItemTheme.primary,
      this.trailingText,
      this.trailingIcon}) {
    textColor =
        theme == ListItemTheme.primary ? Themes.secondary : Themes.primary;
    mainColor = theme == ListItemTheme.primary
        ? Themes.backGround
        : Themes.primaryLight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(64, 0, 0, 0),
                spreadRadius: 2,
                blurRadius: 4)
          ],
        ),
        child: ListTile(
          onTap: onTap,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                leading,
                color: textColor,
              ),
            ],
          ),
          subtitle: Text(subtitle),
          title: Text(title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: textColor,
                ),
              if (trailingText != null)
                Text(trailingText!,
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}
