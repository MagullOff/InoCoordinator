import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/model/event_stats.dart';
import 'package:ino_coordinator/model/player_stats.dart';
import 'package:ino_coordinator/organizer/organizer_repository.dart';

import '../model/event.dart';

part 'organizer_event.dart';
part 'organizer_state.dart';

class OrganizerBloc extends Bloc<OrganizerEvent, OrganizerState> {
  final SessionCubit sessionCubit;
  final Credentials organizerCredentials;
  final OrganizerRepository organizerRepository;
  OrganizerBloc(
      {required this.organizerCredentials,
      required this.organizerRepository,
      required this.sessionCubit})
      : super(OrganizerLoading()) {
    on<GetOrganizerEvents>((event, emit) async {
      emit(OrganizerLoading());
      try {
        final events =
            await organizerRepository.getOrganizerEvents(organizerCredentials);
        print('$events');
        emit(OrganizerLoadedEvents(events: events));
      } on Exception catch (e, _) {
        emit(OrganizerError(message: e.toString()));
      }
    });
    on<GetEventStats>((event, emit) {
      emit(OrganizerLoading());
    });
    on<GetEventUsers>((event, emit) {
      emit(OrganizerLoading());
    });
    on<GetUserStats>((event, emit) {
      emit(OrganizerLoading());
    });
  }
}
