part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginPassCodeChanged extends LoginEvent {
  final String passCode;

  LoginPassCodeChanged({required this.passCode});
}

class LoginSubmitted extends LoginEvent {}
