part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoadingLoginState extends LoginState {}

final class SuccessLoginState extends LoginState {
  final User user;

  SuccessLoginState(this.user);

  @override
  List<Object> get props => [user];
}

final class FailedLoginState extends LoginState {
  final String error;

  FailedLoginState(this.error);

  @override
  List<Object> get props => [error];
}
