import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  const AnimatedButton({super.key, required this.child, required this.onTap});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap != null
          ? (_) {
              _animationController.forward();
            }
          : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _animationController.reverse();
            }
          : null,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Transform.scale(
              scale: _animation.value,
              child: widget.child,
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
