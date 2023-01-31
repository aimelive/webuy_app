import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:webuy_app/authentication/forgot_password/controller/forgot_password_controller.dart';
import 'package:webuy_app/components/loading_error.dart';
import 'package:webuy_app/components/text_input_field.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: status.isSubmissionInProgress
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: status.isSubmissionInProgress ||
                            status.isSubmissionSuccess
                        ? null
                        : () {
                            ref
                                .read(forgotPasswordProvider.notifier)
                                .forgotPassword();
                          },
                    child: Text(_getButtonText(status)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
