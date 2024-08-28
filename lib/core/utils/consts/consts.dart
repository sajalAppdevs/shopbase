import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConsts {
  AppConsts._();

  static const Color basicAppColor = Color(0xFFDB3022);
  static const Color blackAppColor = Color(0xFF222222);
  static const Color whiteAppColor = Color(0xFFF6F6F6);
  static const Color greyAppColor = Color(0xFF9B9B9B);
  static const Color backgroundAppColor = Color(0xFFF9F9F9);
  static const Color errorAppColor = Color(0xFFF01F0E);
  static const Color successAppColor = Color(0xFF2AA952);
  static const List<String> categories = ["Winter", "Summer", "Suits"];
  static const List<String> winterClothesSubCategories = [
    "Shirts",
    "Hoodies",
    "Pants",
    "Winter Kit",
    "Winter Shoes",
    "Winter Accessories"
  ];
  static const List<String> summerClothesSubCategories = [
    "Shirts",
    "Hoodies",
    "Pants",
    "Summer Kit",
    "Summer Shoes",
    "Summer Accessories"
  ];
  static const List<String> suitsClothesSubCategories = [
    "Suits 3 parts",
    "Suits 5 parts",
    "Skirts",
    "Suits Shoes",
    "Suits Accessories"
  ];

  static double heightExpandSize(context) => MediaQuery.sizeOf(context).height.h;

  static double widthExpandSize(context) => MediaQuery.sizeOf(context).width.w;
}

