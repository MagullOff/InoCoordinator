part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String passCode;
  bool get isValidPassCode => passCode.length == 6;
  final FormSubmissionStatus formStatus;

  const LoginState(
      {this.passCode = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object?> get props => [passCode, formStatus];
}
