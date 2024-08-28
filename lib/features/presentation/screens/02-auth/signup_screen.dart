import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/02-auth/pinput_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_text_form_field/build_phone_form_field_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_text_form_field/build_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/custom_text_form_field/build_password_form_field_widget.dart';
import 'cubits/signup/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          TextEditingController nameController = TextEditingController();
          TextEditingController phoneController = TextEditingController();
          TextEditingController emailController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          final formKey = GlobalKey<FormState>();
          final cubit = SignupCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios, size: 18.sp)),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).register,
                          style: TextStyle(fontSize: 34.sp),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset('assets/icons/app_icon.png', fit: BoxFit.cover),
                        ),
                        buildTextFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            hint: "John Doe",
                            label: S.of(context).name,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).name_validation;
                              }
                              final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                              if (!nameRegExp.hasMatch(value)) {
                                return 'Name must contain only letters and spaces';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters long';
                              }
                              return null;
                            },
                            onSubmit: () {},
                            onTap: () {},
                            onChanged: () {},
                            onSave: () {}),
                        10.kH,
                        buildTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: S.of(context).email,
                            hint: "email@domain.com",
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).email_validation;
                              }
                              final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                              if (!emailRegExp.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            onSubmit: () {},
                            onTap: () {},
                            onChanged: () {},
                            onSave: () {}),
                        10.kH,
                        buildPhoneFormFieldWidget(
                          context,
                            controller: phoneController,
                            onTap: () {},
                            onSubmit: () {},
                            onSave: () {},
                            label: S.of(context).phone,
                            hint: '1234567890'),
                        10.kH,
                        buildPasswordFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: S.of(context).password,
                            hint: "",
                            isVisible: cubit.visible,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).password_validation;
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              final passwordRegExp =
                                  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                              if (passwordRegExp.hasMatch(value)) {
                                return 'Password must contain at least one letter and one number';
                              }
                              return null;
                            },
                            onPressed: () => cubit.togglePasswordVisibility(),
                            onSubmit: () {},
                            onTap: () {},
                            onChanged: () {},
                            onSave: () {}),
                        // createOrWidget(),
                        // SignupWithGoogleButtonWidget(context,
                        //     onPressed: () => cubit
                        //         .signInWithGoogle(context)
                        //         .then((value) => FirebaseServices().auth.currentUser != null
                        //             ? navAndFinish(context, Layout())
                        //             : showErrorSnackBar("فشل التسجيل!!", 3, context))
                        //         .catchError((onError) =>
                        //             showErrorSnackBar(onError.toString(), 3, context))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 35.0),
                            child: state is LoadingCreateUserState
                                ? buildLoadingDataApp()
                                : state is SuccessCreateUserState
                                    ? basicButton(
                                        title: S.of(context).register.toUpperCase(),
                                        function: () {
                                          if (formKey.currentState!.validate()) {
                                            cubit
                                                .signupUsingEmail(context,
                                                    name: nameController.text.trim(),
                                                    image: "",
                                                    email: emailController.text.trim(),
                                                    phone: phoneController.text.trim(),
                                                    password: passwordController.text.trim())
                                                .then((value) {
                                              // FirebaseServices().sendOTPCode(
                                              //     phoneController.text,
                                              //     (String verId) => navToWithRTLAnimation(
                                              //         context,
                                              //         OtpScreen(
                                              //             phoneNumber: phoneController.text,
                                              //             verification: verId)));
                                              navToWithRTLAnimation(
                                                  context,
                                                  OtpScreen(
                                                      phoneNumber: phoneController,
                                                      verification: "verification"));
                                            }).catchError((onError)=> showErrorSnackBar("حاول مرة اخرى!!!", 3, context));
                                          }
                                        })
                                    : basicButton(
                                        title: S.of(context).register.toUpperCase(),
                                        function: () {
                                          if (formKey.currentState!.validate()) {
                                            cubit
                                                .signupUsingEmail(context,
                                                    name: nameController.text.trim(),
                                                    image: "",
                                                    email: emailController.text.trim(),
                                                    phone: phoneController.text.trim(),
                                                    password: passwordController.text.trim())
                                                .then((value) {
                                              navToWithRTLAnimation(
                                                  context,
                                                  OtpScreen(
                                                      phoneNumber: phoneController,
                                                      verification: "verification"));
                                            });
                                          }
                                        }))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
