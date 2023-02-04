import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/constants/colors.dart';

class TopShape extends CustomClipper<Path> {
  final AnimationController _controller;

  TopShape._(this._controller);

  static Widget draw(
    Color color,
    String text,
    AnimationController controller,
  ) {
    return ClipPath(
      clipper: TopShape._(controller),
      child: ColoredBox(
        color: color,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: Platform.isAndroid ? 12.h : 0.h,
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Path getClip(Size size) {
    final path = Path();

    //First point
    path.lineTo(
      0,
      Tween<double>(begin: 0, end: size.height * 0.7655502392344498)
          .animate(_controller)
          .value,
    );
    //Second point
    path.cubicTo(
      size.width * 0.03333333333,
      Tween<double>(begin: 0, end: size.height * 0.68)
          .animate(_controller)
          .value,
      size.width * 0.12,
      Tween<double>(begin: 0, end: size.height * 0.55)
          .animate(_controller)
          .value,
      size.width * 0.22,
      Tween<double>(begin: 0, end: size.height * 0.665)
          .animate(_controller)
          .value,
    );
    //Third point
    path.cubicTo(
      size.width * 0.34358974359,
      Tween<double>(begin: 0, end: size.height * 0.7942583732)
          .animate(_controller)
          .value,
      size.width * 0.3923046923,
      Tween<double>(begin: 0, end: size.height * 0.81818181818)
          .animate(_controller)
          .value,
      size.width * 0.45128205128,
      Tween<double>(begin: 0, end: size.height * 0.74641148325)
          .animate(_controller)
          .value,
    );
    //Forth point
    path.cubicTo(
      size.width * 0.51,
      Tween<double>(begin: 0, end: size.height * 0.67)
          .animate(_controller)
          .value,
      size.width * 0.56,
      Tween<double>(begin: 0, end: size.height * 0.416)
          .animate(_controller)
          .value,
      size.width * 0.642,
      Tween<double>(begin: 0, end: size.height * 0.593)
          .animate(_controller)
          .value,
    );
    //Fifth point
    path.cubicTo(
      size.width * 0.71,
      Tween<double>(begin: 0, end: size.height * 0.77)
          .animate(_controller)
          .value,
      size.width * 0.725,
      Tween<double>(begin: 0, end: size.height).animate(_controller).value,
      size.width * 0.78,
      Tween<double>(begin: 0, end: size.height).animate(_controller).value,
    );
    //sixth point
    path.cubicTo(
      size.width * 0.84,
      Tween<double>(begin: 0, end: size.height).animate(_controller).value,
      size.width * 0.89,
      Tween<double>(begin: 0, end: size.height * 0.62)
          .animate(_controller)
          .value,
      size.width,
      Tween<double>(begin: 0, end: size.height * 0.71)
          .animate(_controller)
          .value,
    );
    //Seventh point
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
