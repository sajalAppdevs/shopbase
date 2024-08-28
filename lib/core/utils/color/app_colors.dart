import 'package:flutter/material.dart';

import '../consts/consts.dart';

class AppColor {
  final ColorScheme colorScheme;

  AppColor({required this.colorScheme});

  // Light Theme
  factory AppColor.lightTheme() {
    return AppColor(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppConsts.basicAppColor,
          onPrimary: Colors.white,
          primaryContainer: Colors.blue[100],
          onPrimaryContainer: Colors.white,
          secondary: Colors.green,
          onSecondary: AppConsts.blackAppColor,
          secondaryContainer: Colors.green[100],
          onSecondaryContainer: Colors.white,
          tertiary: Colors.yellow,
          onTertiary: AppConsts.blackAppColor,
          tertiaryContainer: Colors.yellow[100],
          onTertiaryContainer: AppConsts.blackAppColor,
          error: Colors.red,
          onError: Colors.white,
          errorContainer: Colors.red[100],
          onErrorContainer: Colors.white,
          background: AppConsts.whiteAppColor,
          onBackground: AppConsts.blackAppColor,
          surface: Colors.white,
          onSurface: AppConsts.blackAppColor,
          surfaceVariant: Colors.grey[200],
          onSurfaceVariant: AppConsts.blackAppColor,
          outline: Colors.grey,
          outlineVariant: AppConsts.blackAppColor,
          shadow: Colors.grey[700],
          scrim: AppConsts.blackAppColor.withOpacity(0.5),
          inverseSurface: AppConsts.blackAppColor,
          onInverseSurface: Colors.white,
          inversePrimary: AppConsts.basicAppColor,
          surfaceTint: Colors.blue[100],
        ));
  }

  // Dark Theme
  factory AppColor.darkTheme() {
    return AppColor(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppConsts.basicAppColor,
          onPrimary: AppConsts.whiteAppColor,
          primaryContainer: Colors.blue[100],
          onPrimaryContainer: AppConsts.whiteAppColor,
          secondary: Colors.teal,
          onSecondary: AppConsts.whiteAppColor,
          secondaryContainer: Colors.teal[700],
          onSecondaryContainer: AppConsts.whiteAppColor,
          tertiary: Colors.amber,
          onTertiary: Color(0xFF040D12),
          tertiaryContainer: Colors.amber[700],
          onTertiaryContainer: Color(0xFF040D12),
          error: Colors.red,
          onError: AppConsts.whiteAppColor,
          errorContainer: Colors.red[700],
          onErrorContainer: AppConsts.whiteAppColor,
          background: AppConsts.blackAppColor,
          onBackground: AppConsts.whiteAppColor,
          surface: Color(0xFF040D12),
          onSurface: AppConsts.whiteAppColor,
          surfaceVariant: Colors.grey[800],
          onSurfaceVariant: AppConsts.whiteAppColor,
          outline: Colors.grey,
          outlineVariant: AppConsts.whiteAppColor,
          shadow: Color(0xFF040D12),
          scrim: Color(0xFF040D12).withOpacity(0.5),
          inverseSurface: AppConsts.whiteAppColor,
          onInverseSurface: Color(0xFF040D12),
          inversePrimary: AppConsts.basicAppColor,
          surfaceTint: Colors.deepOrange[700],
        ));
  }

  static List<ColorScheme> availableColorSchemes = [
    AppColor.lightTheme().colorScheme,
    AppColor.darkTheme().colorScheme,
  ];

  // Color names
  static const String lightThemeColor = 'lightTheme';
  static const String darkThemeColor = 'darkTheme';

  static ColorScheme getColorSchemeByIndex(int index) {
    if (index >= 0 && index < availableColorSchemes.length) {
      return availableColorSchemes[index];
    }
    return availableColorSchemes[0];
  }

  static int getThemeIndex(ColorScheme colorScheme) {
    return availableColorSchemes.indexOf(colorScheme);
  }

  static List<String> themeNames = [
    'Light Theme',
    'Dark Theme',
  ];

  static String getThemeName(int index) {
    switch (index) {
      case 0:
        return 'Light Theme';
      case 1:
        return 'Dark Theme';
      default:
        return 'Unknown Theme';
    }
  }
}

