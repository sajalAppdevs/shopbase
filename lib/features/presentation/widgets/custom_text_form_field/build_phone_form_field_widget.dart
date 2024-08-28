import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/utils/consts/consts.dart';
import '../../../../generated/l10n.dart';

Widget buildPhoneFormFieldWidget(context,
        {required TextEditingController controller,
        required VoidCallback onTap,
        required VoidCallback onSubmit,
        required VoidCallback onSave,
        required String label,
        required String hint,
        double radius = 8.0,
        Widget? postfix}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        child: IntlPhoneField(
          controller: controller,
          initialCountryCode: 'EG',
          onSaved: (value) => onSave,
          onTap: () => onTap,
          validator: (value) {
            if (value == null || value.number.isEmpty) {
              return S.of(context).phone_validation;
            } else {
              return null;
            }
          },
          onChanged: (phone) => print(phone.completeNumber),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              hintStyle: TextStyle(color: AppConsts.greyAppColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(color: AppConsts.greyAppColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(color: AppConsts.greyAppColor, width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(color: AppConsts.errorAppColor, width: 1)),
              suffix: postfix),
        ),
      ),
    );
