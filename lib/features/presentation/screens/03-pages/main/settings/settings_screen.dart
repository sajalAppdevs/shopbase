import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/00-intro/intro_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/change_language_widget/build_change_lang_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/change_notification_widget/build_notification_switch_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_dialog/build_dialog_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app_cubit/app/app_cubit.dart';
import '../../../../../../core/utils/consts/consts.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../widgets/change_theme_widget/build_change_theme_widget.dart';
import '../../cubits/profile/profile_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => ProfileCubit()..fetchUserData(),
        child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          final profileCubit = context.read<ProfileCubit>();

          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, size: 16))),
              body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(S.of(context).settings,
                            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                        10.kH,
                        ListTile(
                          onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                          title: Text(
                            S.of(context).edit_your_profile,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          title: Text(
                            S.of(context).theme,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(context.read<AppCubit>().state.themeCurrentIndex == 0
                              ? "Light theme"
                              : "Dark theme"),
                          trailing: buildChangeThemeWidget(),
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
                          onTap: () => navToWithRTLAnimation(context, ChangeLanguageScreen()),
                          title: Text(
                            S.of(context).lang,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            title: Text(S.of(context).notif,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: buildNotificationSwitchWidget()),
                        5.kH,
                        Divider(
                            endIndent: 10,
                            indent: 2,
                            thickness: 1,
                            color: AppConsts.greyAppColor.withOpacity(0.4)),
                        5.kH,
                        ListTile(
                            onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                            title: Text(
                              S.of(context).priv_policy,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            onTap: () => showErrorSnackBar(S.of(context).error_title, 13, context),
                            title: Text(
                              S.of(context).rate_us,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            onTap: () {
                              if (profileCubit.userModel != null &&
                                  profileCubit.userModel!.name.isNotEmpty) {
                                Future.delayed(const Duration(milliseconds: 300),
                                    () => showLogoutDialog(context));
                              } else {
                                navAndFinish(context, IntroPage());
                              }
                            },
                            title: Text(
                                profileCubit.userModel != null &&
                                        profileCubit.userModel!.name.isNotEmpty
                                    ? S.of(context).logout
                                    : S.of(context).login,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.arrow_forward_ios_rounded,
                                color: AppConsts.greyAppColor, size: 15))
                      ]))));
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
