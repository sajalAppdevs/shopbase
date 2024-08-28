import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/consts/consts.dart';

class StarRating extends StatefulWidget {
  final double rating;
  final Color starColor;
  final Color unselectedColor;
  final double starSize;
  final Function(double) onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    this.starColor = Colors.amber,
    this.unselectedColor = AppConsts.greyAppColor,
    this.starSize = 16.0,
    required this.onRatingChanged,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () => onTapStar(index + 1.0),
          child: Icon(
            CupertinoIcons.star_fill,
            size: widget.starSize,
            color: _currentRating >= index + 1.0
                ? widget.starColor
                : widget.unselectedColor,
          ),
        ),
      ),
    );
  }

  void onTapStar(double rating) {
    setState(() {
      _currentRating = rating;
    });
    widget.onRatingChanged(rating);
  }
}
