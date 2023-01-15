part of 'add_point_bloc.dart';

class AddPointState extends Equatable {
  final String name;
  bool get isValidName => name.length > 5 && !name.contains(' ');

  final FormSubmissionStatus formStatus;
  const AddPointState(
      {this.name = '', this.formStatus = const InitialFormStatus()});

  @override
  List<Object> get props => [name, formStatus];
}
