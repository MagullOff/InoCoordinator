part of 'add_event_bloc.dart';

abstract class AddEventEvent extends Equatable {
  const AddEventEvent();

  @override
  List<Object> get props => [];
}

class AddEventNameChanged extends AddEventEvent {
  final String eventName;

  const AddEventNameChanged(this.eventName);
}

class AddEventSubmitted extends AddEventEvent {}
