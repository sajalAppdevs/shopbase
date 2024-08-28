import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSuccessSnackBar(String title, int duration, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        margin: EdgeInsets.all(15.w),
        backgroundColor: AppConsts.successAppColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: AppConsts.whiteAppColor,
              size: 30.w,
            ),
            10.kW,
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  color: AppConsts.whiteAppColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );

showErrorSnackBar(String title, int duration, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        margin: EdgeInsets.all(15.w),
        backgroundColor: AppConsts.errorAppColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppConsts.whiteAppColor,
              size: 30.w,
            ),
            10.kW,
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  color: AppConsts.whiteAppColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );

showInfoSnackBar(String title, int duration, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        margin: EdgeInsets.all(15.w),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.inactiveIconsSupport,
              width: 30.w,
              height: 30.h,
            ),
            10.kW,
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  color: AppConsts.whiteAppColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
