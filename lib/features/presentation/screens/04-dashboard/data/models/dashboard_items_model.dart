import 'package:flutter/cupertino.dart';

class DashboardButtonsModel {
  final String text;
  final IconData icon;
  final Widget onPressed;

  DashboardButtonsModel({
    required this.text,
    required this.icon,
    required this.onPressed,
  });
}
