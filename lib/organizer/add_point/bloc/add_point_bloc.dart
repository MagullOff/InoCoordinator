import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/shared/components/form_submission_status.dart';

import '../../organizer_repository.dart';
import '../../bloc/organizer_bloc.dart';

part 'add_point_event.dart';
part 'add_point_state.dart';

class AddPointBloc extends Bloc<AddPointEvent, AddPointState> {
  final OrganizerRepository organizerRepository;
  final OrganizerBloc organizerBloc;
  final String eventId;
  AddPointBloc(
      {required this.organizerRepository,
      required this.organizerBloc,
      required this.eventId})
      : super(const AddPointState()) {
    on<AddPointNameChanged>((event, emit) {
      emit(AddPointState(name: event.name));
    });
    on<AddPointSubmitted>((event, emit) async {
      emit(AddPointState(name: state.name, formStatus: FormSubmitting()));
      try {
        await organizerRepository.addPoint(
            organizerBloc.organizerCredentials, state.name, eventId);
        emit(AddPointState(name: state.name, formStatus: SubmissionSuccess()));
        organizerBloc.add(GetEventPoints(eventId: eventId));
      } on Exception catch (e, _) {
        emit(AddPointState(name: state.name, formStatus: SubmissionFailed(e)));
      }
    });
  }
}
