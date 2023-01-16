import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/organizer/organizer_repository.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/organizer/add_player/organizer_add_player_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_error_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_event_players_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_events_stats_view.dart';
import 'package:ino_coordinator/shared/components/page_with_watermark.dart';

import '../add_event/organizer_add_event_view.dart';
import '../add_point/organizer_add_point_view.dart';
import '../views/organizer_event_points_view.dart';
import '../views/organizer_events_view.dart';
import '../views/organizer_player_stats_view.dart';

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
      : super(OrganizerState.base()) {
    on<GetOrganizerEvents>((event, emit) async {
      try {
        final events =
            await organizerRepository.getOrganizerEvents(organizerCredentials);
        final organizerName =
            await organizerRepository.getMyName(organizerCredentials);
        emit(OrganizerState.addPage(
            state,
            OrganizerEventsView(
              events: events,
              organizerName: organizerName,
            )));
      } on Exception catch (e, _) {
        emit(OrganizerState.addPage(state, const LoadingView()));
      }
    });
    on<GetEventStats>((event, emit) async {
      emit(OrganizerState.addPage(state, const LoadingView()));
      try {
        final eventStats = await organizerRepository.getEvent(
            organizerCredentials, event.eventId);
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state, OrganizerEventStatsView(eventStats: eventStats)));
      } on Exception catch (e, _) {
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerErrorView(
              error: e,
            )));
      }
    });
    on<GetEventPlayers>((event, emit) async {
      emit(OrganizerState.addPage(state, const LoadingView()));
      try {
        final eventPlayers = await organizerRepository.getPlayers(
            organizerCredentials, event.eventId);
        final eventStats = await organizerRepository.getEvent(
            organizerCredentials, event.eventId);
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerEventPlayersView(
              eventName: eventStats.name,
              players: eventPlayers,
              eventId: eventStats.id,
            )));
      } on Exception catch (e, _) {
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerErrorView(
              error: e,
            )));
      }
    });
    on<GetEventPoints>((event, emit) async {
      emit(OrganizerState.addPage(state, const LoadingView()));
      try {
        final eventPoints = await organizerRepository.getPoints(
            organizerCredentials, event.eventId);
        final eventStats = await organizerRepository.getEvent(
            organizerCredentials, event.eventId);
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerEventPointsView(
              eventName: eventStats.name,
              eventId: eventStats.id,
              points: eventPoints,
            )));
      } on Exception catch (e, _) {
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerErrorView(
              error: e,
            )));
      }
    });
    on<GetPlayerStats>((event, emit) async {
      emit(OrganizerState.addPage(state, const LoadingView()));
      try {
        final playerStats = await organizerRepository.getPlayerStats(
            organizerCredentials, event.playerId);
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state, OrganizerPlayerStatsView(stats: playerStats)));
      } on Exception catch (e, _) {
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.addPage(
            state,
            OrganizerErrorView(
              error: e,
            )));
      }
    });
    on<GetAddPlayerForm>((event, emit) {
      emit(OrganizerState.addPage(
          state, OrganizerAddPlayerView(eventId: event.eventId)));
    });
    on<GetAddPointForm>((event, emit) {
      emit(OrganizerState.addPage(
          state, OrganizerAddPointView(eventId: event.eventId)));
    });
    on<GetAddEventForm>((event, emit) {
      emit(OrganizerState.addPage(state, OrganizerAddEventView()));
    });
    on<PopPage>((event, emit) {
      emit(OrganizerState.pagePop(state));
    });
  }
}
