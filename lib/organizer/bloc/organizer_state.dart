part of 'organizer_bloc.dart';

abstract class OrganizerState extends Equatable {
  const OrganizerState();

  @override
  List<Object> get props => [];
}

class OrganizerLoading extends OrganizerState {}

class OrganizerLoadedEvents extends OrganizerState {
  final List<Event> events;
  OrganizerLoadedEvents(this.events);
}

class OrganizerLoadedEventStats extends OrganizerLoadedEvents {
  final Event eventStats;
  OrganizerLoadedEventStats(
      {required this.eventStats,
      required OrganizerLoadedEvents organizerLoadedEvents})
      : super(organizerLoadedEvents.events);
}

class OrganizerLoadedPlayerStats extends OrganizerState {
  final PlayerStats playerStats;
  OrganizerLoadedPlayerStats(this.playerStats);
}

class OrganizerLoadedEventPlayers extends OrganizerLoadedEventStats {
  final List<Player> players;
  OrganizerLoadedEventPlayers(
      this.players, OrganizerLoadedEventStats organizerLoadedEventStats)
      : super(
            eventStats: organizerLoadedEventStats.eventStats,
            organizerLoadedEvents:
                OrganizerLoadedEvents(organizerLoadedEventStats.events));
}

class OrganizerLoadedEventPoints extends OrganizerLoadedEventStats {
  final List<Point> points;
  OrganizerLoadedEventPoints(
      this.points, OrganizerLoadedEventStats organizerLoadedEventStats)
      : super(
            eventStats: organizerLoadedEventStats.eventStats,
            organizerLoadedEvents:
                OrganizerLoadedEvents(organizerLoadedEventStats.events));
}

class OrganizerError extends OrganizerState {
  String? message;
  OrganizerError(this.message);
}
