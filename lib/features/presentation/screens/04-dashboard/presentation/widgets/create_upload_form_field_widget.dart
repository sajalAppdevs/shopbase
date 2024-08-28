import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';

Widget uploadFormField(
  key, {
  required TextEditingController controller,
  required int min,
  required int max,
  required int length,
  required String hint,
  required String label,
  required String validateTitle,
  TextCapitalization? capitalization,
  TextInputType? inputType,
  List<TextInputFormatter>? list,
  Widget? prefix,
  Widget? postfix,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0.sp)
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        minLines: min,
        maxLines: max,
        maxLength: length,
        textCapitalization: capitalization ?? TextCapitalization.sentences,
        keyboardType: inputType,
        inputFormatters: list,
        decoration: InputDecoration(
            hintText: '$hint',
            labelText: '$label',
            prefix: prefix,
            suffix: postfix,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(color: AppConsts.backgroundAppColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(color: AppConsts.backgroundAppColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(color: Colors.redAccent)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(color: AppConsts.backgroundAppColor))),
        validator: (value) {
          if (value!.isEmpty) {
            return validateTitle;
          }
          return null;
        },
        onTap: () {},
      ),
    );
