import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension IntExtension on int? {
  int validate({int value = 0}) => this ?? value;

  Widget get kH => SizedBox(height: this?.toDouble().h);

  Widget get kW => SizedBox(width: this?.toDouble().w);
}