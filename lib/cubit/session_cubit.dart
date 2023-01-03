import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_credentials.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }
  final AuthRepository authRepo;

  void showAuth() => emit(Unauthenticated());

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      final organizer = userId;
      emit(AuthenticatedOrganizer(organizer: organizer));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showPlayerSession(AuthCredentials credentials) {
    final user = credentials.username;
    emit(AuthenticatedPlayer(player: user));
  }

  void showOrganizerSession(AuthCredentials credentials) {
    final user = credentials.username;
    emit(AuthenticatedOrganizer(organizer: user));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
