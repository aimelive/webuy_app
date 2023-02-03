import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/constants/colors.dart';

class DarkModeNotifier extends StateNotifier<ThemeMode> {
  DarkModeNotifier() : super(ThemeMode.system);

  // bool get isDarkTheme {
  //   final brightness = SchedulerBinding.instance.window.platformBrightness;
  //   if (state == ThemeMode.system && brightness == Brightness.dark) {
  //     return true;
  //   } else if (state == ThemeMode.system) {
  //     return false;
  //   }
  //   return state == ThemeMode.dark;
  // }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider = StateNotifierProvider<DarkModeNotifier, ThemeMode>(
  (ref) => DarkModeNotifier(),
);

class MyThemes {
  //Dark theme
  static final darkTheme = ThemeData(
    textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
    canvasColor: Colors.grey.shade900,
    cardColor: Colors.grey.shade700,
    backgroundColor: Colors.grey.shade700,
    errorColor: Colors.redAccent,
    shadowColor: Colors.grey.shade700.withOpacity(0.4),
    selectedRowColor: Colors.black.withOpacity(0.6),
    bottomAppBarColor: const Color(0xFF913175),
    secondaryHeaderColor: Colors.blue.shade900,
    colorScheme: const ColorScheme.dark(),
  );

  //Light theme
  static final lightTheme = ThemeData(
    textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
    canvasColor: const Color(0xFFF2F2F3),
    cardColor: white,
    shadowColor: Colors.grey.shade300,
    backgroundColor: const Color(0xFFF2F2F3),
    selectedRowColor: Colors.white.withOpacity(0.8),
    bottomAppBarColor: const Color(0xFFFC5F8E),
    secondaryHeaderColor: const Color(0xFF595DC6),
    colorScheme: const ColorScheme.light(),
  );
}
