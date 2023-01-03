part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  RegisterUsernameChanged({required this.username});
}

class RegisterSubmitted extends RegisterEvent {}
