import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/00-intro/intro_screen.dart';
import 'package:shopbase_firebase/features/presentation/screens/01-onboarding/cubits/onboarding_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_onboarding/onboarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../generated/l10n.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          var cubit = OnboardingCubit.get(context);
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: cubit.pageController,
                      itemCount: cubit.onBoardingModel.length,
                      onPageChanged: (value) {
                        setState(() => cubit.isLast = value == 2);
                      },
                      itemBuilder: (context, index) => onBoardingWidget(
                          context,
                          cubit.onBoardingModel[index].title,
                          cubit.onBoardingModel[index].subtitle,
                          cubit.onBoardingModel[index].lottieGif),
                    ),
                  ),
                  // 10.kH,
                  Expanded(
                    flex: 1,
                    child: cubit.isLast
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: basicButton(
                              width: 260,
                              color: AppConsts.basicAppColor,
                              fontSize: 22.sp,
                              radius: 15.sp,
                              function: () => navAndFinish(context, IntroPage()),
                              title: S.of(context).get_started),
                        )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SmoothPageIndicator(
                                count: cubit.onBoardingModel.length,
                                controller: cubit.pageController,
                                effect: ExpandingDotsEffect(
                                    activeDotColor: AppConsts.basicAppColor,
                                    dotColor: AppConsts.greyAppColor),
                              ),
                              5.kH,
                              FloatingActionButton.small(
                                backgroundColor: AppConsts.basicAppColor,
                                onPressed: () => cubit.pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut),
                                child: Icon(CupertinoIcons.arrow_left),
                              ),
                            ],
                          ),
                  ),
                  15.kH
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
