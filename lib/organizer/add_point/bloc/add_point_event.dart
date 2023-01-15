part of 'add_point_bloc.dart';

abstract class AddPointEvent extends Equatable {
  const AddPointEvent();

  @override
  List<Object> get props => [];
}

class AddPointNameChanged extends AddPointEvent {
  final String name;

  const AddPointNameChanged(this.name);
}

class AddPointSubmitted extends AddPointEvent {}
