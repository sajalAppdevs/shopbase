import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../../screens/03-pages/main/bag/bag_screen.dart';
import '../../screens/03-pages/main/favourite/favourite_screen.dart';
import '../../screens/03-pages/main/home/home_screen.dart';
import '../../screens/03-pages/main/settings/profile_screen.dart';
import '../../screens/03-pages/main/shop/shop_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> navBarsItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded, color: Colors.grey),
      activeIcon: Image.asset(Assets.activeIconsShop, height: 26.0, width: 26.0),
      label: ("Home"),
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.shopping_cart_rounded, color: Colors.grey),
    //   activeIcon: Image.asset(Assets.activeIconsShoppingCart, height: 26.0, width: 26.0),
    //   label: ("Shop"),
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.card_giftcard_rounded, color: Colors.grey),
      activeIcon: Image.asset(Assets.activeIconsShopping, height: 26.0, width: 26.0),
      label: ("Bag"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.card_giftcard_rounded, color: Colors.grey),
      activeIcon: Image.asset(Assets.activeIconsGift, height: 26.0, width: 26.0),
      label: ("Favorite"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.grey),
      activeIcon: Image.asset(
        Assets.activeIconsCustomer,
        height: 26.0,
        width: 26.0,
      ),
      label: ("Profile"),
    ),
  ];

  List<Widget> screens = [
    HomePage(),
    // ShopPage(),
    BagPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarState(index));
  }
}
