import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/shop/shop_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/shop/shop_cubit.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 3,
                  centerTitle: true,
                  title: Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  actions: [Image.asset(Assets.activeIconsSearch, height: 25, width: 25), 10.kW],
                  bottom: TabBar(
                      physics: BouncingScrollPhysics(),
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      tabs: cubit.tabTitle),
                ),
                body: TabBarView(children: cubit.tabs),
              ),
            ),
          );
        },
      ),
    );
  }
}
