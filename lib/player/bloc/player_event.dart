part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class GetPlayerStats extends PlayerEvent {}

class CapturePoint extends PlayerEvent {
  final String code;

  const CapturePoint(this.code);
}
