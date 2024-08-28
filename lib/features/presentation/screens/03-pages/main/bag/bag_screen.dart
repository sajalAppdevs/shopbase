import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/add_to_bag/add_to_bag_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_card/build_checkbag_card_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_dialog/build_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../data/models/bag_model.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  double calculateTotalPrice(List<BagModel> bagItems) {
    return bagItems.fold(0.0, (sum, item) {
      return sum + (item.totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => AddToBagCubit()..fetchBag(),
      child: BlocBuilder<AddToBagCubit, AddToBagState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConsts.backgroundAppColor,
              elevation: 3,
              actions: [
                Image.asset(
                  Assets.activeIconsSearch,
                  height: 25,
                  width: 25,
                ),
                10.kW
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).bag_title,
                          style: TextStyle(
                              fontSize: 40.0,
                              // color: AppConsts.blackAppColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state is SuccessBagFetching ? "(${state.bagItems.length})" : "(0)",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (state is LoadingBagFetching)
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: buildLoadingDataApp(),
                      )
                    else if (state is SuccessBagFetching)
                      if (state.bagItems.isEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(S.of(context).no_bags_data,
                                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                          ),
                        )
                      else if (state.bagItems.isNotEmpty)
                        Center(
                          child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.bagItems.length,
                                  separatorBuilder: (context, index) => 10.kH,
                                  itemBuilder: (context, index) => buildCheckbagCardWidget(context,
                                      name: state.bagItems[index].productName,
                                      image: state.bagItems[index].productImage,
                                      quantity: state.bagItems[index].quantity,
                                      price: state.bagItems[index].totalPrice.toString(),
                                      color: state.bagItems[index].color,
                                      size: state.bagItems[index].size.toString(),
                                      productId: state.bagItems[index].productId))),
                        ),
                    10.kH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).product_total_price,
                          style: TextStyle(
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp),
                        ),
                        Text(
                          state is SuccessBagFetching
                              ? "\$${calculateTotalPrice(state.bagItems)}"
                              : "\$0",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      ],
                    ),
                    2.kH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).delivery_price,
                          style: TextStyle(
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp),
                        ),
                        Text(
                          "\$14",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      ],
                    ),
                    5.kH,
                    Divider(
                        endIndent: 10,
                        indent: 2,
                        thickness: 1,
                        color: AppConsts.greyAppColor.withOpacity(0.4)),
                    5.kH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).total_amount,
                          style: TextStyle(
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp),
                        ),
                        Text(
                          state is SuccessBagFetching
                              ? calculateTotalPrice(state.bagItems) + 14 == 14
                                  ? "0"
                                  : "\$${calculateTotalPrice(state.bagItems) + 14}"
                              : "\$0",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      ],
                    ),
                    10.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: basicButton(
                          radius: 30,
                          title: S.of(context).checkout.toUpperCase(),
                          function: () => Future.delayed(const Duration(milliseconds: 300), () {
                                showDialog(
                                    context: context,
                                    builder: (context) => buildDefaultDialog(
                                          context,
                                          dialogText: "Checkout done!",
                                          dialogSubtitle: "Your checkout process success!",
                                        ));
                              })),
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
