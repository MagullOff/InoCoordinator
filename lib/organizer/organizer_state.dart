part of 'organizer_bloc.dart';

abstract class OrganizerState extends Equatable {
  const OrganizerState();

  @override
  List<Object> get props => [];
}

class OrganizerLoading extends OrganizerState {}

class OrganizerLoadedEvents extends OrganizerState {
  final List<Event> events;
  OrganizerLoadedEvents({required this.events});
}

class OrganizerLoadedEventStats extends OrganizerState {
  final EventStats eventStats;
  OrganizerLoadedEventStats({required this.eventStats});
}

class OrganizerLoadedPlayerStats extends OrganizerState {
  final PlayerStats playerStats;
  OrganizerLoadedPlayerStats({required this.playerStats});
}

class OrganizerError extends OrganizerState {
  String? message;
  OrganizerError({this.message});
}
