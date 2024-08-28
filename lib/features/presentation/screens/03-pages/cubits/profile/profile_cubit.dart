import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';

import '../../../../../data/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context, listen: false);

  UserModel? userModel;

  Future<void> fetchUserData() async {
    emit(LoadingFetchingDataState());
    try {
      QuerySnapshot querySnapshot = await FirebaseServices().usersCollection.get();

      if (querySnapshot.docs.isEmpty) {
        emit(ErrorFetchingDataState("No user data found"));
        return;
      }

      final allData = querySnapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc);
      }).toList();

      if (allData != null && allData.isNotEmpty) {
        userModel = allData.first;
        emit(SuccessFetchingDataState(userModel!));
      } else {
        emit(ErrorFetchingDataState("No user data found"));
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      emit(ErrorFetchingDataState(e.toString()));
    }
  }

}
