import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';

import '../../../../generated/l10n.dart';

Widget descriptionProduct(context, String description) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).about_product_title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
        ),
        4.kH,
        Text(description, style: const TextStyle(height: 1.5)),
      ],
    );
