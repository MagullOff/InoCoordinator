part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginAuthState extends AuthState {}

class SignUpAuthState extends AuthState {}

class ShowCodeAuthState extends AuthState {
  final String code;
  ShowCodeAuthState({required this.code});
}
