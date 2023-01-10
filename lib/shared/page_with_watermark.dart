import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../themes.dart';

class PageWithWatermark extends StatelessWidget {
  final Widget? child;
  final AppBar? appBar;
  const PageWithWatermark({super.key, this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
          color: Themes.backGround,
          child: Stack(
            children: [
              Positioned.fromRect(
                rect: const Offset(100, 350) & const Size(450, 450),
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset('images/icon512.png', fit: BoxFit.cover),
                ),
              ),
              if (child != null) child!
            ],
          )),
    );
  }
}
