import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/show_products/cubit/show_products_cubit.dart';
import 'firebase_options.dart';

import 'core/app_cubit/app/app_cubit.dart';
import 'core/bloc_observer.dart';
import 'core/shared_preferenced/shared_preferenced.dart';
import 'myApp.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// initial Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// initial FCM Token
  await FirebaseServices.initFcmToken();

  /// initial ScreenUtil
  await ScreenUtil.ensureScreenSize();

  /// Flutter Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  /// initial Shared Preferenced
  await SharedPrefController().initPreferences();
  await SharedPreferences.getInstance();

  /// initial Bloc Observer
  Bloc.observer = MyBlocObserver();

  /// initial Blocs and Cubits
  AppCubit();

  runApp(const MyApp());
}
