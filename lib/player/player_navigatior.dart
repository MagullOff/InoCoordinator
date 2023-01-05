import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:ino_coordinator/player/player_view.dart';

class PlayerNavigator extends StatelessWidget {
  const PlayerNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is PlayerError)
              MaterialPage(child: Container(child: Text('error player'))),
            if (state is PlayerLoading) MaterialPage(child: LoadingView()),
            if (state is PlayerLoaded) MaterialPage(child: PlayerView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
