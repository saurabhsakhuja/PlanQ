import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CircuitButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool isGradientReverse;

  const CircuitButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.width,
    this.height = 60,
    this.isGradientReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstant.buttonGradient2Color,
            ColorConstant.buttonGradient1Color,
          ],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(50),
      ),
      child: Container(
         padding: const EdgeInsets.all( 1),
     
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(50),
            color: Colors.white.withOpacity(.3)),
        child: Container(
          height: height,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstant.buttonGradient2Color,
                ColorConstant.buttonGradient1Color,
              ],
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                color: Colors.white.withOpacity(.1)),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashColor: Colors.transparent,
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                child: Padding(
                  padding:
                      padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
