import 'package:flutter/material.dart';

class ListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const ListViewBuilder(
      {super.key, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ScrollPhysics(parent: null),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: itemBuilder(context, index),
          );
        });
  }
}
