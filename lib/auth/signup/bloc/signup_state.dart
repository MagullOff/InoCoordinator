part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  final String username;
  bool get isValidUsername => username.length < 5 || !username.contains(' ');
  final FormSubmissionStatus formStatus;

  SignUpState(
      {this.username = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object?> get props => [username, formStatus];
}
