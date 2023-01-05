part of 'organizer_bloc.dart';

abstract class OrganizerEvent extends Equatable {
  const OrganizerEvent();

  @override
  List<Object> get props => [];
}

class GetOrganizerEvents extends OrganizerEvent {}

class GetEventStats extends OrganizerEvent {
  final String eventId;
  GetEventStats({required this.eventId});
}

class GetEventPlayers extends OrganizerEvent {
  final String eventId;
  GetEventPlayers({required this.eventId});
}

class GetEventPoints extends OrganizerEvent {
  final String eventId;
  GetEventPoints({required this.eventId});
}

class GetPlayerStats extends OrganizerEvent {
  final String userId;
  GetPlayerStats({required this.userId});
}
