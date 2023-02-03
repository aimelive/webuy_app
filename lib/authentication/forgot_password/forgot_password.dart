import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validators/form_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/authentication/forgot_password/controller/forgot_password_controller.dart';
import 'package:webuy_app/components/back_button.dart';
import 'package:webuy_app/components/loading_error.dart';
import 'package:webuy_app/components/text_input_field.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/constants/shared.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  String _getButtonText(FormzStatus status) {
    if (status.isSubmissionInProgress) {
      return "Requesting";
    } else if (status.isSubmissionFailure) {
      return "Failed";
    } else if (status.isSubmissionSuccess) {
      return "Done ✅";
    } else {
      return "Request";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPaswordState = ref.watch(forgotPasswordProvider);
    final status = forgotPaswordState.status;

    ref.listen<ForgotPaswordState>(forgotPasswordProvider, (prev, current) {
      if (current.status.isSubmissionFailure) {
        Navigator.pop(context);
        ErrorDialog.show(context, "${current.errorMessage}");
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              const GoBackButton(),
              verticalSpace(200.h),
              TextInputField(
                hintText: "Please enter your Email",
                errorText:
                    Email.showEmailErrorMessage(forgotPaswordState.email.error),
                onChanged: (email) {
                  ref
                      .read(forgotPasswordProvider.notifier)
                      .onEmailChange(email);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0.0,
                  foregroundColor: white,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                onPressed:
                    status.isSubmissionInProgress || status.isSubmissionSuccess
                        ? null
                        : () {
                            ref
                                .read(forgotPasswordProvider.notifier)
                                .forgotPassword();
                          },
                child: Text(
                  _getButtonText(status).toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
