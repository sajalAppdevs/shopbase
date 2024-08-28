import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/02-auth/signup_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_outlined_button.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../02-auth/login_screen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 15,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: AssetImage('assets/images/suit-cover.jpg'),
                    fit: BoxFit.fill,
                    height: double.maxFinite,
                    width: double.infinity,
                    opacity: AlwaysStoppedAnimation(1.55),
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        120.kH,
                        Text(
                          S.of(context).welcome_title,
                          style: TextStyle(
                              fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        4.kH,
                        Text(
                          S.of(context).welcome_subtitle,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: buildOutlinedButton(
                          color: AppConsts.whiteAppColor,
                          borderColor: AppConsts.blackAppColor,
                          title: S.of(context).login.toUpperCase(),
                          function: () => navToWithRTLAnimation(context, LoginPage())),
                    ),
                    10.kW,
                    Expanded(
                      flex: 3,
                      child: basicButton(
                          title: S.of(context).register.toUpperCase(),
                          function: () => navToWithRTLAnimation(context, SignupPage())),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
