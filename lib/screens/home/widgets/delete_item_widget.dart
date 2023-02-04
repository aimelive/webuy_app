import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class DeleteItemFromCart extends StatelessWidget {
  const DeleteItemFromCart({
    Key? key,
    required this.foods,
    required this.isRemoving,
    required this.onCheckoutClicked,
    required this.onRemoveClicked,
  }) : super(key: key);

  final int foods;
  final bool isRemoving;
  final VoidCallback onRemoveClicked;
  final VoidCallback onCheckoutClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onRemoveClicked,
            child: Icon(
              isRemoving
                  ? Icons.delete_forever_outlined
                  : Icons.delete_outline_outlined,
              size: 30.sp,
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: onCheckoutClicked,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 0.0,
                  foregroundColor: primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 25.w),
                ),
                icon: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(
                    Icons.forward_outlined,
                    size: 24.sp,
                  ),
                ),
                label: Text(
                  "Checkout($foods)".toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
