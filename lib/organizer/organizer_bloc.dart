import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/data/auth_repository.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/data/model/event_stats.dart';
import 'package:ino_coordinator/data/model/player_stats.dart';
import 'package:ino_coordinator/data/organizer_repository.dart';

import '../data/model/event.dart';
import '../data/model/player.dart';
import '../data/model/point.dart';

part 'organizer_event.dart';
part 'organizer_state.dart';

class OrganizerBloc extends Bloc<OrganizerEvent, OrganizerState> {
  final SessionCubit sessionCubit;
  final Credentials organizerCredentials;
  final OrganizerRepository organizerRepository;
  OrganizerBloc(
      {required this.organizerCredentials,
      required this.organizerRepository,
      required this.sessionCubit})
      : super(OrganizerLoading()) {
    on<GetOrganizerEvents>((event, emit) async {
      emit(OrganizerLoading());
      try {
        final events =
            await organizerRepository.getOrganizerEvents(organizerCredentials);
        emit(OrganizerLoadedEvents(events));
      } on Exception catch (e, _) {
        emit(OrganizerError(e.toString()));
      }
    });
    on<GetEventStats>((event, emit) async {
      var oldState = state;
      emit(OrganizerLoading());
      try {
        final eventStats = await organizerRepository.getEvent(
            organizerCredentials, event.eventId);
        emit(OrganizerLoadedEventStats(
            eventStats: eventStats,
            organizerLoadedEvents: oldState as OrganizerLoadedEvents));
      } on Exception catch (e, _) {
        emit(OrganizerError(e.toString()));
      }
    });
    on<GetEventPlayers>((event, emit) async {
      var oldState = state;
      try {
        final eventPlayers = await organizerRepository.getPlayers(
            organizerCredentials, event.eventId);
        emit(OrganizerLoadedEventPlayers(
            eventPlayers, oldState as OrganizerLoadedEventStats));
      } on Exception catch (e, _) {
        emit(OrganizerError(e.toString()));
      }
    });
    on<GetEventPoints>((event, emit) async {
      var oldState = state;
      try {
        final eventPoints = await organizerRepository.getPoints(
            organizerCredentials, event.eventId);
        emit(OrganizerLoadedEventPoints(
            eventPoints, oldState as OrganizerLoadedEventStats));
      } on Exception catch (e, _) {
        emit(OrganizerError(e.toString()));
      }
    });
  }
}
