import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/cubit/auth_cubit.dart';
import 'package:ino_coordinator/auth/signup/signup_view.dart';
import 'package:ino_coordinator/auth/signup/show_code.dart';

import 'login/login_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is LoginAuthState) MaterialPage(child: LoginView()),
            if (state is SignUpAuthState || state is ShowCodeAuthState) ...[
              MaterialPage(child: SignUpView()),
              if (state is ShowCodeAuthState)
                MaterialPage(child: ShowCode(code: state.code)),
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
