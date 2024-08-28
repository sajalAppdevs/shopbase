import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_stars/build_stars_widget.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';

import '../../screens/03-pages/main/product_card/product_card_screen.dart';

Widget buildNewCardWidget(context,
        {required dynamic productId,
        required String image,
        required String name,
        required String categoryName,
        required String subCategoryName,
        required String description,
        required String price,
        required bool isSale,
        required String sale,
        required VoidCallback favouriteFunction}) =>
    InkWell(
        borderRadius: BorderRadius.circular(14.0),
        onTap: () => navToWithRTLAnimation(
            context,
            ProductPage(
              productId: productId,
              image: image,
              name: name,
              categoryName: categoryName,
              subCategoryName: subCategoryName,
              description: description,
              price: price,
              isSale: isSale,
              sale: sale,
            )),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Container(
                  width: 135,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
                      Stack(
                        children: [
                          ClipRRect(
                            child: AspectRatio(
                                aspectRatio: 30 / 29,
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  placeholder: (context, url) => buildLoadingDataApp(),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.maxFinite,
                                )),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(30.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 26,
                              decoration: BoxDecoration(
                                  color: isSale != true
                                      ? AppConsts.errorAppColor
                                      : AppConsts.blackAppColor,
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: Center(
                                  child: Text(
                                isSale != true ? "SALE" : "NEW",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: ElevatedButton(
                                  onPressed: favouriteFunction,
                                  style: ButtonStyle(
                                      side: MaterialStatePropertyAll(
                                          BorderSide(color: Colors.black12)),
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      shape: MaterialStatePropertyAll(CircleBorder())),
                                  child: Icon(
                                    Icons.favorite_border_sharp,
                                    size: 20.0,
                                    color: AppConsts.greyAppColor,
                                  ))),
                          top: 70,
                          bottom: -40,
                          left: 65)
                    ]),
                    20.kH,
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Center(child: StarRating(rating: 3.5, onRatingChanged: (value) {})),
                      5.kW,
                      Center(child: Text("(3.5)", style: TextStyle(color: AppConsts.greyAppColor)))
                    ]),
                    10.kH,
                    Text(categoryName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppConsts.greyAppColor)),
                    Text(name,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis)),
                    Row(
                      children: [
                        Text("\$$price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                decoration: isSale != true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor:
                                    isSale != true ? Colors.deepOrange : Colors.transparent,
                                decorationThickness: isSale != true ? 12 : 0)),
                        8.kW,
                        isSale != true
                            ? Text("\$$sale",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                            : SizedBox.shrink(),
                      ],
                    )
                  ]))
            ])));
