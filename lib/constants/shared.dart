import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:webuy_app/constants/colors.dart';

/// Add horizontal space in a row with the specified size (width)
Widget horizontalSpace(double size) => SizedBox(
      width: size,
    );

/// Add vertical space in a row with the specified size (height)
Widget verticalSpace(double size) => SizedBox(
      height: size,
    );

/// Navigating to specified route
pushPage(BuildContext context, {required Widget to}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => to),
    );

/// Popping the current route page
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
        textAlign: TextAlign.center,
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

  /// Showing success overlay modal toast
  static void success(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      success: true,
    );
  }

  /// Showing error overlay modal toast
  static void error(BuildContext context, String error) {
    showMessage(
      context,
      message: error,
      success: false,
    );
  }
}
