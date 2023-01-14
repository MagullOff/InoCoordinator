part of 'add_player_bloc.dart';

abstract class AddPlayerEvent extends Equatable {
  const AddPlayerEvent();

  @override
  List<Object> get props => [];
}

class AddPlayerUsernameChanged extends AddPlayerEvent {
  final String username;

  const AddPlayerUsernameChanged(this.username);
}

class AddPlayerSubmitted extends AddPlayerEvent {}
