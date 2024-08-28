import '../../../../data/models/products_model.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class LoadingFavourite extends FavouriteState {}

class SuccessLoadFavourite extends FavouriteState {
  final List<ProductsModel> favourites;

  SuccessLoadFavourite(this.favourites);
}

class FailedLoadFavourite extends FavouriteState {
  final String message;

  FailedLoadFavourite(this.message);
}
