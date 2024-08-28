part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class LoadingCreateUserState extends SignupState {}

class SuccessCreateUserState extends SignupState {}

class ErrorCreateUserState extends SignupState {
  ErrorCreateUserState(String error);
}

// signup with google states
class LoadingSignInWithGoogleState extends SignupState {}

class SuccessSignInWithGoogleState extends SignupState {
  SuccessSignInWithGoogleState(User user);
}

class SuccessSortDateToFirebaseAfterSignInWithGoogleState extends SignupState {
  SuccessSortDateToFirebaseAfterSignInWithGoogleState(void value);
}

class ErrorSignInWithGoogleState extends SignupState {
  ErrorSignInWithGoogleState(String error);
}

class ChangePasswordVisible extends SignupState {
  ChangePasswordVisible(bool? visible);
}
