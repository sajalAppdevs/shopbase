import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/show_orders/show_orders_screen.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/show_products/show_products_screen.dart';

import '../../../../data/models/dashboard_items_model.dart';
import '../../screens/upload_products_screen.dart';

part 'layout_state.dart';

class DashboardLayoutCubit extends Cubit<DashboardLayoutState> {
  DashboardLayoutCubit() : super(LayoutInitial());

  static DashboardLayoutCubit get(context) => BlocProvider.of(context, listen: false);

  // List<DashboardButtonsModel> dashboardButton = [
  //   DashboardButtonsModel(text: 'عرض المنتجات', icon: Icons.shop, onPressed: ShowProductPage()),
  //   DashboardButtonsModel(text: 'الطلبات', icon: Icons.request_page, onPressed: ShowOrdersPage())
  // ];

  List<BottomNavigationBarItem> navBarsItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.shop, color: Colors.grey),
      label: ("عرض المنتجات"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_rounded, color: Colors.grey),
      label: ("الطلبات"),
    )
  ];

  int currentIndex = 0;

  List<Widget> screens = [ShowProductPage(), ShowOrdersPage()];

  List<String> titles = ["عرض المنتجات", "الطلبات"];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarState(index));
  }
}
/*
  int currentIndex = 0;

  List<BottomNavigationBarItem> navBarsItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded, color: Colors.grey),
      activeIcon: Image.asset(Assets.activeIconsShop, height: 26.0, width: 26.0),
      label: ("Home"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_rounded, color: Colors.grey),
      activeIcon: Image.asset(Assets.activeIconsShoppingCart, height: 26.0, width: 26.0),
      label: ("Shop"),
    ),
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
    ShopPage(),
    BagPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarState(index));
  }
 */
