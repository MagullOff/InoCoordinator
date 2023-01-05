import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/data/auth_repository.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:meta/meta.dart';

import '../../cubit/auth_cubit.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpUsernameChanged>((event, emit) {
      emit(SignUpState(username: event.username));
    });
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpState(formStatus: FormSubmitting(), username: state.username));

      try {
        var code = await authRepo.signUp(state.username);
        emit(SignUpState(formStatus: SubmissionSuccess()));
        authCubit.showNewCode(code);
      } on Exception catch (e, _) {
        emit(SignUpState(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
