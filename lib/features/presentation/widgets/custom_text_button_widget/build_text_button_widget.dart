import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildTextButton(
    {required String title,
      double titleSize = 14,
      // required Color titleColor
    }) =>
    InkWell(
      onTap: () => print("Clicked!!"),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Text(
        title,
        style: TextStyle(
            // color: titleColor,
            fontSize: titleSize,),
      ),
    );
