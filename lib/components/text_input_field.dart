import 'package:flutter/material.dart';
import 'package:webuy_app/components/size_fade_switcher.dart';
import 'package:webuy_app/constants/colors.dart';

class TextInputField extends StatefulWidget {
  final String hintText;
  final void Function(String value) onChanged;
  final String? errorText;
  final bool obsecureText;
  const TextInputField({
    super.key,
    this.errorText,
    required this.hintText,
    this.obsecureText = false,
    required this.onChanged,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 16, right: widget.obsecureText ? 0 : 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD0D0D0), width: 1.5),
          ),
          child: TextField(
            cursorColor: grey,
            onChanged: widget.onChanged,
            obscureText: widget.obsecureText && !showText,
            decoration: InputDecoration(
              suffixIcon: widget.obsecureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showText = !showText;
                        });
                      },
                      child: Icon(
                        !showText ? Icons.remove_red_eye : Icons.visibility_off,
                        color: grey,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFC2C2C2),
              ),
            ),
          ),
        ),
        SizeFadeSwitcher(
            child: widget.errorText != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                    child: Text(
                      widget.errorText!,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  )
                : const SizedBox.shrink())
      ],
    );
  }
}
