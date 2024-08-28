import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/features/data/models/bag_model.dart';

part 'add_to_bag_state.dart';

class AddToBagCubit extends Cubit<AddToBagState> {
  AddToBagCubit() : super(AddToBagState(quantity: 1));

  static AddToBagCubit get(context) => BlocProvider.of(context, listen: false);

  final List<String> sizes = ["S", "M", "L"];

  // increase the quality
  void incrementQuality() {
    final newQuantity = (state.quantity ?? 1) + 1;
    emit(state.copyWith(quantity: newQuantity));
  }

  // decrease the quality
  void decrementQuality() {
    final newQuantity = (state.quantity ?? 1) - 1;
    if (state.quantity > 1) emit(state.copyWith(quantity: newQuantity));
  }

  // Add the bag
  Future<void> addToBag(productId, BagModel items) async {
    FirebaseServices _firebase = FirebaseServices();
    try {
      emit(LoadingAddToBagState());
      _firebase.usersCollection
          .doc(_firebase.currentId)
          .collection('my_bag')
          // .doc(productId)
          .add(items.toMap())
          .then((value) => emit(SuccessAddToBagState()));
    } catch (e, stackTrace) {
      print("Error in Add To Bag: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${e.toString()}");
      print("Error in Add To Bag: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${stackTrace.toString()}");
      emit(FailedAddToBagState(e.toString()));
    }
  }

  Future<void> fetchBag() async {
    FirebaseServices _firebase = FirebaseServices();
    try {
      emit(LoadingBagFetching());
      final bagCollection =
          await _firebase.usersCollection.doc(_firebase.currentId).collection('my_bag').get();
      final bagItems = bagCollection.docs
          .map((doc) => BagModel(
              productId: doc['productId'],
              productImage: doc['productImage'],
              productName: doc['productName'],
              quantity: doc['quantity'],
              size: doc['size'],
              totalPrice: (doc['totalPrice'] is int)
                  ? (doc['totalPrice'] as int).toDouble()
                  : doc['totalPrice'] as double,
              color: doc['color']))
          .toList();
      emit(SuccessBagFetching(bagItems));
    } catch (e, stackTrace) {
      print("Error in Fetching Bag Items: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${e.toString()}");
      print(
          "Error in Fetching Bag Items: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${stackTrace.toString()}");
      emit(FailedBagFetching(e.toString()));
    }
  }

  // Remove the bag
  Future<void> removeBag(productId, BagModel items) async {
    FirebaseServices _firebase = FirebaseServices();
    try {
      emit(LoadingAddToBagState());
      _firebase.usersCollection
          .doc(_firebase.currentId)
          .collection('my_bag')
          .add(items.toMap())
          .then((value) => emit(SuccessAddToBagState()));
    } catch (e, stackTrace) {
      print("Error in Add To Bag: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${e.toString()}");
      print("Error in Add To Bag: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:${stackTrace.toString()}");
      emit(FailedAddToBagState(e.toString()));
    }
  }
}
