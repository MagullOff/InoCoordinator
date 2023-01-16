import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_credentials.dart';
import 'package:meta/meta.dart';

import '../../cubit/session_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.sessionCubit}) : super(LoginAuthState());
  final SessionCubit sessionCubit;

  void showLogin() => emit(LoginAuthState());
  void showSignUp() => emit(SignUpAuthState());
  void showNewCode(String code) => emit(ShowCodeAuthState(code: code));
  void launchPlayerSession(AuthCredentials credentials) {
    sessionCubit.showPlayerSession(credentials);
  }

  void launchOrganizerSession(AuthCredentials credentials) {
    sessionCubit.showOrganizerSession(credentials);
  }
}
