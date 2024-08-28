import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/02-auth/cubits/login/login_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_text_button_widget/build_text_button_with_icon.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_text_form_field/build_text_form_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/custom_text_form_field/build_password_form_field_widget.dart';
import '../04-dashboard/presentation/pages/layout/layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          TextEditingController emailController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          final formKey = GlobalKey<FormState>();
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: true,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, size: 18.sp))),
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
                        Text(S.of(context).login,
                            style: TextStyle(fontSize: 34, color: AppConsts.blackAppColor)),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset('assets/icons/app_icon.png', fit: BoxFit.cover),
                        ),
                        buildTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: S.of(context).email,
                            hint: "email@domain.com",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return S.of(context).email_validation;
                              }
                            },
                            onTap: () {},
                            onChanged: () {},
                            onSubmit: () {},
                            onSave: () {}),
                        20.kH,
                        buildPasswordFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: S.of(context).password,
                            hint: "",
                            isVisible: true,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return S.of(context).email_validation;
                              }
                            },
                            onTap: () {},
                            onChanged: () {},
                            onSubmit: () {},
                            onSave: () {},
                            onPressed: () {}),
                        5.kH,
                        buildTextButtonWithIcon(
                            title: S.of(context).forget_your_password,
                            icon: CupertinoIcons.arrow_right),
                        state is LoadingLoginState
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 35.0),
                                child: buildLoadingDataApp())
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 35.0),
                                child: basicButton(
                                    title: S.of(context).login.toUpperCase(),
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        if (emailController.value.text == 'admin@admin.ad' &&
                                            passwordController.value.text == '1234560') {
                                          navAndFinish(context, DashboardLayout());
                                        } else {
                                          cubit.login(context,
                                              emailController: emailController,
                                              passwordController: passwordController);
                                        }
                                      }
                                    }),
                              )
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
