import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/features/presentation/screens/00-intro/intro_screen.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/layout/cubit/layout_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/upload_products_screen.dart';

import '../../../../../../../core/utils/functions/functions.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardLayoutCubit(),
      child: BlocBuilder<DashboardLayoutCubit, DashboardLayoutState>(
        builder: (context, state) {
          var cubit = DashboardLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton.filled(
                    onPressed: () => navAndFinish(context, IntroPage()),
                    icon: Icon(Icons.logout, color: AppConsts.whiteAppColor),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppConsts.basicAppColor)),
                  ),
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.small(
              onPressed: () => navToForFloatingActionButton(context, UploadProductsPage()),
              // onPressed: () => navToForFloatingActionButton(context, UploadProductPage()),
              child: Icon(Icons.upload),
              backgroundColor: AppConsts.basicAppColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => cubit.changeBottomNavBar(index),
              items: cubit.navBarsItems,
              currentIndex: cubit.currentIndex,
              showSelectedLabels: true,
            ),
          );
        },
      ),
    );
  }
}
