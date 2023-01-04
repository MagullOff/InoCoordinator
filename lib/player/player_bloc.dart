import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/player_repository.dart';
import 'package:ino_coordinator/player/player_stats.dart';
import 'package:intl/intl.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SessionCubit sessionCubit;
  final PlayerRepository playerRepo;
  final Credentials playerCredentials;
  PlayerBloc(
      {required this.sessionCubit,
      required this.playerCredentials,
      required this.playerRepo})
      : super(PlayerLoading()) {
    on<GetPlayerStats>((event, emit) async {
      try {
        var stats = await playerRepo.getPlayerStats(playerCredentials);
        emit(PlayerLoaded(stats: stats));
      } on Exception catch (e, _) {
        emit(PlayerError(e.toString()));
      }
    });
  }
}
