import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/favourite/favourite_cubit.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/home/home_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/consts/consts.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../widgets/custom_card/build_new_card_widget.dart';
import '../../../../widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import '../../../../widgets/custom_text_button_widget/build_text_button_widget.dart';
import '../../../04-dashboard/presentation/pages/screens/show_products/cubit/show_products_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // the first section in the home main
                  Stack(
                    children: [
                      Image.asset(
                        Assets.imagesHomeImg,
                        fit: BoxFit.cover,
                        height: 450,
                        width: double.infinity,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              140.kH,
                              Text(S.of(context).home_title_1.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 40.0))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  30.kH,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).new_title.toUpperCase(),
                              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                            ),
                            buildTextButton(
                              title: S.of(context).show_all,
                            )
                          ],
                        ),
                        Text(
                          S.of(context).new_subtitle,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  10.kH,
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: context.read<ShowProductsCubit>().ver.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (snapshot.error is FirebaseException &&
                            (snapshot.error as FirebaseException).code == 'failed-precondition') {
                          return Center(
                              child: Text(
                                  'Please create the required index in the Firestore console.'));
                        } else {
                          print(">>>>>>>>>>>>>>>>StackTrace: ${snapshot.stackTrace}");
                          return Center(child: Text('Something went wrong: ${snapshot.error}'));
                        }
                      }

                      if (!snapshot.hasData || state is LoadingShowProductsState) {
                        return Center(child: buildLoadingDataApp());
                      }

                      final data = snapshot.data;
                      if (data == null || data.docs.isEmpty) {
                        return Container(
                          constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height * 0.2),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              S.of(context).no_news_products,
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                            )),
                          ),
                        );
                      }

                      final products = context.read<ShowProductsCubit>().products;
                      if (products.isEmpty) {
                        return Container(
                          constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height * 0.383),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('No products available'),
                            ),
                          ),
                        );
                      }

                      return Container(
                        constraints: BoxConstraints.expand(
                            height: MediaQuery.of(context).size.height * 0.383),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return buildNewCardWidget(context, favouriteFunction: () async {
                                print("Clicked");
                                return await context
                                    .read<FavouriteCubit>()
                                    .addToFavourites(product)
                                    .then((value) => showSuccessSnackBar(
                                        "تم الاضافة للمفضلات بنجاح!", 3, context))
                                    .catchError((onError) =>
                                        showErrorSnackBar(onError.toString(), 3, context));
                              },
                                  productId: product.productId,
                                  image: product.productImage,
                                  categoryName: product.productCategory,
                                  subCategoryName: product.productSubCategory,
                                  description: product.productDescription,
                                  name: product?.productTitle ?? "",
                                  price: product.productPrice.toDouble().toString(),
                                  isSale: product.productSale == 0.0 ? true : false,
                                  sale: product.productSale.toDouble().toString());
                            },
                            itemCount: products.length,
                          ),
                        ),
                      );
                    },
                  ),

                  10.kH,
                  // the second section in the home main
                  Stack(
                    children: [
                      Image.asset(
                        Assets.imagesInitCover,
                        fit: BoxFit.values[2],
                        height: 430,
                        width: double.infinity,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              170.kH,
                              Text(S.of(context).home_title_2.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 40.0)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 130,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: AppConsts.basicAppColor,
                                      borderRadius: BorderRadius.circular(40.0)),
                                  child: Center(
                                      child: Text(
                                    S.of(context).verify_button,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  30.kH,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).sale_title.toUpperCase(),
                              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                            ),
                            buildTextButton(
                              title: S.of(context).show_all,
                            )
                          ],
                        ),
                        Text(
                          S.of(context).sale_subtitle,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppConsts.greyAppColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  10.kH,
                  // Container(
                  //   /// this line code when I do responsive with web:
                  //   /// constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height * 0.7),
                  //
                  //   constraints:
                  //       BoxConstraints.expand(height: MediaQuery.of(context).size.height * 0.383),
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ListView.builder(
                  //         physics: BouncingScrollPhysics(),
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (context, index) => buildSaleCardWidget(context),
                  //         itemCount: 6),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
