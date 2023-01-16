import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/shared/components/form_submission_status.dart';

import '../../cubit/auth_cubit.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(const SignUpState()) {
    on<SignUpUsernameChanged>((event, emit) {
      emit(SignUpState(username: event.username, email: state.email));
    });
    on<SignUpEmailChanged>((event, emit) {
      emit(SignUpState(username: state.username, email: event.email));
    });
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpState(
          formStatus: FormSubmitting(),
          username: state.username,
          email: state.email));

      try {
        var code = await authRepo.signUp(state.username, state.email);
        emit(SignUpState(formStatus: SubmissionSuccess()));
        authCubit.showNewCode(code);
      } on Exception catch (e, _) {
        emit(SignUpState(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
