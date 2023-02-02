import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/constants/shared.dart';

import '../constants/colors.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: GestureDetector(
        onTap: () => popPage(context),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.sp,
              vertical: 10.h,
            ),
            child: Icon(
              Icons.arrow_back,
              color: grey,
              size: 30.sp,
            ),
          ),
        ),
      ),
    );
  }
}
