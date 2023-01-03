import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ino_coordinator/auth/components.dart';

class ShowCode extends StatelessWidget {
  const ShowCode({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: appBar(context1),
      body: Center(
        child: Text(code),
      ),
    );
  }
}
