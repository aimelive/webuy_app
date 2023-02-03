import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/screens/home/home.dart';

import 'authentication/authentication_view.dart';
import 'authentication/controller/authentication_controller.dart';
import 'constants/themes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);
    ThemeMode themeMode = ref.watch(themeModeProvider);

    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      themeMode =
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    Widget getHome() {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        return const Home();
      } else {
        return const AuthenticationView();
      }
    }

    return ScreenUtilInit(
      designSize: const Size(375, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: child,
        );
      },
      child: getHome(),
    );
  }
}
