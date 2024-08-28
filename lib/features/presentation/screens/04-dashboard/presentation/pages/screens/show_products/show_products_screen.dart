import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/widgets/build_default_card_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';

import '../../../../../../../../core/utils/functions/firebase_services.dart';
import '../../../../../../../../generated/l10n.dart';
import '../../../../../../widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'cubit/show_products_cubit.dart';

class ShowProductPage extends StatelessWidget {
  const ShowProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProductsCubit()..showProduct(),
      child: BlocBuilder<ShowProductsCubit, ShowProductsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: context.read<ShowProductsCubit>().ver.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: buildLoadingDataApp());
                  } else if (snapshot.data!.docs.isEmpty || snapshot.data!.docs == []) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(S.of(context).no_news_products, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                      ),
                    );
                  }

                  final products = snapshot.data!.docs;
                  return Container(
                    constraints: BoxConstraints.expand(
                        height: AppConsts.heightExpandSize(context),
                        width: AppConsts.heightExpandSize(context)),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 80),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index].data();
                          return buildDashboardCardWidget(context,
                              uid: product['productId'],
                              image: product['productImage'],
                              name: product['productTitle'],
                              categoryName: product['productCategory'],
                              sale: product['productSale'] == '' ? "" : product['productSale'],
                              price: product['productPrice'], onDelete: () async {
                            return await FirebaseServices()
                                .deleteProductDataFromFirebase(product['productId'])
                                .then((value) {
                              showSuccessSnackBar("تم ازالة المنتج بنجاح!!", 3, context);
                            }).catchError((onError) {
                              print(">>>>>>>>>>>>>>>>>>>" + onError.toString());
                              showErrorSnackBar("في مشكلة ${onError.toString()}", 3, context);
                            });
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
