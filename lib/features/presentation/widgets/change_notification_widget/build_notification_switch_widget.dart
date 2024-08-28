import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildNotificationSwitchWidget() => Switch.adaptive(
    activeColor: AppConsts.basicAppColor,
    inactiveThumbColor: AppConsts.greyAppColor,
    value: false,
    onChanged: (value) {}
);
