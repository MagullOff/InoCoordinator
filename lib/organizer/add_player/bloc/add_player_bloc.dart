import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/organizer/organizer_repository.dart';
import 'package:ino_coordinator/organizer/bloc/organizer_bloc.dart';
import 'package:ino_coordinator/shared/components/form_submission_status.dart';

part 'add_player_event.dart';
part 'add_player_state.dart';

class AddPlayerBloc extends Bloc<AddPlayerEvent, AddPlayerState> {
  final OrganizerRepository organizerRepository;
  final OrganizerBloc organizerBloc;
  final String eventId;
  AddPlayerBloc(
      {required this.organizerRepository,
      required this.organizerBloc,
      required this.eventId})
      : super(const AddPlayerState()) {
    on<AddPlayerUsernameChanged>((event, emit) {
      emit(AddPlayerState(username: event.username));
    });
    on<AddPlayerSubmitted>((event, emit) async {
      emit(AddPlayerState(
          username: state.username, formStatus: FormSubmitting()));
      try {
        await organizerRepository.addPlayer(
            organizerBloc.organizerCredentials, state.username, eventId);
        emit(AddPlayerState(
            username: state.username, formStatus: SubmissionSuccess()));
        organizerBloc.add(PopPage());
        organizerBloc.add(PopPage());
        organizerBloc.add(GetEventPlayers(eventId: eventId));
      } on Exception catch (e, _) {
        emit(AddPlayerState(
            username: state.username, formStatus: SubmissionFailed(e)));
      }
    });
  }
}
