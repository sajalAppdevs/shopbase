import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';

Widget DashboardButtonsWidget(context,
        {required String title, required IconData icon, required Widget onPressed}) =>
    GestureDetector(
      onTap: () => navToWithRTLAnimation(context, onPressed),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30.sp),
            15.kH,
            Text(
              title,
              style: TextStyle(fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
