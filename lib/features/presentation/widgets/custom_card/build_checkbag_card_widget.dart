import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';

import '../../../../core/utils/consts/consts.dart';
import '../../../../generated/l10n.dart';
import '../custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';

Widget buildCheckbagCardWidget(context,
        {required dynamic productId,
        required String image,
        required String name,
        required String size,
        required int quantity,
        required String color,
        required String price}) =>
    Card(
      child: Container(
        width: double.infinity,
        height: 120.0,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CachedNetworkImage(
                          imageUrl: image.isNotEmpty ? image : "",
                          placeholder: (context, url) => buildLoadingDataApp(),
                          height: MediaQuery.of(context).size.height,
                          width: 100,
                          fit: BoxFit.cover),
                    ))),
            10.kW,
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${S.of(context).size}: ",
                            style: TextStyle(fontSize: 15, color: AppConsts.greyAppColor),
                          ),
                          5.kW,
                          Text(
                            size,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      10.kW,
                      Row(
                        children: [
                          Text(
                            "اللون:",
                            style: TextStyle(fontSize: 15, color: AppConsts.greyAppColor),
                          ),
                          5.kW,
                          Text(
                            color,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "الكمية: ",
                            style: TextStyle(fontSize: 15, color: AppConsts.greyAppColor),
                          ),
                          5.kW,
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      10.kW,
                      Row(
                        children: [
                          Text(
                            "السعر الكلي:",
                            style: TextStyle(fontSize: 15, color: AppConsts.greyAppColor),
                          ),
                          5.kW,
                          Text(
                            price,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
