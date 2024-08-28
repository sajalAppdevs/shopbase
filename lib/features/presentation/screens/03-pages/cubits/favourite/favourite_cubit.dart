import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import '../../../../../data/models/products_model.dart';

class FavouriteCubit extends Cubit<List<ProductsModel>> {
  FavouriteCubit() : super([]);

  static FavouriteCubit get(context) => BlocProvider.of(context, listen: false);

  final FirebaseServices _firebaseServices = FirebaseServices();

  // Method to add a product to the user's favorites
  Future<void> addToFavourites(ProductsModel product) async {
    try {
      DocumentReference userDocRef =
          _firebaseServices.usersCollection.doc(_firebaseServices.currentId);
      CollectionReference favouritesRef = userDocRef.collection('my_favourites');

      final snapshot = await favouritesRef.doc(product.productId).get();

      if (!snapshot.exists) {
        await favouritesRef.doc(product.productId).set({
          'productId': product.productId,
          'productTitle': product.productTitle,
          'productPrice': product.productPrice,
          'productSale': product.productSale,
          'productCategory': product.productCategory,
          'productSubCategory': product.productSubCategory,
          'productDescription': product.productDescription,
          'productImage': product.productImage,
          'productQuantity': product.productQuantity,
          'createdAt': product.createdAt ?? FieldValue.serverTimestamp(),
        });
        print("Product added to favourites successfully.");
        fetchFavouriteItems(); // Refresh the list of favorites
      } else {
        print("Product is already in favourites.");
      }
    } catch (e) {
      print("Failed to add product to favourites: $e");
      throw e;
    }
  }

  // Method to fetch the user's favorite items
  Future<void> fetchFavouriteItems() async {
    try {
      DocumentReference userDocRef =
          _firebaseServices.usersCollection.doc(_firebaseServices.currentId);
      CollectionReference favouritesRef = userDocRef.collection('my_favourites');

      final querySnapshot = await favouritesRef.get();

      List<ProductsModel> favouriteProducts = querySnapshot.docs.map((doc) {
        return ProductsModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      emit(favouriteProducts);
    } catch (e) {
      print("Failed to fetch favourite items: $e");
      throw e;
    }
  }

  // Remove an item from favorites
  Future<void> removeFromFavourites(String productId) async {
    try {
      DocumentReference userDocRef =
          _firebaseServices.usersCollection.doc(_firebaseServices.currentId);
      CollectionReference favouritesRef = userDocRef.collection('my_favourites');
      final snapshot = await favouritesRef.doc(productId).delete();

      fetchFavouriteItems(); // Refresh the favorites list
    } catch (e) {
      print("Error removing item from favourites: $e");
    }
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
// import 'package:shopbase_firebase/features/data/models/products_model.dart';
//
// part 'favourite_state.dart';
//
// class FavouriteCubit extends Cubit<FavouriteState> {
//   FavouriteCubit() : super(FavouriteInitial());
//
//   static FavouriteCubit get(context) => BlocProvider.of(context, listen: false);
//
//   Future<void> addToFavorites(ProductsModel product) async {
//     FirebaseServices _firebase = FirebaseServices();
//     try {
//       emit(LoadingAddToFavouriteState());
//
//       await _firebase.usersCollection
//           .doc(_firebase.currentId)
//           .collection('favorites')
//           .doc(product.productId);
//
//       print("Success add to favv");
//       // Fetch updated favorites
//       final favorites = await fetchFavorites();
//       emit(SuccessAddedToFavouriteState(favorites));
//     } catch (e) {
//       print("Failed add to favv");
//       emit(FailedAddToFavouriteState('Failed to add product to favorites: ${e.toString()}'));
//     }
//   }
//
//   // void loadFavorites() async {
//   //   try {
//   //     emit(LoadingAddToFavouriteState());
//   //
//   //     final favorites = await fetchFavorites();
//   //     emit(SuccessAddedToFavouriteState(favorites));
//   //   } catch (e) {
//   //     emit(FailedAddToFavouriteState('Failed to load favorites: ${e.toString()}'));
//   //   }
//   // }
//   //
//   // Future<List<ProductsModel>> fetchFavorites() async {
//   //   FirebaseServices _firebase = FirebaseServices();
//   //   final snapshot = await _firebase.firestore
//   //       .collection('users')
//   //       .doc(_firebase.currentId)
//   //       .collection('favorites')
//   //       .get();
//   //
//   //   return snapshot.docs.map((doc) => ProductsModel.fromFirestore(doc.data())).toList();
//   // }
//
//   Future<void> loadFavorites() async {
//     try {
//       emit(LoadingAddToFavouriteState());
//
//       final favorites = await fetchFavorites();
//       emit(SuccessFavouriteLoadedState(favorites));
//     } catch (e) {
//       emit(FailedAddToFavouriteState('Failed to load favorites: ${e.toString()}'));
//     }
//   }
//
//   Future<List<ProductsModel>> fetchFavorites() async {
//     FirebaseServices _firebase = FirebaseServices();
//     final snapshot = await _firebase.firestore
//         .collection('users')
//         .doc(_firebase.currentId)
//         .collection('favorites')
//         .get();
//
//     return snapshot.docs.map((doc) => ProductsModel.fromFirestore(doc.data())).toList();
//   }
// }
