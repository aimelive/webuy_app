import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/food.dart';

class FoodPlateWidget extends StatelessWidget {
  const FoodPlateWidget({
    Key? key,
    required this.food,
    this.isDragging,
  }) : super(key: key);

  final Food food;
  final bool? isDragging;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      margin: EdgeInsets.all(5.r),
      width: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(food.imgUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        margin: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.r),
        child: Text(
          food.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