/*
brightness: تحدد السطوع العام لنظام الألوان، إما Brightness.light للسطوع الفاتح أو Brightness.dark للسطوع الداكن.

primary: اللون الأساسي المستخدم لعناصر واجهة المستخدم البارزة مثل الأزرار والعناصر المحددة.

onPrimary: اللون المستخدم للنص والرموز فوق اللون الأساسي.

primaryContainer: لون اختياري يمكن استخدامه كلون خلفية للعناصر التي تستخدم اللون الأساسي.

onPrimaryContainer: لون اختياري يستخدم كلون للنص والرموز فوق primaryContainer.

secondary: اللون الثانوي المستخدم لعناصر واجهة المستخدم مثل المفاتيح والمؤشرات.

onSecondary: اللون المستخدم للنص والرموز فوق اللون الثانوي.

secondaryContainer: لون اختياري يمكن استخدامه كلون خلفية للعناصر التي تستخدم اللون الثانوي.

onSecondaryContainer: لون اختياري يستخدم كلون للنص والرموز فوق secondaryContainer.

tertiary: لون إضافي يستخدم في تصميم واجهة المستخدم.

onTertiary: اللون المستخدم للنص والرموز فوق اللون الثالثي.

tertiaryContainer: لون اختياري يمكن استخدامه كلون خلفية للعناصر التي تستخدم اللون الثالثي.

onTertiaryContainer: لون اختياري يستخدم كلون للنص والرموز فوق tertiaryContainer.

error: اللون المستخدم لرسائل الخطأ أو العناصر التي تشير إلى وجود خطأ.

onError: اللون المستخدم للنص والرموز فوق اللون الخطأ.

errorContainer: لون اختياري يمكن استخدامه كلون خلفية للعناصر التي تشير إلى وجود خطأ.

onErrorContainer: لون اختياري يستخدم كلون للنص والرموز فوق errorContainer.

background: لون خلفية التطبيق أو واجهة المستخدم.

onBackground: اللون المستخدم للنص والرموز فوق خلفية التطبيق.

surface: لون خلفية العناصر السطحية مثل البطاقات والحوارات.

onSurface: اللون المستخدم للنص والرموز فوق لون السطح.

surfaceVariant: لون اختياري يستخدم لتلوين العناصر المرتفعة مثل الأزرار العائمة.

onSurfaceVariant: لون اختياري يستخدم للنص والرموز فوق surfaceVariant.

outline: اللون المستخدم للحدود والإطارات.

outlineVariant: لون اختياري يستخدم للحدود والإطارات للعناصر المرتفعة.

shadow: لون اختياري يستخدم للظلال.

scrim: لون اختياري يستخدم لتراكب عناصر أخرى مثل الحوارات.

inverseSurface: لون اختياري يستخدم للأسطح المقلوبة مثل العناصر المحددة.

onInverseSurface: لون اختياري يستخدم للنص والرموز فوق inverseSurface.

inversePrimary: لون اختياري يستخدم للعناصر الأساسية المقلوبة مثل الأزرار المحددة.

surfaceTint: لون اختياري يستخدم لتظليل الأسطح مثل البطاقات.
* */
class FormatColor {
  static const Color keyword = Colors.blue;
  static const Color string = Colors.green;
  static const Color comment = Colors.grey;
  static const Color number = Colors.orange;
  static const Color dataType = Colors.purple; // New color for data types
  static const Color classColor = Colors.teal; // New color for classes
  static const Color methodColor = Colors.indigo; // New color for methods/functions
}