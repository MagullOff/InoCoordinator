import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_credentials.dart';
import 'package:ino_coordinator/data/auth_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }
  final AuthRepository authRepo;

  Credentials get organizerCredentials =>
      (state as AuthenticatedOrganizer).credentials;

  Credentials get playerCredentials =>
      (state as AuthenticatedPlayer).credentials;

  void showAuth() => emit(Unauthenticated());

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      emit(AuthenticatedOrganizer(
          credentials: Credentials(passcode: '', id: userId)));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showPlayerSession(AuthCredentials credentials) {
    emit(AuthenticatedPlayer(
        credentials: Credentials(
            passcode: credentials.passcode, id: credentials.userId)));
  }

  void showOrganizerSession(AuthCredentials credentials) {
    emit(AuthenticatedOrganizer(
        credentials: Credentials(
            passcode: credentials.passcode, id: credentials.userId)));
  }

  void signOut() {
    emit(Unauthenticated());
  }
}
