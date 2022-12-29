import 'package:bloc/bloc.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginPassCodeChanged>((event, emit) async {
      emit(LoginState(passCode: event.passCode));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(LoginState(formStatus: FormSubmitting()));

      try {
        await authRepo.login();
        emit(LoginState(formStatus: SubmissionSuccess()));
      } on Exception catch (e, _) {
        emit(LoginState(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
