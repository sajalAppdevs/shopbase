import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildOutlinedButton(
        {required String title,
        required VoidCallback function,
        required Color color,
        required Color borderColor,
        }) =>
    Container(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(8.0)),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: color),
      ),
    );
