import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class AppStyle {
  final int themeIndex;

  AppStyle({this.themeIndex = 0});

  ThemeData get currentTheme {
    if (themeIndex >= 0 && themeIndex < AppColor.availableColorSchemes.length) {
      return ThemeData(
          useMaterial3: true,
          colorScheme: AppColor.availableColorSchemes[themeIndex],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(color: AppConsts.blackAppColor),
              unselectedLabelStyle: TextStyle(color: AppConsts.blackAppColor),
              unselectedIconTheme: IconThemeData(
            color: AppConsts.blackAppColor,
          )),
          fontFamily: 'Tajawal');
    } else {
      return ThemeData(
          useMaterial3: true,
          colorScheme: AppColor.availableColorSchemes[0],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(color: AppConsts.whiteAppColor),
            unselectedLabelStyle: TextStyle(color: AppConsts.whiteAppColor),
            unselectedIconTheme: IconThemeData(
              color: AppConsts.whiteAppColor,
            ),
          ),
          fontFamily: 'Tajawal');
    }
  }
}
