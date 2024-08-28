part of 'show_orders_cubit.dart';

sealed class ShowOrdersState extends Equatable {
  const ShowOrdersState();
}

final class ShowOrdersInitial extends ShowOrdersState {
  @override
  List<Object> get props => [];
}
