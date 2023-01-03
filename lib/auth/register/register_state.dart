part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String username;
  bool get isValidUsername => username.length < 5 || !username.contains(' ');
  final FormSubmissionStatus formStatus;

  RegisterState(
      {this.username = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object?> get props => [username, formStatus];
}
