import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CommonSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const CommonSubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorConstant.buttonGradient1,
            ColorConstant.buttonGradient2
          ],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(50),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              text,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
