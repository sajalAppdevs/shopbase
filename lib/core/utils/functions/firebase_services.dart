import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseServices {
  ///==================== > Variables
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final productID = const Uuid().v4();
  final userID = const Uuid().v4();
  final creditID = const Uuid().v1();
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final uploadProductPics = FirebaseStorage.instance.ref().child("productsImages");
  final uploadUserPics = FirebaseStorage.instance.ref().child("usersImages");
  final currentId = FirebaseAuth.instance.currentUser?.uid ?? null;

  ///==================== > Init FCM Token
  static Future<void> initFcmToken() async {
    late final FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = firebaseMessaging!.getToken();
    fcmToken.then((token) => print("Token: $token")).catchError((onError) => onError.toString());
  }

  ///==================== > Login using email and password
  Future<void> login(context, TextEditingController emailController,
      TextEditingController passwordController) async {
    await auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  ///==================== > Logout
  Future<void> logout() async => await auth.signOut();

  ///==================== > Register using email
  Future<UserCredential> signUpWithEmail({required String email, required String password}) async =>
      await auth.createUserWithEmailAndPassword(email: email, password: password);

  ///==================== > Register using google
  Future<UserCredential> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  ///==================== > 1st Verify function: send otp
  //send OTP Code to Phone Number

  Future<void> sendOTPCode(String phoneNumber, Function(String) onCodeSent) async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 40),
      phoneNumber: '+20$phoneNumber',
      verificationCompleted: (credential) {},
      verificationFailed: (e) {},
      codeSent: (verificationId, resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // verify OTP Code

  Future<String> verifyOTPCode({required String verifyId, required String otp}) async {
    try {
      PhoneAuthCredential authCredential =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
      final UserCredential userCredential = await auth.signInWithCredential(authCredential);
      if (userCredential.user != null) {
        return 'success';
      } else {
        return 'Error in OTP';
      }
    } catch (e) {
      return e.toString();
    }
  }

  ///==================== > 2nd Verify function: send email verify
  Future<void> sendEmailVerify() async {}

  ///==================== > upload user data to FirebaseFirestore
  Future<void> uploadUserDataToFirebase(var uid,
      {required var nameController,
      required var imageController,
      required var emailController,
      required var phoneController}) async {
    await firestore.collection("users").doc(uid).set({
      'userId': uid,
      'userName': nameController,
      'userEmail': emailController,
      'userPhone': phoneController,
      'createdAt': Timestamp.now(),
      'userAddress': "",
      'userImage': "",
      // 'userFavourites': [],
      // 'userProducts': [],
      // 'userPaymentMethods': []
    });
  }

  ///==================== > upload products pics to FirebaseStorage
  Future<void> uploadProductToFirebaseFirestore({
    required XFile? pickedImage,
    required var titleController,
    required var priceController,
    required var selectedCategory,
    required var selectedSubCategory,
    required var descriptionController,
    required var quantityController,
  }) async {
    if (pickedImage != null) {
      final ref = uploadProductPics.child('$productID.jpg');
      await ref.putFile(File(pickedImage.path));
      final productImageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("products").doc(productID).set({
        'productId': productID,
        'productTitle': titleController,
        'productPrice': priceController,
        'productImage': productImageUrl,
        'productCategory': selectedCategory.toString().trim(),
        'productSubCategory': selectedSubCategory.toString().trim(), // Convert enum to string
        'productDescription': descriptionController,
        'productQuantity': quantityController,
        'createdAt': Timestamp.now(),
      });
    }
  }

  ///==================== > upload users pics to FirebaseStorage
  Future<void> uploadUserPicToFirebaseStorage(
      {required XFile? pickedImage, required String productImageUrl}) async {
    if (pickedImage != null) {
      final ref = FirebaseStorage.instance.ref().child("usersImages").child('$productID.jpg');
      await ref.putFile(File(pickedImage.path));
      productImageUrl = await ref.getDownloadURL();
    }
  }

  ///==================== > get user data from FirebaseFirestore
  Future<void> getUserDataFromFirebase(uid) async =>
      FirebaseFirestore.instance.collection("users").doc(uid).get();

  ///==================== > delete product data from FirebaseFirestore
  Future<void> deleteProductDataFromFirebase(productID) async =>
      await FirebaseFirestore.instance.collection("products").doc(productID).delete();

  ///==================== > create credit collection for user collection
}

// Certificate fingerprints:
// SHA1: F6:92:4C:21:FB:7C:0D:FE:4B:C9:1B:2C:86:31:35:25:E0:BA:EE:B1
// SHA256: E5:83:36:93:AF:04:62:2E:97:5F:07:6A:D6:03:A9:FA:A3:C3:6B:B6:06:B0:3B:CB:E9:2A:CD:09:9F:72:3E:CA
