import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Text(
            "OR",
            style: TextStyle(color: Colors.black.withOpacity(0.4)),
          ),
          Expanded(child: Divider())
        ],
      ),
    );
  }
}
