import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/authentication/signin/or_divider.dart';
import 'package:webuy_app/components/back_button.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/constants/shared.dart';

import '../../authentication/controller/authentication_controller.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider.notifier);
    final authUser = ref.watch(authProvider).user;

    return Scaffold(
      body: Column(
        children: [
          const GoBackButton(),
          verticalSpace(150.h),
          if (authUser.name != null) Text("Name: ${authUser.name}"),
          if (authUser.email != null) Text("Email: ${authUser.email}"),
          verticalSpace(20.h),
          ElevatedButton(
            onPressed: () {
              authController.onSignOut();
              popPage(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              elevation: 0.0,
            ),
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
