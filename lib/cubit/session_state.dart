part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class AuthenticatedOrganizer extends SessionState {
  final dynamic organizer;

  AuthenticatedOrganizer({this.organizer});
}

class AuthenticatedPlayer extends SessionState {
  final dynamic player;

  AuthenticatedPlayer({this.player});
}
