part of 'add_to_bag_cubit.dart';

class AddToBagState extends Equatable {
  final int quantity;

  AddToBagState({this.quantity = 0});

  @override
  List<Object> get props => [quantity];

  AddToBagState copyWith({int? quantity, List<String>? size}) =>
      AddToBagState(quantity: quantity ?? this.quantity);
}

class LoadingAddToBagState extends AddToBagState {}

class SuccessAddToBagState extends AddToBagState {}

class FailedAddToBagState extends AddToBagState {
  final String error;

  FailedAddToBagState(this.error);

  @override
  List<Object> get props => [error];
}

class LoadingBagFetching extends AddToBagState {}

class SuccessBagFetching extends AddToBagState {
  final List<BagModel> bagItems;

  SuccessBagFetching(this.bagItems);

  @override
  List<Object> get props => [bagItems];
}

class FailedBagFetching extends AddToBagState {
  final String message;

  FailedBagFetching(this.message);

  @override
  List<Object> get props => [message];
}