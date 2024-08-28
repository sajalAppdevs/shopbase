import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget onBoardingWidget(context, String title, String subtitle, String assets) {
  Size size = MediaQuery.of(context).size;

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
            width: size.width.w,
            height: size.height.h * 0.54,
            fit: BoxFit.cover,
            image: AssetImage(assets)),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );
}
