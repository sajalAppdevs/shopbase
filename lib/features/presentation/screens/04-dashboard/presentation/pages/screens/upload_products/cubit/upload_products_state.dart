part of 'upload_products_cubit.dart';

@immutable
class UploadProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitUploadProductState extends UploadProductsState {}

class LoadingUploadProductState extends UploadProductsState {}

class SuccessUploadProductState extends UploadProductsState {}

class FailedUploadProductState extends UploadProductsState {
  FailedUploadProductState(String error);
}

class ClearFormState extends UploadProductsState {}

class ClearPickedImageState extends UploadProductsState {
  ClearPickedImageState({required dynamic pickedImage});
}
