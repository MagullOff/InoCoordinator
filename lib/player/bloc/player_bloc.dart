import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/player_repository.dart';
import 'package:ino_coordinator/model/player_stats.dart';

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
    on<CapturePoint>((event, emit) async {
      try {
        await playerRepo.capturePoint(playerCredentials, event.code);
        var stats = await playerRepo.getPlayerStats(playerCredentials);
        emit(PlayerLoaded(stats: stats));
      } on Exception catch (e, _) {
        emit(PlayerError(e.toString()));
      }
    });
    on<BeginPointCapture>((event, emit) async {
      emit(PlayerCapture());
    });
  }
}
