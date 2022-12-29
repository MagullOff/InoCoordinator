import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyScore extends StatefulWidget {
  const MyScore({super.key});

  @override
  State<MyScore> createState() => _MyScoreState();
}

class _MyScoreState extends State<MyScore> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('player logged in'));
  }
}
