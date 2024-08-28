import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../data/models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController(initialPage: 0);
  bool isLast = false;

  List<OnBoardingModel> onBoardingModel = [
    OnBoardingModel(S().on_boarding_title_1, S().on_boarding_subtitle_1, Assets.imagesOnboard1),
    OnBoardingModel(S().on_boarding_title_2, S().on_boarding_subtitle_2, Assets.imagesOnboard2),
    OnBoardingModel(S().on_boarding_title_3, S().on_boarding_subtitle_3, Assets.imagesOnboard3),
  ];
}
