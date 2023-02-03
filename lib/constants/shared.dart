import 'package:flutter/material.dart';

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
