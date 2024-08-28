import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/features/data/models/bag_model.dart';
import 'package:shopbase_firebase/features/presentation/screens/03-pages/cubits/add_to_bag/add_to_bag_cubit.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/product_card_components/build_description_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../widgets/product_card_components/build_product_info_widget.dart';

// ${Localizations.localeOf(context).languageCode == 'ar' ? : }

class ProductPage extends StatefulWidget {
  final dynamic productId, subCategoryName;
  final String image, name, categoryName, description, price, sale;
  final bool isSale;

  const ProductPage({
    required this.productId,
    required this.name,
    required this.image,
    required this.categoryName,
    required this.subCategoryName,
    required this.description,
    required this.price,
    required this.sale,
    required this.isSale,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToBagCubit(),
      child: BlocBuilder<AddToBagCubit, AddToBagState>(
        builder: (context, state) {
          final double price = double.tryParse(widget.isSale != true ? widget.sale : widget.price) ?? 0.0;
          final double quantity = state.quantity.toDouble();
          final double _result = price * quantity;
          var cubit = AddToBagCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, size: 18))),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 36.sp),
                          child: Column(children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                                child: Row(children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      productInfo(
                                          title: "${S.of(context).brand}: ", product: "Adidas"),
                                      10.kH,
                                      productInfo(
                                          title: "${S.of(context).code}: ", product: "87AS75BH"),
                                      10.kH,
                                      productInfo(
                                          title: "${S.of(context).leather}: ", product: "100%"),
                                      10.kH
                                    ],
                                  ),
                                  40.kW,
                                  Expanded(
                                      child: Hero(
                                          tag: "1",
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.network(widget.image,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.sizeOf(context).width.w * 0.35,
                                                  height:
                                                      MediaQuery.sizeOf(context).height.h * 0.35))))
                                ]))
                          ]))),
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.kH,
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(widget.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
                          Row(
                            children: [
                              Text("$_result",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppConsts.blackAppColor,
                                      decoration: TextDecoration.lineThrough)),
                              Text("\$",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppConsts.basicAppColor,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          )
                        ]),
                        20.kH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(S.of(context).size,
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                  height: 26.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cubit.sizes.length,
                                      itemBuilder: (context, index) {
                                        print(cubit.sizes.toString());
                                        return buildCategory(index, cubit.sizes[index]);
                                      })),
                            ),
                          ],
                        ),
                        20.kH,
                        descriptionProduct(context, widget.description),
                        20.kH,
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: state is LoadingAddToBagState
                        ? CircularProgressIndicator.adaptive()
                        : basicButton(
                            title: S.of(context).add_to_card.toUpperCase(),
                            function: () {
                              final bagItems = BagModel(
                                  productId: widget.productId,
                                  productName: widget.name,
                                  productImage: widget.image,
                                  quantity: state.quantity,
                                  size: cubit.sizes[selectedIndex],
                                  totalPrice: _result.toDouble());
                              cubit.addToBag(widget.productId, bagItems).then((value) {
                                showSuccessSnackBar("تم اضافة المنتج للسلة بنجاح!", 3, context);
                                Navigator.pop(context);
                              }).catchError((onError) {
                                print(onError.toString());
                                showErrorSnackBar(
                                    "ثمة خطأ ما!! الرجاء اعادة المحاولة!!", 3, context);
                              });
                            }),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => cubit.decrementQuality(),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                CircleBorder(side: BorderSide(color: AppConsts.greyAppColor)))),
                      ),
                      5.kW,
                      Text(state.quantity.toString()),
                      5.kW,
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => cubit.incrementQuality(),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                CircleBorder(side: BorderSide(color: AppConsts.greyAppColor)))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategory(int index, String size) {
    return GestureDetector(
      onTap: () => setState(() {
        print(selectedIndex = index);
        selectedIndex = index;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: 30,
          decoration: BoxDecoration(
            color: selectedIndex == index ? AppConsts.basicAppColor : Colors.white,
            border: Border.all(
              color: selectedIndex == index
                  ? AppConsts.basicAppColor
                  : AppConsts.blackAppColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        selectedIndex == index ? AppConsts.whiteAppColor : AppConsts.greyAppColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
