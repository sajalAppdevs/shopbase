import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';

import '../../../../../../../../data/models/products_model.dart';

part 'show_products_state.dart';

class ShowProductsCubit extends Cubit<ShowProductsState> {
  ShowProductsCubit() : super(ShowProductsInitial());

  static ShowProductsCubit get(context) => BlocProvider.of(context, listen: false);

  List<ProductsModel> products = [];

  final ver = FirebaseFirestore.instance.collection('products');

  Future<void> showProduct() async {
    emit(LoadingShowProductsState());
    try {
      QuerySnapshot querySnapshot = await FirebaseServices().productsCollection.get();
      if (querySnapshot != "" || querySnapshot.docs.isNotEmpty)
        products = querySnapshot.docs
            .map((doc) => ProductsModel.fromFirestore(doc.data() as Map<String, dynamic>))
            .toList();
      emit(SuccessShowProductsState(products));
    } catch (e, stackTrace) {
      print("Error>>>>>>>>>>>>>>>>" + e.toString());
      print("StackTrace>>>>>>>>>>>>>>>>" + stackTrace.toString());
      emit(FailedShowProductsState(e.toString()));
    }
  }
}
