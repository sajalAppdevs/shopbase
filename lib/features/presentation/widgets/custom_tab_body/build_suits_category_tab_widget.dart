import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildSuitsCategoryTab() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          15.kH,
          Expanded(flex: 4, child: _buildSuitsAnnounceCard()),
          5.kH,
          Expanded(
              flex: 11,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _buildSuitsCategoriesCardWidget("Suits 3 parts"),
                  _buildSuitsCategoriesCardWidget("Suits 5 parts"),
                  _buildSuitsCategoriesCardWidget("Skirts"),
                  _buildSuitsCategoriesCardWidget("Suits Shoes"),
                  _buildSuitsCategoriesCardWidget("Suits Accessories"),
                ],
              ))
        ],
      ),
    );

Widget _buildSuitsAnnounceCard() => Card(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.deepPurple),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "SUITS SALES",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white),
              ),
              Text(
                "Up to 50% off",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );

Widget _buildSuitsCategoriesCardWidget(String title) => Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: [
            10.kW,
            Expanded(
                child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Image.asset(
                  Assets.imagesInitCover,
                  width: 80.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
