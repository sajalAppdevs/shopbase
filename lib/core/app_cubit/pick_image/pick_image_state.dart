part of 'pick_image_cubit.dart';

@immutable
class PickImageState extends Equatable {
  final XFile? pickedImage;
  final String? productNetworkImage;

  const PickImageState({
    this.pickedImage,
    this.productNetworkImage,
  });

  PickImageState copyWith({
    XFile? pickedImage,
    String? productNetworkImage,
  }) =>
      PickImageState(
          pickedImage: pickedImage ?? this.pickedImage,
          productNetworkImage: productNetworkImage ?? this.productNetworkImage);

  @override
  List<Object?> get props => [pickedImage, productNetworkImage];
}

final class PickImageInitial extends PickImageState {}