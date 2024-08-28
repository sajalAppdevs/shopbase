import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget basicButton(
        {required String title,
        required VoidCallback function,
        double width = double.infinity,
        double radius = 8,
        double fontSize = 20.0,
        Color color = AppConsts.basicAppColor}) =>
    Container(
      width: width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: function,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
        style: ButtonStyle(
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            animationDuration: Duration(seconds: 12),
            splashFactory: InkRipple.splashFactory,
            overlayColor: MaterialStateProperty.all(AppConsts.whiteAppColor.withOpacity(0.20)),
            backgroundColor: MaterialStateProperty.all(color)),
      ),
    );
