part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  final String token;

  const LoginStateSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

class LoginStateError extends LoginState {
  final String message;

  const LoginStateError({required this.message});

  @override
  List<Object?> get props => [message];
}