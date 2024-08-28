import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/color/credit_card_gradiant.dart';
import '../../../../core/utils/functions/card_input_formatter_function.dart';
import '../../../../core/utils/functions/card_month_input_formatter_function.dart';
import '../../../../core/utils/functions/painters.dart';
import '../../../../generated/l10n.dart';

Widget buildFrontCreditCard(
        {required String cardNumber,
        required String cardHolder,
        required String cardExpiration,
        Gradient? color}) =>
    Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [Color(0xffFF7F50), Color(0xffFE0000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.imagesQnp,
                  width: 63.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  Assets.iconsMastercard,
                  height: 60,
                  width: 60,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  Assets.iconsChip,
                  height: 50,
                  width: 60,
                ),
                const SizedBox(width: 8),
                Image.asset(
                  Assets.assetsIconsContactLess,
                  height: 30,
                  width: 30,
                ),
              ],
            ),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildBackCreditCard(context, {cvv, color}) => Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [Color(0xffF0C27B), Color(0xff4B6C9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        height: 230,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            5.kH,
            const Text(
              'https://www.paypal.com',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            CustomPaint(
              painter: MyPainter(),
              child: SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cvv,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

Widget buildCardNumTextFieldWidget(context, cardNumberController, {required Function function}) =>
    Container(
      height: 55,
      width: MediaQuery.of(context).size.width / 1.12,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: cardNumberController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: S.of(context).card_number,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.credit_card,
            color: Colors.grey,
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
          CardInputFormatter(),
        ],
        onChanged: (value) => function,
      ),
    );

Widget buildFullNameTextField(context, cardHolderNameController, {required Function function}) =>
    Container(
      height: 55,
      width: MediaQuery.of(context).size.width / 1.12,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: cardHolderNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: S.of(context).full_name,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        onChanged: (value) => function,
      ),
    );

Widget buildRowTextField(context, cardExpiryDateController, cardCvvController,
        {required Function firstFunction,
        required Function secondFunction,
        required Function onTap}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width / 2.4,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: cardExpiryDateController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              hintText: 'MM/YY',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
              CardDateInputFormatter(),
            ],
            onChanged: (value) => firstFunction,
          ),
        ),
        14.kW,
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width / 2.4,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: cardCvvController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              hintText: 'CVV',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onTap: () => onTap,
            onChanged: (value) => secondFunction,
          ),
        ),
      ],
    );

Widget _buildDetailsBlock({required String label, required String value}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: .5,
          ),
        )
      ],
    );
