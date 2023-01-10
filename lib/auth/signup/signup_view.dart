import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/auth/signup/bloc/signup_bloc.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';
import 'package:ino_coordinator/shared/submission_form.dart';
import 'package:ino_coordinator/shared/text_input_field.dart';

import '../../shared/wide_button.dart';
import '../../themes.dart';
import '../cubit/auth_cubit.dart';
import '../../data/auth_repository.dart';
import '../login/bloc/login_bloc.dart';

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
                _submitButton(),
                const SizedBox(height: 10),
                _loginButton(context),
              ],
            ),
            _signUpForm(),
          ])),
    ));
  }

  Widget _signUpForm() {
    return SubmissionForm(
      formKey: _formKey,
      input: _usernameField(),
      title: 'Enter your desired username to sign up',
    );
  }

  Widget _loginButton(BuildContext context) {
    return WideButton(
      onClick: () => context.read<AuthCubit>().showLogin(),
      title: "Log in",
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

  Widget _submitButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : WideButton(
                onClick: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
                  }
                },
                title: 'Submit',
                buttonType: ButtonType.primary,
              );
      },
    );
  }
}
