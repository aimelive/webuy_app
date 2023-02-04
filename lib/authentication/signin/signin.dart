import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validators/form_validators.dart';
import 'package:webuy_app/authentication/google_signin/google_signin_button.dart';
import 'package:webuy_app/authentication/signin/button.dart';
import 'package:webuy_app/authentication/signin/forgot_pwd_button.dart';
import 'package:webuy_app/authentication/signin/or_divider.dart';

import 'email_field.dart';
import 'password_field.dart';
import 'controller/signin_controller.dart';
import '../../components/loading_error.dart';

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(signInProvider, (previous, current) {
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
      children: [
        const EmailField(),
        SizedBox(height: 16.h),
        const PasswordField(),
        const ForgotPwdButton(),
        SizedBox(height: 24.h),
        const SignInButton(),
        const OrDivider(),
        const GoogleSignInButton()
      ],
    );
  }
}
