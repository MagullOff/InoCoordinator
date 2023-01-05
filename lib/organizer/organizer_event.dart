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

class GetEventUsers extends OrganizerEvent {
  final String eventId;
  GetEventUsers({required this.eventId});
}

class GetUserStats extends OrganizerEvent {
  final String userId;
  GetUserStats({required this.userId});
}
