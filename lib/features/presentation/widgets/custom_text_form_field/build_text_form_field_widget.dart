import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildTextFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required VoidCallback onTap,
        required VoidCallback onChanged,
        required VoidCallback onSubmit,
        required VoidCallback onSave,
        Function? validate,
        required String label,
        required String hint,
        double radius = 8.0,
        Widget? postfix}) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Container(
            child: TextFormField(
                controller: controller,
                onFieldSubmitted: (value) => onSubmit,
                onChanged: (value) => onChanged,
                onSaved: (value) => onSave,
                onTap: () => onTap,
                validator: (value) => validate!(value),
                keyboardType: type,
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
                    suffix: postfix))));
