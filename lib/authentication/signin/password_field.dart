import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';

import '../../components/text_input_field.dart';
import 'controller/signin_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final bool showError = signInState.password.invalid;
    final signInController = ref.read(signInProvider.notifier);

    return TextInputField(
      hintText: "Password",
      obsecureText: true,
      errorText: showError
          ? Password.showPasswordErrorMessage(signInState.password.error)
          : null,
      onChanged: (pwd) => signInController.onPasswordChange(pwd),
    );
  }
}
