import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/animated_button.dart';
import 'controller/google_signin_controller.dart';
import '../../components/loading_error.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GoogleSignInState>(googleSignInProvider, (prev, current) {
      if (current == GoogleSignInState.loading) {
        LoadingSheet.show(context);
      } else if (current == GoogleSignInState.error) {
        Navigator.pop(context);
        ErrorDialog.show(context, "Google SignIn Failed");
      } else {
        Navigator.pop(context);
      }
    });
    return AnimatedButton(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.2), width: 1.5),
        ),
        child: const Text(
          "Sign In With Google",
          style: TextStyle(
              color: Color(0xFF9A9A9A),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      onTap: () {
        ref.read(googleSignInProvider.notifier).signInWithGoogle();
      },
    );
  }
}
