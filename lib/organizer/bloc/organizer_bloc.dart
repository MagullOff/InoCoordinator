import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ino_coordinator/data/auth_repository.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/data/model/event_stats.dart';
import 'package:ino_coordinator/data/model/player_stats.dart';
import 'package:ino_coordinator/data/organizer_repository.dart';
import 'package:ino_coordinator/loading_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_event_players_view.dart';
import 'package:ino_coordinator/organizer/views/organizer_events_stats_view.dart';
import 'package:ino_coordinator/shared/page_with_watermark.dart';

import '../../data/model/event.dart';
import '../../data/model/player.dart';
import '../../data/model/point.dart';
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
      emit(OrganizerState.addPage(state, LoadingView()));
      try {
        final events =
            await organizerRepository.getOrganizerEvents(organizerCredentials);
        emit(OrganizerState.pagePop(state));
        emit(OrganizerState.popAndAddPage(
            state, OrganizerEventsView(events: events)));
      } on Exception catch (e, _) {
        print(e.toString());
        emit(OrganizerState.popAndAddPage(state, LoadingView()));
      }
    });
    on<GetEventStats>((event, emit) async {
      var oldState = state;
      emit(OrganizerState.addPage(state, LoadingView()));
      try {
        final eventStats = await organizerRepository.getEvent(
            organizerCredentials, event.eventId);
        emit(OrganizerState.popAndAddPage(
            state, OrganizerEventStatsView(eventStats: eventStats)));
      } on Exception catch (e, _) {
        emit(OrganizerState.popAndAddPage(state, LoadingView()));
      }
    });
    on<GetEventPlayers>((event, emit) async {
      var oldState = state;
      try {
        final eventPlayers = await organizerRepository.getPlayers(
            organizerCredentials, event.eventId);
        emit(OrganizerState.popAndAddPage(
            state,
            OrganizerEventPlayersView(
              eventName: 'siuras',
              players: eventPlayers,
            )));
      } on Exception catch (e, _) {
        emit(OrganizerState.popAndAddPage(state, LoadingView()));
      }
    });
    on<GetEventPoints>((event, emit) async {
      var oldState = state;
      try {
        final eventPoints = await organizerRepository.getPoints(
            organizerCredentials, event.eventId);
        emit(OrganizerState.popAndAddPage(
            state,
            OrganizerEventPointsView(
              eventName: 'siuras',
              points: eventPoints,
            )));
      } on Exception catch (e, _) {
        emit(OrganizerState.popAndAddPage(state, LoadingView()));
      }
    });
    on<GetPlayerStats>((event, emit) async {
      var oldState = state;
      try {
        final playerStats = await organizerRepository.getPlayerStats(
            organizerCredentials, event.playerId);
        emit(OrganizerState.popAndAddPage(
            state, OrganizerPlayerStatsView(stats: playerStats)));
      } on Exception catch (e, _) {
        emit(OrganizerState.popAndAddPage(state, LoadingView()));
      }
    });
  }
}
