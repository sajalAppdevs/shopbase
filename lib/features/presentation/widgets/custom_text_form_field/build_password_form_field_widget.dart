import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

Widget buildPasswordFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required VoidCallback onTap,
        required VoidCallback onChanged,
        required VoidCallback onSubmit,
        required VoidCallback onSave,
        required VoidCallback onPressed,
        Function? validate,
        required String label,
        required String hint,
        double radius = 8.0,
        required bool isVisible}) =>
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
          obscureText: isVisible,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            suffixIcon: IconButton(
                onPressed: () => onPressed,
                icon: isVisible == true
                    ? Icon(Icons.remove_red_eye_outlined)
                    : Icon(Icons.visibility_off_outlined)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: AppConsts.greyAppColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: AppConsts.greyAppColor, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: AppConsts.errorAppColor, width: 1)),
          ),
        ),
      ),
    );
