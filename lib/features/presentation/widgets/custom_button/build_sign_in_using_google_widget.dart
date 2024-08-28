import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';

import '../../../../generated/l10n.dart';

Widget SignupWithGoogleButtonWidget(
  context, {
  required VoidCallback? onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(2.1),
          animationDuration: Duration(seconds: 12),
          splashFactory: InkRipple.splashFactory,
          overlayColor: MaterialStateProperty.all(AppConsts.whiteAppColor.withOpacity(0.1)),
          // backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
          backgroundColor: MaterialStateProperty.all(Color(0xFF820300)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(15.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Image.asset('assets/icons/logo_google.png', width: 20.w, height: 20.h)),
              22.kW,
              Expanded(
                  flex: 9,
                  child: Center(
                    child: Text(S.of(context).signin_using_google,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                  )),
            ],
          ),
        ),
      ),
    );
