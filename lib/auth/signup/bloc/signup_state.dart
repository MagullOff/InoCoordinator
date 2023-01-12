part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  final String username;
  final String email;
  bool get isValidUsername => username.length > 5 && !username.contains(' ');
  bool get isValidEmail => email.contains('@');

  final FormSubmissionStatus formStatus;

  SignUpState(
      {this.email = '',
      this.username = '',
      this.formStatus = const InitialFormStatus()});

  @override
  List<Object?> get props => [username, email, formStatus];
}
