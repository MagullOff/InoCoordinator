import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/cubit/auth_cubit.dart';
import 'package:ino_coordinator/auth/auth_navigator.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/organizer/organizer_navigation.dart';
import 'package:ino_coordinator/data/organizer_repository.dart';
import 'package:ino_coordinator/player/player_navigatior.dart';
import 'package:ino_coordinator/data/player_repository.dart';
import 'package:ino_coordinator/player/player_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is UnknownSessionState)
              MaterialPage(child: LoadingView()),
            if (state is Unauthenticated)
              MaterialPage(
                  child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              )),
            if (state is AuthenticatedOrganizer)
              MaterialPage(
                  child: RepositoryProvider(
                create: (context) => OrganizerRepository(),
                child: BlocProvider(
                  create: (context) {
                    var sessionCubit = context.read<SessionCubit>();
                    return OrganizerBloc(
                        organizerCredentials: sessionCubit.organizerCredentials,
                        organizerRepository:
                            context.read<OrganizerRepository>(),
                        sessionCubit: sessionCubit)
                      ..add(GetOrganizerEvents());
                  },
                  child: OrganizerNavigator(),
                ),
              )),
            if (state is AuthenticatedPlayer)
              MaterialPage(
                  child: RepositoryProvider(
                create: (context) => PlayerRepository(),
                child: PlayerView(),
              )),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
