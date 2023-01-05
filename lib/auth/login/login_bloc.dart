import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_credentials.dart';
import 'package:ino_coordinator/auth/auth_cubit.dart';
import 'package:ino_coordinator/data/auth_repository.dart';
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
        final userId = await authRepo.loginPlayer(state.passCode);
        emit(LoginState(
            formStatus: SubmissionSuccess(), passCode: state.passCode));
        authCubit.launchPlayerSession(
            AuthCredentials(userId: userId, passcode: state.passCode));
      } on Exception catch (e, _) {
        try {
          final userId = await authRepo.loginOrganizer(state.passCode);
          emit(LoginState(
              formStatus: SubmissionSuccess(), passCode: state.passCode));
          authCubit.launchOrganizerSession(
              AuthCredentials(userId: userId, passcode: state.passCode));
        } on Exception catch (f, _) {
          emit(LoginState(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
}
