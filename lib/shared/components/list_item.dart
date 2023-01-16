import 'package:flutter/material.dart';

import '../../themes.dart';

enum ListItemTheme { primary, secondary }

class ListItem extends StatelessWidget {
  final void Function()? onTap;
  final IconData? leading;
  final String subtitle;
  final String title;
  final String? trailingText;
  final IconData? trailingIcon;
  final Color textColor;
  final Color mainColor;

  const ListItem(
      {super.key,
      this.onTap,
      this.leading,
      required this.subtitle,
      required this.title,
      this.trailingText,
      this.trailingIcon,
      required this.textColor,
      required this.mainColor});

  ListItem.fromTheme(
      {Key? key,
      void Function()? onTap,
      IconData? leading,
      String subtitle = '',
      required String title,
      ListItemTheme theme = ListItemTheme.primary,
      String? trailingText,
      IconData? trailingIcon})
      : this(
            key: key,
            onTap: onTap,
            leading: leading,
            subtitle: subtitle,
            title: title,
            trailingIcon: trailingIcon,
            trailingText: trailingText,
            mainColor: theme == ListItemTheme.primary
                ? Themes.backGround
                : Themes.primaryLight,
            textColor: theme == ListItemTheme.primary
                ? Themes.secondary
                : Themes.primary);

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
