part of 'add_event_bloc.dart';

class AddEventState extends Equatable {
  final String eventName;
  bool get isValidEventName => eventName.length > 5 && eventName.length < 15;

  final FormSubmissionStatus formStatus;
  const AddEventState(
      {this.eventName = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object> get props => [eventName, formStatus];
}
