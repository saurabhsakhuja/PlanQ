import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CommonSubmitButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height; // Added height property

  const CommonSubmitButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.width,
    this.height, // Added this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstant.buttonBorderGradient1Color,
            ColorConstant.buttonBorderGradient2Color,
            ColorConstant.buttonBorderGradient3Color,
          ],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        height: height, // Use height if provided
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorConstant.buttonGradient1Color,
              ColorConstant.buttonGradient2Color,
            ],
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
            child: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
