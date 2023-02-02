import 'package:flutter/material.dart';
import 'package:webuy_app/authentication/signin/signin.dart';
import 'package:webuy_app/authentication/signup/signup.dart';
import 'package:webuy_app/components/animated_shape/animated_shape.dart';
import 'package:webuy_app/components/auth_switch_button.dart';
import 'package:webuy_app/components/slide_fade_switcher.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  bool _showSignIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 250, 16, 0),
            child: SlideFadeSwitcher(child: _showSignIn ? const SignIn() : const SignUp()),
          ),
          AnimatedShape(
            color: const Color(0xFF595DC6),
            show: _showSignIn,
            title: "Create Account",
          ),
          AnimatedShape(
            color: const Color(0xFFFC5F8E),
            show: !_showSignIn,
            title: "Welcome Back",
          ),
          AuthSwitchButton(
            onTap: () {
              setState(() {
                _showSignIn = !_showSignIn;
              });
            },
            showSignIn: _showSignIn,
          )
        ],
      ),
    );
  }
}
