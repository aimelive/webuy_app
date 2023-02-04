import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/authentication/forgot_password/forgot_password.dart';

class ForgotPwdButton extends StatelessWidget {
  const ForgotPwdButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (_) => const ForgotPasswordView(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password",
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6574FF),
            ),
          ),
        ),
      ),
    );
  }
}
