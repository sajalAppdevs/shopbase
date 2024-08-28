import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/generated/l10n.dart';
import 'package:shopbase_firebase/generated/l10n.dart';

import '../../../../layout/layout_screen.dart';
import '../../../../../../core/utils/functions/functions.dart';
import '../../../../../../core/utils/functions/firebase_services.dart';
import '../../../../../../features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context, listen: false);

  Future<void> login(context, {required emailController, required passwordController}) async {
    emit(LoadingLoginState());
    try {
      await FirebaseServices().login(context, emailController, passwordController).then((user) {
        navAndFinish(context, Layout());
        emit(SuccessLoginState(user as User));
      });
    } on FirebaseAuthException catch (firebaseMessage) {
      switch (firebaseMessage.code) {
        case 'user-not-found':
          showErrorSnackBar(S.of(context).login_user_didnt_found, 3, context);
          emit(FailedLoginState(S.of(context).login_user_didnt_found));
          break;
        case 'wrong-password':
          showErrorSnackBar(S.of(context).login_invalid_password, 3, context);
          emit(FailedLoginState(S.of(context).login_invalid_password));
          break;
        case 'invalid-email':
          showErrorSnackBar(S.of(context).login_invalid_email, 3, context);
          emit(FailedLoginState(S.of(context).login_invalid_email));
          break;
        case 'user-disabled':
          showErrorSnackBar(S.of(context).login_user_disabled, 3, context);
          emit(FailedLoginState(S.of(context).login_user_disabled));
          break;
        case 'operation-not-allowed':
          showErrorSnackBar(S.of(context).login_operation_not_allowed, 3, context);
          emit(FailedLoginState(S.of(context).login_operation_not_allowed));
          break;
        case 'too-many-requests':
          showErrorSnackBar(S.of(context).login_too_many_requests, 3, context);
          emit(FailedLoginState(S.of(context).login_too_many_requests));
          break;
        default:
          print(">>>>>>>>>>>Error: " + firebaseMessage.message.toString());
          print(">>>>>>>>>>>StackTrace: " + firebaseMessage.stackTrace.toString());
          showErrorSnackBar("An unknown error occurred", 3, context);
          emit(FailedLoginState('An unknown error occurred'));
          break;
      }
    } catch (e) {
      showErrorSnackBar("${S.of(context).login_error}${e.toString()}", 3, context);
      emit(FailedLoginState("${S.of(context).login_error}" + e.toString()));
    }
  }
}