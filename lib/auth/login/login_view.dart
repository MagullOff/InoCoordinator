import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/cubit/auth_cubit.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/shared/wide_button.dart';

import '../../data/auth_repository.dart';
import '../../themes.dart';
import 'bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
      child: BlocProvider(
          create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                showSnackBar(context, formStatus.exception.toString());
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _loginForm(context),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _submitButton(),
                    SizedBox(height: 10),
                    _signUpButton(context),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    'Enter your player code to log in',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                _codeField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return WideButton(
      onClick: () => context.read<AuthCubit>().showSignUp(),
      background: Themes.backGround,
      primary: Themes.primary,
      title: "Sign up",
    );
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

  Widget _submitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : WideButton(
                onClick: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                background: Themes.primary,
                title: 'Continue',
                primary: Themes.backGround,
              );
      },
    );
  }
}
