import 'package:flutter/material.dart';

Widget ColorAndSize(context) => Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Color"),
              Row(
                children: [
                  colorDot(
                    color: Color(0xFF356C95),
                    isSelected: true,
                  ),
                  colorDot(color: Color(0xFFF8C078)),
                  colorDot(color: Color(0xFFA29B9B)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: "Size\n"),
                TextSpan(
                  text: "XL",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );

Widget colorDot({required Color color, bool isSelected = false}) => Container(
      margin: const EdgeInsets.only(
        top: 20 / 4,
        right: 20 / 4,
      ),
      padding: const EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
