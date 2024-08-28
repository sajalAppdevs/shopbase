import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/favourite/favourite_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';

import '../../../../../../core/utils/consts/consts.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../data/models/products_model.dart';
import '../../../../widgets/custom_stars/build_stars_widget.dart';
import '../product_card/product_card_screen.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => FavouriteCubit()..fetchFavouriteItems(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 3,
              backgroundColor: AppConsts.backgroundAppColor,
              actions: [Image.asset(Assets.activeIconsSearch, height: 25, width: 25), 10.kW],
            ),
            body: BlocBuilder<FavouriteCubit, List<ProductsModel>>(builder: (context, state) {
              var cubit = FavouriteCubit.get(context);
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).fav_title,
                              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                            ),
                            Text(state.isNotEmpty ? "(${state.length})" : "(0)",
                                style: TextStyle(
                                    color: AppConsts.greyAppColor,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        if (state.isEmpty)
                          Center(
                            child: Text(
                              "لا توجد عناصر مفضلة لديك!",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                            ),
                          ),
                        SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemCount: state.length,
                                separatorBuilder: (context, index) => 10.kH,
                                itemBuilder: (context, index) {
                                  final product = state[index];
                                  return GestureDetector(
                                    // onTap: ()=> navToWithRTLAnimation(context, ProductPage(
                                    //   productId: product.productId,
                                    //   image: product.productImage,
                                    //   name: product.productTitle,
                                    //   categoryName: product.productCategory,
                                    //   subCategoryName: product.productSubCategory,
                                    //   description: product.productDescription,
                                    //   price: product.productSale.toDouble().toString(),
                                    //   isSale: product.productSale != 0.0 ? false : true,
                                    //   sale: product.productSale.toDouble().toString(),
                                    // )),
                                    child: Card(
                                        child: Container(
                                            width: double.infinity,
                                            height: 120.0,
                                            child: Row(children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10.0),
                                                    bottomLeft: Radius.circular(10.0)),
                                                child: AspectRatio(
                                                  aspectRatio: 25 / 24.sp,
                                                  child: CachedNetworkImage(
                                                      imageUrl: product.productImage,
                                                      placeholder: (context, url) =>
                                                          buildLoadingDataApp(),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              15.kW,
                                              Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              product.productCategory,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: AppConsts.greyAppColor),
                                                            ),
                                                            StarRating(
                                                                rating: 3.5,
                                                                onRatingChanged: (value) {})
                                                          ],
                                                        ),
                                                        Text(product.productTitle,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.bold,
                                                                overflow: TextOverflow.visible)),
                                                        10.kH,
                                                        Text(
                                                          product.productSale != 0.0
                                                              ? "\$${product.productSale}"
                                                              : "\$${product.productPrice}",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.bold,
                                                            color: product.productSale != 0.0
                                                                ? Colors.red
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ])),
                                              10.kW,
                                              Divider(color: Colors.black, thickness: 58),
                                              Expanded(
                                                  child: IconButton(
                                                      onPressed: () => cubit
                                                              .removeFromFavourites(
                                                                  product.productId)
                                                              .then((value) {
                                                            cubit.fetchFavouriteItems();
                                                            showSuccessSnackBar(
                                                                "تمت الإزالة بنجاح!", 3, context);
                                                          }),
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )),
                                                  flex: 1),
                                              5.kW,
                                            ]))),
                                  );
                                }))
                      ])));
            })));
  }
}
