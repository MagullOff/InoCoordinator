import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/auth/form_submission_status.dart';
import 'package:meta/meta.dart';

import '../auth_cubit.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  RegisterBloc({required this.authRepo, required this.authCubit})
      : super(RegisterState()) {
    on<RegisterUsernameChanged>((event, emit) {
      emit(RegisterState(username: event.username));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterState(
          formStatus: FormSubmitting(), username: state.username));

      try {
        var code = await authRepo.register(state.username);
        emit(RegisterState(formStatus: SubmissionSuccess()));
        authCubit.showNewCode(code);
      } on Exception catch (e, _) {
        emit(RegisterState(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
