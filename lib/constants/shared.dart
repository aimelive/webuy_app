import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:webuy_app/constants/colors.dart';

Widget horizontalSpace(double size) => SizedBox(
      width: size,
    );
Widget verticalSpace(double size) => SizedBox(
      height: size,
    );

pushPage(BuildContext context, {required Widget to}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => to),
    );
popPage(BuildContext context) => Navigator.pop(context);

// bool isDarkTheme(BuildContext context) {
//   var brightness = MediaQuery.of(context).platformBrightness;
//   bool isDarkMode = brightness == Brightness.dark;
//   return isDarkMode;
// }

showMessage(BuildContext context,
    {required String message, required bool success}) {
  showSimpleNotification(
    Container(
      margin: EdgeInsets.all(15.r),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade400 : Theme.of(context).errorColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: white,
        ),
      ),
    ),
    background: Colors.transparent,
    elevation: 0.0,
    slideDismissDirection: DismissDirection.up,
    duration: const Duration(seconds: 3),
  );
}

class MessageToast {
  final String message;
  const MessageToast._(this.message);

  static void success(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      success: true,
    );
  }

  static void error(BuildContext context, String error) {
    showMessage(
      context,
      message: error,
      success: false,
    );
  }
}
