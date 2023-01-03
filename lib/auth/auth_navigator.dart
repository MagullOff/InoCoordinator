import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/auth_cubit.dart';
import 'package:ino_coordinator/auth/register/register.dart';
import 'package:ino_coordinator/auth/show_code.dart';

import 'login/login.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is LoginAuthState) MaterialPage(child: Login()),
            if (state is SignUpAuthState || state is ShowCodeAuthState) ...[
              MaterialPage(child: Register()),
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
