import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/layout/layout_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class HorizontalTimer extends StatelessWidget {
  const HorizontalTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("This code will be expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 60),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: AppConsts.basicAppColor),
          ),
        ),
      ],
    );
  }
}

class OTPForm extends StatefulWidget {
  final String verification;

  const OTPForm({Key? key, required this.verification}) : super();

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  late final TextEditingController pin1Controller, pin2Controller, pin3Controller, pin4Controller;

  @override
  void initState() {
    super.initState();
    pin1Controller = TextEditingController();
    pin2Controller = TextEditingController();
    pin3Controller = TextEditingController();
    pin4Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildOTPField(firstNode: true, lastNode: false, controller: pin1Controller),
              buildOTPField(firstNode: false, lastNode: false, controller: pin2Controller),
              buildOTPField(firstNode: false, lastNode: false, controller: pin3Controller),
              buildOTPField(firstNode: false, lastNode: true, controller: pin4Controller)
            ],
          ),
          30.kH,
          basicButton(
            title: S.of(context).confirm,
            function: () async {
              String pinCode = pin1Controller.text +
                  pin2Controller.text +
                  pin3Controller.text +
                  pin4Controller.text;
              if (pinCode == '1234') {
                await navAndFinish(context, Layout());
              } else {
                showErrorSnackBar("Your code verification is: 1234 😉", 3, context);
              }
            },
          ),
          40.kH,
          TextButton(
              child: const Text(
                "Resend OTP code",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
              onPressed: () =>
                  showErrorSnackBar("Your code verification is: 1234} 😉", 3, context))
        ],
      ),
    );
  }

  Widget buildOTPField(
      {required TextEditingController controller, bool firstNode = false, bool lastNode = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.16,
      child: TextFormField(
        autofocus: true,
        obscureText: true,
        controller: controller,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppConsts.greyAppColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppConsts.greyAppColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppConsts.greyAppColor))),
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && lastNode == false) {
            // move forward
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && firstNode == false) {
            // return back
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    pin1Controller.dispose();
    pin2Controller.dispose();
    pin3Controller.dispose();
    pin4Controller.dispose();
    super.dispose();
  }
}

Widget buildPinPut(TextEditingController controller, context) {
  final _defaultPinTheme = PinTheme(
    height: AppConsts.heightExpandSize(context),
    width: AppConsts.widthExpandSize(context) * 0.19,
    textStyle: TextStyle(fontSize: 22.sp, color: AppConsts.basicAppColor),
    decoration: BoxDecoration(
        color: AppConsts.greyAppColor,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: Colors.transparent)),
  );

  return SizedBox(
    height: AppConsts.heightExpandSize(context),
    width: AppConsts.widthExpandSize(context),
    child: Pinput(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        length: 4,
        controller: controller,
        validator: (value) => value == null ? "الرجاء املئ الحقول الفارغة!" : null,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
        onCompleted: (pin) {},
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        defaultPinTheme: PinTheme(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(color: AppConsts.greyAppColor)),
        ),
        focusedPinTheme: _defaultPinTheme.copyWith(
            height: 150.h,
            width: AppConsts.widthExpandSize(context) * 0.19,
            decoration: _defaultPinTheme.decoration!
                .copyWith(border: Border.all(color: AppConsts.greyAppColor))),
        errorPinTheme: _defaultPinTheme.copyWith(
            decoration: BoxDecoration(
                color: AppConsts.errorAppColor, borderRadius: BorderRadius.circular(18.sp)))),
  );
}
