import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Text(
            "OR",
            style: TextStyle(color: Colors.black.withOpacity(0.4)),
          ),
          const Expanded(child: Divider())
        ],
      ),
    );
  }
}
