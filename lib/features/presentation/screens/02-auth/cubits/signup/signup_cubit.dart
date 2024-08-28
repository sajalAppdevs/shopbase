import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/02-auth/pinput_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../../widgets/custom_snack_bar/build_snackbar_widget.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context, listen: false);

  late bool visible = false;

  // signup with email cubit
  Future<void> signupUsingEmail(context,
      {required name, required image, required email, required phone, required password}) async {
    emit(LoadingCreateUserState());
    try {
      User? _user = FirebaseServices().auth.currentUser;
      dynamic uid = _user?.uid ?? Uuid().v4().toString().trim();
      FirebaseServices().signUpWithEmail(email: email, password: password).then((value) {
        FirebaseServices()
            .uploadUserDataToFirebase(uid,
                nameController: name,
                imageController: image,
                emailController: email,
                phoneController: phone)
            .then((value) {
          print("Sign in success!!");
          emit(SuccessCreateUserState());
        });
      });
    } on FirebaseAuthException catch (error) {
      print(">>>>>FirebaseAuthException" + error.message.toString());
      showErrorSnackBar("هذا الإيميل مستخدم بالفعل!!!" + "${error.message.toString()}", 4, context);
      emit(ErrorCreateUserState("######Error here when create user: " + error.toString()));
    } catch (e, stackTrace) {
      print(">>>>>>E: " + e.toString());
      print(">>>>>>E: " + stackTrace.toString());
      showErrorSnackBar(e.toString(), 4, context);
      emit(ErrorCreateUserState(
          "###########################Error here when create user: " + e.toString()));
    }
  }

  Future<void> signInWithGoogle(context) async {
    emit(LoadingSignInWithGoogleState());
    try {
      final result = await FirebaseServices().signUpWithGoogle();
      if (result.user == null) {
        showErrorSnackBar("Value is null: ${result.toString()}", 3, context);
        emit(ErrorSignInWithGoogleState("Value is null: ${result.toString()}"));
      } else {
        emit(SuccessSignInWithGoogleState(result.user!));
        await FirebaseServices().uploadUserDataToFirebase(
          result.user!.uid,
          nameController: result.user!.displayName,
          imageController: result.user!.photoURL,
          emailController: result.user!.email,
          phoneController: result.user!.phoneNumber,
        );
        emit(SuccessSortDateToFirebaseAfterSignInWithGoogleState(result));
      }
    } on FirebaseException catch (e) {
      print('FirebaseException-------> ${e.toString()}');
      print('FirebaseException-------> ${e.stackTrace}');
      emit(ErrorSignInWithGoogleState("FirebaseException------->${e.toString()}"));
    } catch (e, stackTrace) {
      if (e is PlatformException && e.code == 'sign_in_canceled') {
        print('Sign-in canceled by the user');
      } else {
        print('Exception------->$e');
        print('StackTrace------->$stackTrace');
        emit(ErrorSignInWithGoogleState("Exception------->$e"));
      }
    }
  }

  void togglePasswordVisibility() {
    visible = !visible;
    emit(ChangePasswordVisible(visible));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
