part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  const SignUpUsernameChanged({required this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged({required this.email});
}

class SignUpSubmitted extends SignUpEvent {}
