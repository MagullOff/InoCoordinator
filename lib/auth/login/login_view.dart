import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/cubit/auth_cubit.dart';
import 'package:ino_coordinator/shared/components/form_submission_status.dart';
import 'package:ino_coordinator/shared/functions/show_snackbar.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';
import 'package:ino_coordinator/shared/components/submission_form.dart';
import 'package:ino_coordinator/shared/components/text_input_field.dart';
import 'package:ino_coordinator/shared/components/wide_button.dart';

import '../auth_repository.dart';
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _signUpButton(context),
                    const SizedBox(height: 10),
                    _submitButton(),
                  ],
                ),
                _loginForm(),
              ],
            ),
          )),
    );
  }

  Widget _loginForm() {
    return SubmissionForm(
      formKey: _formKey,
      title: 'Enter your player code to log in',
      input: _codeField(),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return WideButton.fromTheme(
      onClick: () => context.read<AuthCubit>().showSignUp(),
      title: "Go to sign up",
      buttonType: ButtonType.secondary,
    );
  }

  Widget _codeField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            inputType: InputType.numeric,
            validator: (value) =>
                state.isValidPassCode ? null : "Passcode length is not correct",
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPassCodeChanged(passCode: value)),
            decorationText: "Pass code",
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
            : WideButton.fromTheme(
                onClick: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                title: 'Continue',
                buttonType: ButtonType.primary,
              );
      },
    );
  }
}
