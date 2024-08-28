import 'package:flutter/material.dart';
import 'dart:math';

import 'package:image_picker/image_picker.dart';

import '../../../features/presentation/widgets/custom_dialog/build_dialog_widget.dart';

// navigate and finish pervious screen
navAndFinish(context, Widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) {
      return false;
    });

// just navigate for screen
navTo(context, Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

// random numbers
String generateRandomNumber() {
  Random random = Random();
  int randomNumber = 0;
  for (int i = 0; i < 4; i++) {
    randomNumber = (randomNumber * 10) + random.nextInt(10);
  }
  return randomNumber.toString();
}

// navigate with animation to open music
class ScaleTransitionForMusic extends PageRouteBuilder {
  final Widget page;

  ScaleTransitionForMusic(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}

navToMusic(context, Widget) => Navigator.push(context, ScaleTransitionForMusic(Widget));

// animation for screens
class RTLScreenAnimation extends PageRouteBuilder {
  final Widget page;

  RTLScreenAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                    .animate(animation),
                child: page,
              );
            });
}

navToWithRTLAnimation(context, Widget) => Navigator.push(context, RTLScreenAnimation(Widget));

class LTRScreenAnimation extends PageRouteBuilder {
  final Widget page;

  LTRScreenAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}

navToWithLTRAnimation(context, Widget) => Navigator.push(context, LTRScreenAnimation(Widget));

class FloatingActionButtonSizeNavigate extends PageRouteBuilder {
  final Widget page;

  FloatingActionButtonSizeNavigate(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

navToForFloatingActionButton(context, Widget) =>
    Navigator.push(context, FloatingActionButtonSizeNavigate(Widget));

Widget appCircleLoading() => CircularProgressIndicator.adaptive();

Future<void> localImagePicker(context, pickedImage) async {
  final ImagePicker picker = ImagePicker();
  await imagePickerDialog(
    context: context,
    cameraFCT: () async => pickedImage = await picker.pickImage(source: ImageSource.camera),
    galleryFCT: () async => pickedImage = await picker.pickImage(source: ImageSource.gallery),
    removeFCT: () => pickedImage = null,
  );
}
