import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/shared/components/form_submission_status.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/auth/signup/bloc/signup_bloc.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';
import 'package:ino_coordinator/shared/components/submission_form.dart';
import 'package:ino_coordinator/shared/components/text_input_field.dart';

import '../../shared/components/wide_button.dart';
import '../cubit/auth_cubit.dart';
import '../auth_repository.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageWithWatermark(
        child: BlocProvider(
      create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>()),
      child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              showSnackBar(context, formStatus.exception.toString());
            }
          },
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _loginButton(context),
                const SizedBox(height: 10),
                _submitButton(),
              ],
            ),
            _signUpForm(),
          ])),
    ));
  }

  Widget _signUpForm() {
    return SubmissionForm(
      formKey: _formKey,
      input: Column(
        children: [_usernameField(), _emailField()],
      ),
      title: 'Enter your desired username to sign up',
    );
  }

  Widget _loginButton(BuildContext context) {
    return WideButton.fromTheme(
      onClick: () => context.read<AuthCubit>().showLogin(),
      title: "Go to log in",
      buttonType: ButtonType.secondary,
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            validator: (value) =>
                state.isValidUsername ? null : "Username is not valid",
            onChanged: (value) => context
                .read<SignUpBloc>()
                .add(SignUpUsernameChanged(username: value)),
            decorationText: "Username",
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextInputField(
            validator: (value) =>
                state.isValidEmail ? null : "Email is not valid",
            onChanged: (value) => context
                .read<SignUpBloc>()
                .add(SignUpEmailChanged(email: value)),
            decorationText: "Email",
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : WideButton.fromTheme(
                onClick: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
                  }
                },
                title: 'Continue',
                buttonType: ButtonType.primary,
              );
      },
    );
  }
}
