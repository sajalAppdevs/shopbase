import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/00-intro/intro_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_outlined_button.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../custom_button/build_basic_button_widget.dart';

Widget buildDefaultDialog(context, {required String dialogText, required String dialogSubtitle}) =>
    AlertDialog(
        content: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 80.0,
          top: -90.0,
          child: Image.asset(
            Assets.iconsChecked,
            height: 90,
            width: 90,
          ),
        ),
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            onTap: () => Navigator.of(context).pop(),
            child: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.close_rounded, color: Colors.white),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                dialogText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                dialogSubtitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ));

void showLogoutDialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(S.of(context).logout_title),
          actions: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 11),
                  child: buildOutlinedButton(
                      function: () => Navigator.pop(context),
                      title: S.of(context).cancel,
                      color: CupertinoColors.white,
                      borderColor: Colors.transparent),
                )),
                10.kW,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 11),
                    child: basicButton(
                        fontSize: 13,
                        function: () async => await FirebaseServices()
                            .logout()
                            .then((value) => navAndFinish(context, IntroPage()))
                            .catchError(
                                (onError) => showErrorSnackBar(onError.toString(), 3, context)),
                        title: S.of(context).logout),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

Future<void> imagePickerDialog({
  required BuildContext context,
  required Function cameraFCT,
  required Function galleryFCT,
  required Function removeFCT,
}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Choose option"),
          ),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              TextButton.icon(
                onPressed: () {
                  cameraFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  galleryFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
              ),
              TextButton.icon(
                onPressed: () {
                  removeFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.remove),
                label: const Text("Remove"),
              ),
            ],
          )),
        );
      });
}
