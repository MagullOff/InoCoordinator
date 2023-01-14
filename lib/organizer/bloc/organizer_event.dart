part of 'organizer_bloc.dart';

abstract class OrganizerEvent extends Equatable {
  const OrganizerEvent();

  @override
  List<Object> get props => [];
}

class GetOrganizerEvents extends OrganizerEvent {}

class GetEventStats extends OrganizerEvent {
  final String eventId;
  const GetEventStats({required this.eventId});
}

class GetEventPlayers extends OrganizerEvent {
  final String eventId;
  const GetEventPlayers({required this.eventId});
}

class GetEventPoints extends OrganizerEvent {
  final String eventId;
  const GetEventPoints({required this.eventId});
}

class GetPlayerStats extends OrganizerEvent {
  final String playerId;
  const GetPlayerStats({required this.playerId});
}

class GetAddPlayerForm extends OrganizerEvent {
  final String eventId;

  const GetAddPlayerForm(this.eventId);
}

class PopPage extends OrganizerEvent {}
