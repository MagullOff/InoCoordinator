part of 'session_cubit.dart';

class Credentials {
  String passcode;
  String id;

  Credentials({required this.id, required this.passcode});
}

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class AuthenticatedOrganizer extends SessionState {
  final Credentials credentials;

  AuthenticatedOrganizer({required this.credentials});
}

class AuthenticatedPlayer extends SessionState {
  final Credentials credentials;

  AuthenticatedPlayer({required this.credentials});
}
