import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => cubit.changeBottomNavBar(index),
              items: cubit.navBarsItems,
              currentIndex: cubit.currentIndex,
              showSelectedLabels: true,
              selectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
