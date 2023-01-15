import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/shared/form_submission_status.dart';

import '../../../data/organizer_repository.dart';
import '../../bloc/organizer_bloc.dart';

part 'add_event_event.dart';
part 'add_event_state.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  final OrganizerRepository organizerRepository;
  final OrganizerBloc organizerBloc;
  AddEventBloc({required this.organizerRepository, required this.organizerBloc})
      : super(const AddEventState()) {
    on<AddEventNameChanged>((event, emit) {
      emit(AddEventState(eventName: event.eventName));
    });
    on<AddEventSubmitted>((event, emit) async {
      emit(AddEventState(
          eventName: state.eventName, formStatus: FormSubmitting()));
      try {
        await organizerRepository.addEvent(
            organizerBloc.organizerCredentials, state.eventName);
        emit(AddEventState(
            eventName: state.eventName, formStatus: SubmissionSuccess()));
        organizerBloc.add(GetOrganizerEvents());
      } on Exception catch (e, _) {
        emit(AddEventState(
            eventName: state.eventName, formStatus: SubmissionFailed(e)));
      }
    });
  }
}