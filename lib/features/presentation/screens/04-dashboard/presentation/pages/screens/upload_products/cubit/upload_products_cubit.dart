import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/features/data/models/products_model.dart';

import '../../../../../../../../../core/enums/categories_enum.dart';
import '../../../../../../../widgets/custom_snack_bar/build_snackbar_widget.dart';

part 'upload_products_state.dart';

class UploadProductsCubit extends Cubit<UploadProductsState> {
  UploadProductsCubit() : super(InitUploadProductState());

  static UploadProductsCubit get(context) => BlocProvider.of(context, listen: false);

  final formKey = GlobalKey<FormState>();
  XFile? pickedImage;
  bool isEditing = false;
  String? productNetworkImage;
  String? productImageUrl;
  String? selectedCategory;
  List<String>? selectedSubCategory;

  void init(
    ProductsModel? productModel, {
    required dynamic titleController,
    required dynamic priceController,
    required dynamic descriptionController,
    required dynamic quantityController,
  }) {
    if (productModel != null) {
      isEditing = true;
      productNetworkImage = productModel.productImage;
      selectedCategory = productModel.productCategory.toString();
      selectedSubCategory = productModel.productSubCategory;
    }
    titleController = TextEditingController(text: productModel?.productTitle);
    priceController = TextEditingController(text: productModel?.productPrice.toString());
    descriptionController = TextEditingController(text: productModel?.productDescription);
    quantityController = TextEditingController(text: productModel?.productQuantity);
  }

  void clearForm({
    required dynamic titleController,
    required dynamic priceController,
    required dynamic descriptionController,
    required dynamic quantityController,
  }) {
    titleController!.clear();
    priceController!.clear();
    descriptionController!.clear();
    quantityController!.clear();
    removePickedImage();
    emit(ClearFormState());
  }

  void removePickedImage() => emit(ClearPickedImageState(pickedImage: null));

  Future<void> uploadProduct(
    context, {
    required dynamic titleController,
    required dynamic priceController,
    required dynamic descriptionController,
    required dynamic quantityController,
  }) async {
    if (pickedImage == null) {
      return showErrorSnackBar("ارفق صورة هنا!!!", 3, context);
    }
    if (selectedCategory == null || selectedSubCategory == null) {
      return showErrorSnackBar("الكاتيجوري فاضية!!", 3, context);
    }

    emit(LoadingUploadProductState());
    try {
      await FirebaseServices()
          .uploadProductToFirebaseFirestore(
              pickedImage: pickedImage,
              titleController: titleController,
              priceController: priceController,
              selectedCategory: selectedCategory,
              selectedSubCategory: selectedSubCategory,
              descriptionController: descriptionController,
              quantityController: quantityController)
          .then((value) {
        emit(SuccessUploadProductState());
        showSuccessSnackBar("Success!!!", 3, context);
      }).catchError((onError) {
        print(onError.toString());
        emit(FailedUploadProductState("CatchError>>>>>>>>>>>>>>: $onError"));
      });
    } on FirebaseException {
      print("FirebaseException");
      emit(FailedUploadProductState("FirebaseException"));
    } catch (e) {
      print("Catch>>>>>>>>>>>>>>: $e");
      emit(FailedUploadProductState("Catch>>>>>>>>>>>>>>: $e"));
    }
  }
}
