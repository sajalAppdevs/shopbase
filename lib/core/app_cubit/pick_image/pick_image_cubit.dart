import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());

  static PickImageCubit get(context) => BlocProvider.of(context, listen: false);

  void pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    emit(state.copyWith(pickedImage: pickedImage, productNetworkImage: null));
  }

  void removeImage() => emit(state.copyWith(pickedImage: null, productNetworkImage: null));

  void setNetworkImage(String imageUrl) =>
      emit(state.copyWith(productNetworkImage: imageUrl, pickedImage: null));
}
