part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpSubmitted extends SignUpEvent {}
