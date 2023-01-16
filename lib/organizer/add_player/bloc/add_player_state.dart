part of 'add_player_bloc.dart';

class AddPlayerState extends Equatable {
  final String username;
  bool get isValidUsername => username.length > 5 && !username.contains(' ');

  final FormSubmissionStatus formStatus;

  const AddPlayerState(
      {this.username = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object> get props => [username, formStatus];
}
