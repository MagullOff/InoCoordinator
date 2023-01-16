import 'package:flutter/material.dart';

import '../themes.dart';

class PageWithWatermark extends StatelessWidget {
  final Widget? child;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  const PageWithWatermark(
      {super.key, this.child, this.appBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
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
              if (child != null)
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: child!)
            ],
          )),
    );
  }
}
