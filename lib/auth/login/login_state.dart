part of 'login_bloc.dart';

class LoginState {
  final String passCode;
  bool get isValidPassCode => passCode.length == 6;
  final FormSubmissionStatus formStatus;

  LoginState({this.passCode = '', this.formStatus = const InitialFormStatus()});
}
