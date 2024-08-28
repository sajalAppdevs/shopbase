import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopbase_firebase/features/presentation/layout/layout_cubit/layout_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/01-onboarding/cubits/onboarding_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/01-onboarding/onboarding_screen.dart';
import 'package:shopbase_firebase/features/presentation/screens/02-auth/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/add_to_bag/add_to_bag_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/favourite/favourite_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/show_products/cubit/show_products_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/upload_products/cubit/upload_products_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'core/app_cubit/app/app_cubit.dart';

import 'core/utils/style/app_style.dart';
import 'features/presentation/layout/layout_screen.dart';
import 'features/presentation/screens/02-auth/cubits/signup/signup_cubit.dart';
import 'features/presentation/screens/03-pages/cubits/credit_card/credit_bloc.dart';
import 'features/presentation/screens/04-dashboard/presentation/pages/layout/cubit/layout_cubit.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) {
          ScreenUtil.init(ctx);
          return MultiBlocProvider(
              providers: [
                // app cubit
                BlocProvider<AppCubit>(
                    create: (context) => AppCubit()..setLanguage(languageCode: null)),
                BlocProvider<OnboardingCubit>(create: (context) => OnboardingCubit()),
                // auth and verify
                BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
                BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
                // for user
                BlocProvider<LayoutCubit>(create: (context) => LayoutCubit()),
                BlocProvider<CreditBloc>(create: (context) => CreditBloc()),
                BlocProvider<AddToBagCubit>(create: (context) => AddToBagCubit()..fetchBag()),
                BlocProvider<FavouriteCubit>(
                    create: (context) => FavouriteCubit()..fetchFavouriteItems()),
                //   for admin dashboard
                BlocProvider<DashboardLayoutCubit>(create: (context) => DashboardLayoutCubit()),
                BlocProvider<UploadProductsCubit>(create: (context) => UploadProductsCubit()),
                BlocProvider<ShowProductsCubit>(
                    create: (context) => ShowProductsCubit()..showProduct()),
              ],
              child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                return MaterialApp(
                    title: 'Ecommerce mysql',
                    debugShowCheckedModeBanner: false,

                    /// change themes and language
                    theme: AppStyle(themeIndex: state.themeCurrentIndex).currentTheme,
                    themeMode: ThemeMode.light,
                    locale: Locale(state.languageCode),
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    home: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return buildLoadingDataApp();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error occurred'));
                        } else if (snapshot.hasData) {
                          return Layout();
                        } else {
                          return OnBoardingPage();
                        }
                      },
                    ));
              }));
        });
  }
}
