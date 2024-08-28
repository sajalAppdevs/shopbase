import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/custom_text_form_field/build_pinput_widgets.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController phoneNumber;
  final String verification;

  const OtpScreen({required this.phoneNumber, required this.verification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios, size: 18))),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.kH,
                Text(
                  S.of(context).verify,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      letterSpacing: 2),
                ),
                Text(S.of(context).verify + phoneNumber.text),
                const HorizontalTimer(),
                45.kH,
                OTPForm(verification: verification)
                // buildPinPut(phoneNumber, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
