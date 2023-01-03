import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/auth_cubit.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:ino_coordinator/auth/components.dart';

import '../auth_repository.dart';
import 'login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: appBar(context1),
      body: BlocProvider(
          create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_loginForm(), _signUpButton(context1)],
          )),
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
                    _codeField(),
                    _submitButton("Continue"),
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

  Widget _signUpButton(BuildContext buildContext) {
    return SafeArea(
        child: TextButton(
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.right,
            ),
            onPressed: () => buildContext.read<AuthCubit>().showSignUp()));
  }

  Widget _codeField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) =>
                state.isValidPassCode ? null : "Passcode length is not correct",
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPassCodeChanged(passCode: value)),
            decoration: inputDecoration(context, "Pass code"),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        );
      },
    );
  }

  Widget _submitButton(String message) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(message),
              );
      },
    );
  }
}
