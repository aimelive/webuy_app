import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:webuy_app/authentication/signup/button.dart';
import 'package:webuy_app/authentication/signup/email_field.dart';
import 'package:webuy_app/authentication/signup/name_field.dart';
import 'package:webuy_app/authentication/signup/password_field.dart';

import 'controller/signup_controller.dart';
import '../../components/loading_error.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpProvider, (previous, current) {
      if (current.status.isSubmissionInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isSubmissionFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSubmissionSuccess) {
        Navigator.of(context).pop();
      }
    });
    return Column(
      children: const [
        NameField(),
        SizedBox(height: 16),
        EmailField(),
        SizedBox(height: 16),
        PasswordField(),
        SizedBox(height: 24),
        SignUpButton(),
      ],
    );
  }
}
