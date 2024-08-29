import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/profile/profile_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/main/settings/credit_card_screen.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/main/settings/settings_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchUserData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).profile,
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                    10.kH,
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple,
                        foregroundImage: AssetImage('assets/images/1.jpg'),
                      ),
                      title: Text(
                          cubit.userModel != null ? cubit.userModel!.name.toString() : "John Doe",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        cubit.userModel != null
                            ? cubit.userModel!.email.toString()
                            : "email@gmail.com",
                        style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    15.kH,
                    ListTile(
                        onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                        title: Text(
                          S.of(context).my_orders,
                          style: TextStyle(
                              // color: AppConsts.blackAppColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Already have 12 orders",
                          style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: AppConsts.greyAppColor, size: 15)),
                    5.kH,
                    Divider(
                        endIndent: 10,
                        indent: 2,
                        thickness: 1,
                        color: AppConsts.greyAppColor.withOpacity(0.4)),
                    5.kH,
                    ListTile(
                      onTap: () => navToWithRTLAnimation(context, CreditCardPage()),
                      title: Text(
                        S.of(context).payment_method,
                        style: TextStyle(
                            // color: AppConsts.blackAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Visa  **34",
                        style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConsts.greyAppColor,
                        size: 15,
                      ),
                    ),
                    5.kH,
                    Divider(
                      endIndent: 10,
                      indent: 2,
                      thickness: 1,
                      color: AppConsts.greyAppColor.withOpacity(0.4),
                    ),
                    5.kH,
                    ListTile(
                      onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                      title: Text(
                        S.of(context).shipping_address,
                        style: TextStyle(
                            // color: AppConsts.blackAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "3 ddresses",
                        style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConsts.greyAppColor,
                        size: 15,
                      ),
                    ),
                    5.kH,
                    Divider(
                      endIndent: 10,
                      indent: 2,
                      thickness: 1,
                      color: AppConsts.greyAppColor.withOpacity(0.4),
                    ),
                    5.kH,
                    ListTile(
                      onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                      title: Text(
                        S.of(context).promocodes,
                        style: TextStyle(
                            // color: AppConsts.blackAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Check everyday here if you have special promocodes",
                        style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConsts.greyAppColor,
                        size: 15,
                      ),
                    ),
                    5.kH,
                    Divider(
                      endIndent: 10,
                      indent: 2,
                      thickness: 1,
                      color: AppConsts.greyAppColor.withOpacity(0.4),
                    ),
                    5.kH,
                    ListTile(
                      onTap: () => navToWithRTLAnimation(context, SettingsPage()),
                      title: Text(
                        S.of(context).settings,
                        style: TextStyle(
                            // color: AppConsts.blackAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Notifications, edit your profile, Themes and Language",
                        style: TextStyle(color: AppConsts.greyAppColor, fontSize: 13),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConsts.greyAppColor,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
