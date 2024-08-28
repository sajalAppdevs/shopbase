import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

Widget favouriteButton() => LikeButton(
      size: 18.sp,
      circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor:
          BubblesColor(dotPrimaryColor: Color(0xff33b5e5), dotSecondaryColor: Color(0xff0099cc)),
      likeBuilder: (bool isLiked) {
        return Icon(isLiked ? Icons.favorite_sharp : Icons.favorite_border_sharp,
            color: isLiked ? Colors.redAccent : Colors.grey, size: 14.sp);
      },
    );
