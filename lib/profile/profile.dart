import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webuy_app/authentication/controller/authentication_controller.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider.notifier);
    final authUser = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("WeBuy Application"),
        backgroundColor: Colors.grey.shade400,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User Id: ${authUser.id}"),
            Text("User Email ${authUser.email}"),
            Text("Email Verified ${authUser.emailVerified}"),
            TextButton(
              onPressed: () {
                authController.onSignOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
