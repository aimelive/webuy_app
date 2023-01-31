import 'package:flutter/material.dart';

class SizeFadeSwitcher extends StatelessWidget {
  final Widget child;
  const SizeFadeSwitcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: ((child, animation) {
        final sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5),
          ),
        );

        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: SizeTransition(
            sizeFactor: sizeAnimation,
            child: child,
          ),
        );
      }),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
