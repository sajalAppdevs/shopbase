import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildTextButtonWithIcon({required String title, required IconData icon}) => InkWell(
      onTap: () => print("Clicked!!"),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
          2.kW,
          Icon(CupertinoIcons.arrow_left, size: 18.sp, color: AppConsts.basicAppColor)
        ]));