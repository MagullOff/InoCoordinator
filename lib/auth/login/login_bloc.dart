import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_credentials.dart';
import 'package:ino_coordinator/auth/auth_cubit.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState()) {
    on<LoginPassCodeChanged>((event, emit) async {
      emit(LoginState(passCode: event.passCode));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(LoginState(formStatus: FormSubmitting(), passCode: state.passCode));

      try {
        final userId = await authRepo.login(state.passCode);
        emit(LoginState(formStatus: SubmissionSuccess()));
        authCubit.launchSession(
            AuthCredentials(userId: userId, passcode: state.passCode));
      } on Exception catch (e, _) {
        emit(LoginState(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
