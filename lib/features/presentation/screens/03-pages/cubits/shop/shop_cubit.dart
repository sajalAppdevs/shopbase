import 'package:bloc/bloc.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_tab_body/build_suits_category_tab_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_tab_body/build_summer_category_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../widgets/custom_tab_body/build_winter_category_tab_widget.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context, listen: false);

  List<Tab> tabTitle = [Tab(text: "Winter"), Tab(text: "Summer"), Tab(text: "Suits")];

  List<Widget> tabs = [
    buildWinterCategoryTab(),
    buildSummerCategoryTab(),
    buildSuitsCategoryTab(),
  ];
}
