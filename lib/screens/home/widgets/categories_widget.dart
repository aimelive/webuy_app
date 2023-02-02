import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/models/category.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int selecteCategoryId = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            "Category",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories
              .map(
                (category) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selecteCategoryId = category.id;
                    });
                  },
                  child: Container(
                    width: 70.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: selecteCategoryId == category.id
                          ? Border.all(
                              color: primaryColor,
                              width: 2.5.r,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/${category.icon}"),
                        Text(
                          category.title,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
