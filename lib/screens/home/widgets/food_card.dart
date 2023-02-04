import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/constants/shared.dart';
import 'package:webuy_app/models/food.dart';

import '../../../constants/colors.dart';

class FoodCardWidget extends StatelessWidget {
  final Food food;
  final bool? isDragging;

  const FoodCardWidget({
    Key? key,
    required this.food,
    this.isDragging,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: isDragging == true
              ? ColorFiltered(
                  colorFilter: const ColorFilter.linearToSrgbGamma(),
                  child: Image.asset(
                    "assets/images/${food.imgUrl}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  "assets/images/${food.imgUrl}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        verticalSpace(10.h),
        Text(
          food.title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(5.h),
        Text(
          "${food.currency} ${food.price}",
          style: const TextStyle(color: grey),
        )
      ],
    );
  }
}
