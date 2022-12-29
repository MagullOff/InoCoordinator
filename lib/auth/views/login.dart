import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:ino_coordinator/auth/views/components.dart';

import '../auth_repository.dart';
import '../login/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepo: context.read<AuthRepository>()),
          child: _loginForm()),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Container(
        color: Colors.grey[100],
        child: Stack(
          children: [
            Positioned.fromRect(
              rect: const Offset(100, 350) & const Size(450, 450),
              child: Opacity(
                opacity: 0.2,
                child: Image.asset('images/icon512.png', fit: BoxFit.cover),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    icon(),
                    Text(
                      'Enter your player code to log in',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    codeField(),
                    submitButton("Continue", _formKey),
                    redirectHyperlink(context, "Register", "/register"),
                    const SizedBox(
                      height: 130,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
