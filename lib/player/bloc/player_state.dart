part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final PlayerStats stats;
  const PlayerLoaded({required this.stats});
}

class PlayerCapture extends PlayerState {}

class PlayerError extends PlayerState {
  final String? message;
  const PlayerError(this.message);
}
