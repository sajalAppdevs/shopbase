part of 'show_products_cubit.dart';

abstract class ShowProductsState extends Equatable {

  @override
  List<Object> get props => [];
}

class ShowProductsInitial extends ShowProductsState {}

class LoadingShowProductsState extends ShowProductsState {}

class SuccessShowProductsState extends ShowProductsState {
  SuccessShowProductsState(List<ProductsModel> products);
}

class FailedShowProductsState extends ShowProductsState {
  FailedShowProductsState(String errorMessage);
}
