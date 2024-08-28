part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

class LoadingFetchingDataState extends ProfileState {}

class SuccessFetchingDataState extends ProfileState {
  SuccessFetchingDataState(UserModel userModel);
}

class ErrorFetchingDataState extends ProfileState {
  ErrorFetchingDataState(String error);
}
