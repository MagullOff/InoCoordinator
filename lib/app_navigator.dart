import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/auth_cubit.dart';
import 'package:ino_coordinator/auth/auth_navigator.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/session_view.dart';

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
              MaterialPage(child: SessionView()),
            if (state is AuthenticatedPlayer)
              MaterialPage(child: SessionView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
