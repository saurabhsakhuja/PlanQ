import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final double? borderRadius;
  final TextStyle? textStyle;
  final VoidCallback? toggleObscure;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.toggleObscure,
    this.textStyle,
    this.onChanged,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: ColorConstant.textFieldBg,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: Colors.white,
        style: textStyle ??
            Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorConstant.whiteColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xff8D8D8D), fontSize: 12),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: toggleObscure != null
              ? GestureDetector(
                  onTap: toggleObscure,
                  child: obscureText
                      ? Assets.images.visibilityOffIcon.image(scale: 1.5)
                      : Assets.images.visibilityIocn.image(scale: 1.5),
                )
              : null,
        ),
      ),
    );
  }
}
