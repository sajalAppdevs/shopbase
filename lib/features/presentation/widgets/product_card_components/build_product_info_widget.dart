import 'package:flutter/material.dart';

Widget productInfo({required String product, required String title}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
    ),
    Text(
      product,
      style: TextStyle(
          fontWeight: FontWeight.w500
      ),
    ),
  ],
);
