import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/player/bloc/player_bloc.dart';
import 'package:ino_coordinator/player/views/player_view.dart';

class PlayerNavigator extends StatelessWidget {
  const PlayerNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is PlayerError)
              const MaterialPage(child: Text('error player')),
            if (state is PlayerLoading) MaterialPage(child: LoadingView()),
            if (state is PlayerLoaded) const MaterialPage(child: PlayerView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
