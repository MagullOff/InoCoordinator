import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/auth/signup/bloc/signup_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../../data/auth_repository.dart';
import '../login/bloc/login_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocProvider(
          create: (context) => SignUpBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_signUpForm(), _loginButton(context)],
          )),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
                      'Enter your desired username to sign up',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    _usernameField(),
                    _submitButton("Sign up"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext buildContext) {
    return SafeArea(
        child: TextButton(
            child: Text(
              'Log in',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.right,
            ),
            onPressed: () => buildContext.read<AuthCubit>().showLogin()));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: TextFormField(
            validator: (value) =>
                state.isValidUsername ? null : "Username is not valid",
            onChanged: (value) => context
                .read<SignUpBloc>()
                .add(SignUpUsernameChanged(username: value)),
            decoration: inputDecoration(context, "Username"),
          ),
        );
      },
    );
  }

  Widget _submitButton(String message) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
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
